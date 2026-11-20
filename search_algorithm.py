sql = r"""
            WITH raw_input AS MATERIALIZED (
                SELECT $1::text AS query
            ),
            search_input AS MATERIALIZED (
                SELECT
                    query,
                    normalize_arabic(query) AS query_norm,
                    arabic_consonant_key(query) AS query_consonant
                FROM raw_input
            ),
            escaped_input AS MATERIALIZED (
                SELECT
                    query,
                    query_norm,
                    query_consonant,
                    replace(
                        replace(replace(query_norm, E'\\', E'\\\\'), '%', E'\\%'),
                        '_', E'\\_'
                    ) AS escaped_norm,
                    replace(
                        replace(replace(query_consonant, E'\\', E'\\\\'), '%', E'\\%'),
                        '_', E'\\_'
                    ) AS escaped_consonant
                FROM search_input
                WHERE query_norm <> ''
            ),
            candidates AS (
                -- 1. Exact match
                SELECT p.product_id, q.query AS search_query,
                       p.product_name_ar, p.product_name_ar_norm,
                       p.product_name_ar_consonant,
                       'exact'::text AS match_type, 1000::numeric AS ranking_score
                FROM product.product p
                CROSS JOIN escaped_input q
                WHERE p.product_name_ar_norm = q.query_norm

                UNION ALL

                -- 2. Prefix match (whole word)
                SELECT p.product_id, q.query,
                       p.product_name_ar, p.product_name_ar_norm,
                       p.product_name_ar_consonant,
                       'prefix', 900::numeric
                FROM product.product p
                CROSS JOIN escaped_input q
                WHERE p.product_name_ar_norm LIKE q.escaped_norm || '%' ESCAPE E'\\'
                  AND (
                      char_length(p.product_name_ar_norm) = char_length(q.query_norm)
                      OR substring(p.product_name_ar_norm FROM char_length(q.query_norm) + 1 FOR 1)
                         ~ '^[[:space:][:punct:]]$'
                  )

                UNION ALL

                -- 3. Consonant exact match
                SELECT p.product_id, q.query,
                       p.product_name_ar, p.product_name_ar_norm,
                       p.product_name_ar_consonant,
                       'consonant_exact', 850::numeric
                FROM product.product p
                CROSS JOIN escaped_input q
                WHERE p.product_name_ar_consonant = q.query_consonant
                  AND q.query_consonant <> ''

                UNION ALL

                -- 4. Substring match (whole-word boundaries)
                SELECT p.product_id, q.query,
                       p.product_name_ar, p.product_name_ar_norm,
                       p.product_name_ar_consonant,
                       'substring', 800::numeric
                FROM product.product p
                CROSS JOIN escaped_input q
                WHERE p.product_name_ar_norm
                        LIKE '%' || q.escaped_norm || '%' ESCAPE '\'
                  AND (
                      strpos(p.product_name_ar_norm, q.query_norm) = 1
                      OR substring(
                          p.product_name_ar_norm
                          FROM strpos(p.product_name_ar_norm, q.query_norm) - 1 FOR 1
                      ) ~ '^[[:space:][:punct:]]$'
                  )
                  AND (
                      strpos(p.product_name_ar_norm, q.query_norm) + char_length(q.query_norm)
                          > char_length(p.product_name_ar_norm)
                      OR substring(
                          p.product_name_ar_norm
                          FROM strpos(p.product_name_ar_norm, q.query_norm) + char_length(q.query_norm)
                          FOR 1
                      ) ~ '^[[:space:][:punct:]]$'
                  )

                UNION ALL

                -- 5. Consonant prefix match
                SELECT p.product_id, q.query,
                       p.product_name_ar, p.product_name_ar_norm,
                       p.product_name_ar_consonant,
                       'consonant_prefix',
                       (700 + 100 * word_similarity(q.query_norm, p.product_name_ar_norm))::numeric
                FROM product.product p
                CROSS JOIN escaped_input q
                WHERE q.query_consonant <> ''
                  AND p.product_name_ar_consonant LIKE q.escaped_consonant || '%' ESCAPE E'\\'
                  AND (
                      char_length(p.product_name_ar_consonant) = char_length(q.query_consonant)
                      OR substring(
                          p.product_name_ar_consonant
                          FROM char_length(q.query_consonant) + 1 FOR 1
                      ) ~ '^[[:space:][:punct:]]$'
                  )

                UNION ALL

                -- 6. Consonant substring match
                SELECT p.product_id, q.query,
                       p.product_name_ar, p.product_name_ar_norm,
                       p.product_name_ar_consonant,
                       'consonant_substring', 740::numeric
                FROM product.product p
                CROSS JOIN escaped_input q
                WHERE q.query_consonant <> ''
                  AND p.product_name_ar_consonant
                      LIKE '%' || q.escaped_consonant || '%' ESCAPE E'\\'

                UNION ALL

                -- 7. Consonant fuzzy match
                SELECT p.product_id, q.query,
                       p.product_name_ar, p.product_name_ar_norm,
                       p.product_name_ar_consonant,
                       'consonant_fuzzy',
                       (600 + 100 * word_similarity(
                           q.query_consonant, p.product_name_ar_consonant
                       ))::numeric
                FROM product.product p
                CROSS JOIN escaped_input q
                WHERE q.query_consonant <> ''
                  AND p.product_name_ar_consonant %> q.query_consonant

                UNION ALL

                -- 8. Original Arabic fuzzy match
                SELECT p.product_id, q.query,
                       p.product_name_ar, p.product_name_ar_norm,
                       p.product_name_ar_consonant,
                       'arabic_fuzzy',
                       (500 + 100 * word_similarity(
                           q.query_norm, p.product_name_ar_norm
                       ))::numeric
                FROM product.product p
                CROSS JOIN escaped_input q
                WHERE p.product_name_ar_norm %> q.query_norm
            ),
            ranked AS (
                SELECT *,
                       ROW_NUMBER() OVER (
                           PARTITION BY search_query, product_id
                           ORDER BY ranking_score DESC, match_type
                       ) AS candidate_rank
                FROM candidates
            ),
            deduplicated AS (
                SELECT *
                FROM ranked
                WHERE candidate_rank = 1
            ),
            diagnostics AS (
                SELECT
                    c.*,
                    x.best_token,
                    x.edit_distance,
                    x.edit_similarity,
                    word_similarity(q.query_consonant, c.product_name_ar_consonant)
                        AS consonant_similarity
                FROM deduplicated c
                JOIN search_input q ON q.query = c.search_query
                CROSS JOIN LATERAL (
                    SELECT
                        token AS best_token,
                        levenshtein(q.query_norm, token) AS edit_distance,
                        1.0 - (
                            levenshtein(q.query_norm, token)::numeric
                            / NULLIF(
                                GREATEST(char_length(q.query_norm), char_length(token)),
                                0
                            )
                        ) AS edit_similarity
                    FROM regexp_split_to_table(
                        c.product_name_ar_norm, '[[:space:][:punct:]/]+'
                    ) AS token
                    WHERE token <> ''
                    ORDER BY
                        edit_similarity DESC,
                        edit_distance ASC,
                        char_length(token) ASC
                    LIMIT 1
                ) x
            ),
            stage_priority AS (
                SELECT *,
                       CASE match_type
                           WHEN 'exact' THEN 1
                           WHEN 'prefix' THEN 2
                           WHEN 'consonant_exact' THEN 3
                           WHEN 'substring' THEN 4
                           WHEN 'consonant_prefix' THEN 5
                           WHEN 'consonant_substring' THEN 6
                           WHEN 'consonant_fuzzy' THEN 7
                           WHEN 'arabic_fuzzy' THEN 8
                           ELSE 99
                       END AS stage_order
                FROM diagnostics
            ),
            final_ranking AS (
                SELECT *,
                       ROW_NUMBER() OVER (
                           PARTITION BY search_query
                           ORDER BY
                               stage_order ASC,
                               edit_distance ASC,
                               edit_similarity DESC,
                               consonant_similarity DESC,
                               product_id ASC
                       ) AS new_rank
                FROM stage_priority
            ),
            top_candidates AS MATERIALIZED (
                SELECT *
                FROM final_ranking
                WHERE new_rank <= 10
            )
            SELECT
                tc.product_id,
                pp.item_code,
                pp.product_name_en,
                tc.product_name_ar,
                pc.currency,
                pi.has_active_offer,
                pi.package_price,
                pp.units_per_package,
                pp.is_controlled,
                pp.package_type,
                pp.unit_type,
                pi.unit_price,
                pp.is_sellable_online,
                pi.policy_category,
                pi.quantity_available,
                CASE
                    WHEN pi.promotion_id IS NOT NULL THEN
                        json_build_object(
                            'promotion_id', pi.promotion_id,
                            'promotion_description', pop.promotion_description,
                            'promotion_type', pr.promotion_type,
                            'buy_quantity', pr.buy_quantity,
                            'reward_quantity', pr.reward_quantity,
                            'discount_percent', pr.discount_percent
                        )
                    ELSE NULL
                END AS promotion,
                ps.signature_id,
                ps.signature,
                pi.expiry_date AS nearest_expiry,
                tc.ranking_score AS relevance_score
            FROM top_candidates tc
            JOIN product.product pp ON pp.product_id = tc.product_id
            JOIN inventory.product_inventory pi
              ON pi.product_id = tc.product_id
             AND NOT pi.is_deleted
            LEFT JOIN product.product_catalog pc ON pc.product_id = tc.product_id
            LEFT JOIN product.product_signature ps ON ps.signature_id = pp.signature_id
            LEFT JOIN promotion.promotion pop ON pop.promotion_id = pi.promotion_id
            LEFT JOIN promotion.promotion_rule pr ON pr.promotion_id = pop.promotion_id
            ORDER BY tc.new_rank ASC;
        """
