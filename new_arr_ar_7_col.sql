-- Schema including ALL original fields from sales.new_arrival + classification metadata
CREATE TABLE cosmeceutical_product_classification_full (
    code INT PRIMARY KEY,
    name_en VARCHAR(255) NOT NULL,
    name_ar VARCHAR(255) NOT NULL,
    price_1 DECIMAL(10, 2) NOT NULL,
    price_2 DECIMAL(10, 2) NOT NULL,
    category VARCHAR(100) NOT NULL,
    supplier VARCHAR(100) NOT NULL,
    domain VARCHAR(100) NOT NULL,
    subcategory VARCHAR(100) NOT NULL,
    reason TEXT NOT NULL,
    review_required BOOLEAN NOT NULL DEFAULT FALSE
);

-- Insert all batch items without excluding any input fields
INSERT INTO cosmeceutical_product_classification_full (
    code, name_en, name_ar, price_1, price_2, category, supplier,
    domain, subcategory, reason, review_required
) VALUES
(
    32601, 
    'VICHY NORMADERM CLEANSING GEL 400ML', 
    'فيشي نورماديرم غسول جل 400 مل', 
    1140.00, 1140.00, 'COSMO-MI', 'FRANCE',
    'Skin_Cleansing', 
    'purifying_cleansing_gel', 
    'Purifying foaming cleansing gel formulated for oily and acne-prone skin.', 
    FALSE
),
(
    32761, 
    'VICHY NORMADERM DOUBLE CORRECTION 50ML', 
    'فيشي نورماديرم دبل كوركشن كريم تصحيح مزدوج 50 مل', 
    1000.00, 1000.00, 'COSMO-MI', 'FRANCE',
    'Acne_Oil_Control', 
    'acne_blemish_treatment', 
    'Daily moisturizer targeting blemishes, acne marks, and skin imperfections.', 
    FALSE
),
(
    21317, 
    'VICHY NORMADERM PHYTO SOLUTION GEL 200ML', 
    'فيشي نورماديرم فايتو سوليوشن غسول جل 200 مل', 
    800.00, 800.00, 'COSMO-MI', 'FRANCE',
    'Skin_Cleansing', 
    'purifying_cleansing_gel', 
    'Plant-based purifying cleansing gel designed to eliminate excess sebum and impurities.', 
    FALSE
),
(
    97413, 
    'VICHY ROLL DEO BEAUTY FOR WOMAN 48H 50ML', 
    'فيشي بيوتي نسائي مزيل عرق رول أون 48 ساعة 50 مل', 
    790.00, 790.00, 'COSMO-MI', 'FRANCE',
    'Specialized_Body_Care', 
    'antiperspirant_deodorant', 
    'Anti-perspirant roll-on deodorant formulated for women with 48-hour odor protection.', 
    FALSE
),
(
    97069, 
    'VICHY ROLL DEO INTENSE 48H النهي', 
    'فيشي إنتنس مزيل عرق رول أون 48 ساعة 50 مل', 
    790.00, 790.00, 'COSMO-MI', 'FRANCE',
    'Specialized_Body_Care', 
    'antiperspirant_deodorant', 
    'High-efficacy anti-perspirant roll-on deodorant for intense sweat regulation.', 
    FALSE
),
(
    140370, 
    'VICHY ROLL DEO INVISIBLE RESIST 72H 50ML حماية رصاصي', 
    'فيشي إنفيسيبل ريزيست مزيل عرق رول أون 72 ساعة 50 مل حماية رصاصي', 
    790.00, 790.00, 'COSMO-MI', 'FRANCE',
    'Specialized_Body_Care', 
    'antiperspirant_deodorant', 
    '72-hour roll-on deodorant designed to prevent white and yellow stains on clothing.', 
    FALSE
),
(
    21086, 
    'VICHY ROLL DEO MAN 72H 50ML أسود', 
    'فيشي مان رجالي مزيل عرق رول أون 72 ساعة 50 مل أسود', 
    790.00, 790.00, 'COSMO-MI', 'FRANCE',
    'Specialized_Body_Care', 
    'antiperspirant_deodorant', 
    'Men anti-perspirant roll-on providing extended 72-hour perspiration control.', 
    FALSE
),
(
    140371, 
    'VICHY ROLL DEO SENSITIVE SKIN 48H 50ML بشرة حساسة', 
    'فيشي للبشرة الحساسة مزيل عرق رول أون 48 ساعة 50 مل', 
    790.00, 790.00, 'COSMO-MI', 'FRANCE',
    'Specialized_Body_Care', 
    'antiperspirant_deodorant', 
    'Hypoallergenic anti-perspirant roll-on tailored for sensitive underarm skin.', 
    FALSE
),
(
    97070, 
    'VICHY ROLL DEO STRESS RESist 72H 50ML أحمر', 
    'فيشي ستريس ريزيست مزيل عرق رول أون 72 ساعة 50 مل أحمر', 
    790.00, 790.00, 'COSMO-MI', 'FRANCE',
    'Specialized_Body_Care', 
    'antiperspirant_deodorant', 
    'Stress-response anti-perspirant controlling heavy perspiration during intense situations.', 
    FALSE
),
(
    95647, 
    'VICHY SPRAY MINERAL THERMAL WATER 150ML #C#', 
    'فيشي مياه معدنية حرارية بخاخ 150 مل #C#', 
    650.00, 650.00, 'COSMO-MI', 'FRANCE',
    'Specialized_Care', 
    'soothing_thermal_water', 
    'Pure thermal spring water spray for soothing and fortifying sensitive skin.', 
    FALSE
),
(
    25708, 
    'VICHY CAPITAL SOLEIL FLUID SOLEIL UV AGE SPF50 40ML', 
    'فيشي كابيتال سوليل يو في إيدج فلويد واقي شمس SPF50 بحجم 40 مل', 
    1220.00, 1220.00, 'COSMO-MI', 'FRANCE',
    'Sun_Protection', 
    'anti_aging_sunscreen_fluid', 
    'Fluid facial sunscreen with SPF50 targeting photoaging and UV damage.', 
    FALSE
),
(
    8338, 
    'VICHY NORMADERM 3IN1 MICELLAR SOLUTION 200ML', 
    'فيشي نورماديرم 3 في 1 محلول ميسيلار 200 مل', 
    700.00, 700.00, 'COSMO-MI', 'FRANCE',
    'Skin_Cleansing', 
    'micellar_cleansing_water', 
    'Multi-action micellar solution for cleansing blemish-prone, oily skin.', 
    FALSE
),
(
    95648, 
    'VICHY PURET THERMAL MICELLAR WATER 200ML', 
    'فيشي بيورتيه تيرمال محلول ميسيلار 200 مل', 
    699.00, 699.00, 'COSMO-MI', 'FRANCE',
    'Skin_Cleansing', 
    'micellar_cleansing_water', 
    'Gentle micellar cleansing water for makeup removal and daily cleansing.', 
    FALSE
),
(
    134226, 
    'VICHY CAPITAL SOLEIL SPF50 TAN 200ML SOLAR PROTECT WATER', 
    'فيشي كابيتال سوليل واقي شمس مائي للتسمير SPF50 بحجم 200 مل', 
    1850.00, 1850.00, 'COSMO-MI', 'FRANCE',
    'Sun_Protection', 
    'body_sunscreen_water', 
    'Bi-phase protective solar water with SPF50 that enhances natural tanning.', 
    FALSE
),
(
    134228, 
    'VICHY CAPITAL SOLEIL SPF50 HYDRAT 200ML SOLAR PROTECT WATER', 
    'فيشي كابيتال سوليل واقي شمس مائي مرطب SPF50 بحجم 200 مل', 
    1850.00, 1850.00, 'COSMO-MI', 'FRANCE',
    'Sun_Protection', 
    'body_sunscreen_water', 
    'Refreshing, hydrating solar protect water spray providing broad SPF50 coverage.', 
    FALSE
),
(
    102143, 
    'VICHY CAPITAL SOLIE BRUME 200ML SPF50', 
    'فيشي كابيتال سوليل بخاخ واقي شمس SPF50 بحجم 200 مل', 
    1220.00, 1220.00, 'COSMO-MI', 'COSMETICS',
    'Sun_Protection', 
    'sunscreen_spray_mist', 
    'Invisible protective mist spray providing SPF50 sun protection.', 
    FALSE
),
(
    144402, 
    'VICHY CAPITAL SOLEIL UA AQUA SPF50 50ML', 
    'فيشي كابيتال سوليل أكوا واقي شمس SPF50 بحجم 50 مل', 
    1090.00, 1090.00, 'COSMO-MI', 'FRANCE',
    'Sun_Protection', 
    'facial_sunscreen_fluid', 
    'Ultra-light aqueous facial sunscreen providing broad-spectrum SPF50 defense.', 
    FALSE
),
(
    118585, 
    'VICHY CAPITAL SOLEIL(TINTED)FLUID AGE SPF50 40ML', 
    'فيشي كابيتال سوليل فلويد ملون واقي شمس إيدج SPF50 بحجم 40 مل', 
    1220.00, 1220.00, 'COSMO-MI', 'FRANCE',
    'Sun_Protection', 
    'tinted_anti_aging_sunscreen', 
    'Tinted anti-aging fluid facial sunscreen offering high UV protection and coverage.', 
    FALSE
),
(
    102433, 
    'VICHY CAPITAL SOLEIL ANTIDARK SPOTS TINTED SPF50 50ML', 
    'فيشي كابيتال سوليل مضاد البقع الداكنة ملون واقي شمس SPF50 بحجم 50 مل', 
    1100.00, 1100.00, 'COSMO-MI', 'FRANCE',
    'Sun_Protection', 
    'tinted_pigmentation_sunscreen', 
    'Tinted facial sunscreen targeted at reducing dark spots along with SPF50 defense.', 
    FALSE
),
(
    95654, 
    'VICHY CAPITAL SOLEIL DRY TOUCH SPF50 50ML عرض كود', 
    'فيشي كابيتال سوليل دراي توش كريم واقي شمس ملمس جاف SPF50 بحجم 50 مل عرض كود', 
    1110.00, 1110.00, 'COSMO-MI', 'FRANCE',
    'Sun_Protection', 
    'mattifying_facial_sunscreen', 
    'Dry-touch mattifying facial sunscreen with high SPF50 for combination to oily skin.', 
    FALSE
),
(
    104636, 
    'VICHY CAPITAL SOLEIL TINTED DRY TOUCH SPF50 50ML', 
    'فيشي كابيتال سوليل دراي توش ملون واقي شمس ملمس جاف SPF50 بحجم 50 مل', 
    1110.00, 1110.00, 'COSMO-MI', 'FRANCE',
    'Sun_Protection', 
    'tinted_mattifying_sunscreen', 
    'Tinted dry-touch sunscreen providing matte sun protection and blemish coverage.', 
    FALSE
),
(
    97064, 
    'VICHY CAPITAL SOLEIL VELVETY CREAM SPF50 50ML #C#', 
    'فيشي كابيتال سوليل فيلفتي كريم واقي شمس مخملي SPF50 بحجم 50 مل #C#', 
    998.00, 998.00, 'COSMO-MI', 'FRANCE',
    'Sun_Protection', 
    'hydrating_facial_sunscreen', 
    'Velvety moisturizing cream facial sunscreen with SPF50 for normal to dry skin.', 
    FALSE
),
(
    140983, 
    'VICHY DERCOS AMINEXIL(R.E.G.E.N)BOOSTER 90ML', 
    'فيشي ديركوس أمينكسيل ريجين بوستر معالج للشعر 90 مل', 
    2700.00, 2700.00, 'COSMO-MI', 'FRANCE',
    'Hair_Scalp_Care', 
    'anti_hair_loss_treatment', 
    'Scalp treatment booster with Aminexil to strengthen hair fiber and target loss.', 
    FALSE
),
(
    138139, 
    'VICHY DERCOS ANTI DAND SHAM OILY 390ML كيس', 
    'فيشي ديركوس شامبو ضد القشرة للشعر الدهني عبوة كيس 390 مل', 
    1180.00, 1180.00, 'COSMO-MI', 'FRANCE',
    'Hair_Scalp_Care', 
    'anti_dandruff_shampoo', 
    'Anti-dandruff cleanser formulated specifically for oily scalps.', 
    FALSE
),
(
    97066, 
    'VICHY DERCOS ANTI DANDRUFF SHAMP DRY HAIR 200ML', 
    'فيشي ديركوس شامبو ضد القشرة للشعر الجاف 200 مل', 
    800.00, 800.00, 'COSMO-MI', 'FRANCE',
    'Hair_Scalp_Care', 
    'anti_dandruff_shampoo', 
    'Targeted anti-dandruff shampoo formulated for dry hair and scalps.', 
    FALSE
),
(
    97067, 
    'VICHY DERCOS ANTI DANDRUFF SHAMP OILY HAIR 200ML', 
    'فيشي ديركوس شامبو ضد القشرة للشعر الدهني 200 مل', 
    800.00, 800.00, 'COSMO-MI', 'FRANCE',
    'Hair_Scalp_Care', 
    'anti_dandruff_shampoo', 
    'Anti-dandruff shampoo designed to clear flakes and balance oily scalp.', 
    FALSE
),
(
    146506, 
    'VICHY DERCOS DENSI KIT(SHA 250ML+SPRAY 100ML+BALM 200ML)', 
    'فيشي ديركوس دينسي مجموعة تكثيف الشعر (شامبو 250 مل + بخاخ 100 مل + بلسم 200 مل)', 
    3105.00, 3105.00, 'COSMO-MI', 'FRANCE',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Multi-product promotional bundle set containing shampoo, leave-in spray, and balm.', 
    TRUE
),
(
    1704, 
    'VICHY DERCOS DENSI SOLU THICK SHAM 250ML', 
    'فيشي ديركوس دينسي سوليوشنز شامبو مكثف 250 مل', 
    880.00, 880.00, 'COSMO-MI', 'COSMETICS',
    'Hair_Scalp_Care', 
    'anti_hair_loss_shampoo', 
    'Thickening shampoo formulated to build volume and hair mass.', 
    FALSE
),
(
    85112, 
    'LA ROCHE-POSAY LIPIKAR BAUME(AP+M) BALM 200ML', 
    'لاروش بوزيه ليبيكار بلسم مرطب AP+M بحجم 200 مل', 
    1110.90, 1110.90, 'COSMO-MI', 'FRANCE',
    'Skin_Moisturization_Barrier', 
    'lipid_replenishing_balm', 
    'Lipid-replenishing body balm for extreme dryness and skin barrier repair.', 
    FALSE
),
(
    89741, 
    'LA ROCHE-POSAY LIPIKAR BAUME(AP+M) BALM 75ML', 
    'لاروش بوزيه ليبيكار بلسم مرطب AP+M بحجم 75 مل', 
    640.00, 640.00, 'COSMO-MI', 'FRANCE',
    'Skin_Moisturization_Barrier', 
    'lipid_replenishing_balm', 
    'Lipid-replenishing soothing balm in compact size for skin barrier restoration.', 
    FALSE
),
(
    39447, 
    'LA ROCHE-POSAY LIPIKAR BAUME(AP+M)BODYBALM 400ML', 
    'لاروش بوزيه ليبيكار بلسم مرطب للجسم AP+M بحجم 400 مل', 
    1270.00, 1270.00, 'COSMO-MI', 'FRANCE',
    'Skin_Moisturization_Barrier', 
    'lipid_replenishing_balm', 
    'Large family-size body balm for severe dryness and skin barrier support.', 
    FALSE
),
(
    118181, 
    'LA ROCHE-POSAYE LIPIKAR CREAM LIGHT(AP+M) 200ML #C#', 
    'لاروش بوزيه ليبيكار كريم مرطب خفيف AP+M بحجم 200 مل #C#', 
    1110.00, 1110.00, 'COSMO-MI', 'FRANCE',
    'Skin_Moisturization_Barrier', 
    'lightweight_barrier_moisturizer', 
    'Lightweight texture lipid-replenishing cream for daily barrier hydration.', 
    FALSE
),
(
    85110, 
    'LA ROCHE-POSAY LIPIKAR SYNDET(AP+)CREAM 200ML غسول', 
    'لاروش بوزيه ليبيكار سينديت كريم غسول AP+ بحجم 200 مل', 
    920.00, 920.00, 'COSMO-MI', 'FRANCE',
    'Skin_Cleansing', 
    'lipid_replenishing_cleanser', 
    'Ultra-gentle body and face cleansing cream-gel for extremely dry, irritated skin.', 
    FALSE
),
(
    88950, 
    'LA ROCHE-POSAY PIGMENTCLAR EYE ANTI DARK15ML #C#', 
    'لاروش بوزيه بيجمنكلار كريم مضاد للهالات السوداء للعين 15 مل #C#', 
    1020.00, 1020.00, 'COSMO-MI', 'FRANCE',
    'Specialized_Care', 
    'eye_contour_care', 
    'Targeted eye cream designed to diminish dark circles and brighten the eye zone.', 
    FALSE
),
(
    133019, 
    'LA ROCHE-POSAY DERMATOLOGY (GIFT) كود هدية', 
    'لاروش بوزيه منتج جلدي كود هدية', 
    0.01, 0.01, 'Hair Condit', 'COSMETICS',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Generic promotional gift item with placeholder pricing and non-specific formulation.', 
    TRUE
),
(
    24153, 
    'LA ROCHE-POSAY HYALU B5 SERUM 30ML', 
    'لاروش بوزيه هيالو بي 5 سيروم مرطب ومقاوم للتجاعيد 30 مل', 
    1430.00, 1430.00, 'COSMO-MI', 'FRANCE',
    'Skin_Moisturization_Barrier', 
    'barrier_repair_hydrator', 
    'Hyaluronic acid and Vitamin B5 serum designed for barrier repair and hydration.', 
    FALSE
),
(
    127316, 
    'LA ROCHE-POSAY MELA (B3) CREME SPF30 40ML', 
    'لاروش بوزيه ميلا بي 3 كريم مرطب ومصحح للبقع واقي شمس SPF30 بحجم 40 مل', 
    1480.00, 1480.00, 'COSMO-MI', 'FRANCE',
    'Pigmentation_Skin_Tone', 
    'pigmentation_day_cream', 
    'Corrective day moisturizer formulated with Melasyl and SPF30 for dark spots.', 
    FALSE
),
(
    127314, 
    'LA ROCHE-POSAY MELA (B3) GEL 200ML غسول', 
    'لاروش بوزيه ميلا بي 3 غسول جل منظف 200 مل', 
    930.00, 930.00, 'COSMO-MI', 'FRANCE',
    'Skin_Cleansing', 
    'brightening_cleansing_gel', 
    'Micro-peeling facial gel cleanser designed to brighten skin tone and smooth texture.', 
    FALSE
),
(
    127315, 
    'LLA ROCHE-POSAY MELA (B3) SERUM 30ML', 
    'لاروش بوزيه ميلا بي 3 سيروم مصحح للبقع الداكنة 30 مل', 
    1980.00, 1980.00, 'COSMO-MI', 'FRANCE',
    'Pigmentation_Skin_Tone', 
    'anti_pigmentation_serum', 
    'Intensive dark spot correcting serum formulated with Melasyl and Niacinamide.', 
    FALSE
),
(
    145097, 
    'LA ROCHE-POSAY MELA(B3)BODY 200ML عبوة DOUBLE ACTION', 
    'لاروش بوزيه ميلا بي 3 عبوة مزدوجة لترطيب العناية بالجسم 200 مل', 
    1250.00, 1250.00, 'COSMO-MI', 'FRANCE',
    'Specialized_Body_Care', 
    'body_pigmentation_treatment', 
    'Specialized body moisturizer formulated to correct hyperpigmentation on body skin.', 
    FALSE
),
(
    78011, 
    'LA ROCHE-POSAY SERUM RETINOL B3 30ML', 
    'لاروش بوزيه ريتينول بي 3 سيروم مجدد للبشرة 30 مل', 
    1590.00, 1590.00, 'COSMO-MI', 'FRANCE',
    'Anti_Aging_Skin_Rejuvenation', 
    'retinol_anti_aging_serum', 
    'Anti-aging serum with Retinol and Vitamin B3 to resurface and smooth fine lines.', 
    FALSE
),
(
    135181, 
    'LA ROCHE-POSAY SOOTH LOTION AFTER SUN 200ML', 
    'لاروش بوزيه لوشن مهدئ بعد التعرض للشمس 200 مل', 
    750.00, 750.00, 'COSMO-MI', 'FRANCE',
    'Specialized_Care', 
    'after_sun_soothing_lotion', 
    'After-sun hydrating body lotion to soothe sun-exposed and heated skin.', 
    FALSE
),
(
    4633, 
    'LA ROCHE-POSAY THERMAL WATER 150ML', 
    'لاروش بوزيه مياه معدنية حرارية 150 مل', 
    640.00, 640.00, 'COSMO-MI', 'FRANCE',
    'Specialized_Care', 
    'soothing_thermal_water', 
    'Soothes and refreshes sensitive or irritated skin with antioxidant mineral water.', 
    FALSE
),
(
    106921, 
    'LA ROCHE-POSAY TOLERIANE SENSITIVE CREME 40ML', 
    'لاروش بوزيه توليريان سنسيتيف كريم مرطب للبشرة الحساسة 40 مل', 
    970.00, 970.00, 'COSMO-MI', 'FRANCE',
    'Skin_Moisturization_Barrier', 
    'sensitive_skin_moisturizer', 
    'Prebiotic hydrating moisturiser that restores barrier function on sensitive skin.', 
    FALSE
),
(
    119234, 
    'LA ROCHE-POSAY RETINOL REDERMIC EYES 15ML', 
    'لاروش بوزيه ريتينول ريديرميك كريم مكافح لتجاعيد العين 15 مل', 
    970.00, 970.00, 'COSMO-MI', 'FRANCE',
    'Specialized_Care', 
    'eye_contour_care', 
    'Targeted retinol eye contour cream to smooth deep wrinkles and firm eye area.', 
    FALSE
),
(
    144401, 
    'LA ROCHE-POSAY MELA B3 EYES 15ML', 
    'لاروش بوزيه ميلا بي 3 كريم للعين ومصحح للهالات 15 مل', 
    1399.00, 1399.00, 'COSMO-MI', 'FRANCE',
    'Specialized_Care', 
    'eye_contour_care', 
    'Targeted eye care treatment formulated to reduce dark circles and hyperpigmentation.', 
    FALSE
),
INSERT INTO cosmeceutical_product_classification_full (
    code, name_en, name_ar, price_1, price_2, category, supplier,
    domain, subcategory, reason, review_required
) VALUES
(
    24587, 
    'VICHY DERCOS DENSI SOLUTIONS BALM 200ML', 
    'فيشي ديركوس دينسي سوليوشنز بلسم 200 مل', 
    880.00, 880.00, 'COSMO-MI', 'FRANCE',
    'Hair_Scalp_Care', 
    'hair_conditioner_balm', 
    'A densifying restorative hair conditioner/balm formulated to increase thickness and volume.', 
    FALSE
),
(
    1707, 
    'VICHY DERCOS DENSI SOLUTIONS HAIR MASS SPRAY 100M', 
    'فيشي ديركوس دينسي سوليوشنز بخاخ مكثف للشعر 100 مل', 
    2380.00, 2380.00, 'COSMO-MI', 'FRANCE',
    'Hair_Scalp_Care', 
    'scalp_treatment_leave_in', 
    'Leave-in scalp spray designed to target hair roots for increased hair density and mass.', 
    FALSE
),
(
    96705, 
    'VICHY DERCOS ENERGY SHAMPOO HAIR LOSS 200ML #C#', 
    'فيشي ديركوس إنيرجي شامبو ضد تساقط الشعر 200 مل #C#', 
    880.00, 880.00, 'COSMO-MI', 'FRANCE',
    'Hair_Scalp_Care', 
    'anti_hair_loss_shampoo', 
    'Cleansing formulation targeting hair loss and scalp strengthening.', 
    FALSE
),
(
    101672, 
    'VICHY DERCOS WOMAN AMINXIL 21AMPX6ML تساقط حريفي', 
    'فيشي ديركوس أمينكسيل نسائي أمبولات تساقط حريفي 21×6 مل', 
    2660.00, 2660.00, 'COSMO-MI', 'FRANCE',
    'Hair_Scalp_Care', 
    'anti_hair_loss_treatment', 
    'Intensive anti-hair loss leave-in scalp ampoules containing Aminexil.', 
    FALSE
),
(
    133541, 
    'VICHY LIFTACTIV B3 NIGHT CREAM 50ML', 
    'فيشي ليفت أكتيف بي3 كريم ليلي 50 مل', 
    2200.00, 2200.00, 'COSMO-MI', 'FRANCE',
    'Pigmentation_Skin_Tone', 
    'night_spot_corrector', 
    'Formulated primarily with Niacinamide (B3) to target dark spots and hyperpigmentation overnight.', 
    FALSE
),
(
    108560, 
    'VICHY LIFTACTIV B3 SERUM 30ML', 
    'فيشي ليفت أكتيف بي3 سيروم 30 مل', 
    1700.00, 1700.00, 'COSMO-MI', 'FRANCE',
    'Pigmentation_Skin_Tone', 
    'anti_pigmentation_serum', 
    'Focused on reducing dark spots and hyperpigmentation using Niacinamide and glycolic acid.', 
    FALSE
),
(
    139700, 
    'VICHY LIFTACTIV BONDING(16) SERUM 30ML COLLAGEN SPF', 
    'فيشي ليفت أكتيف بوندنج 16 سيروم كولاجين بواقي شمس 30 مل', 
    2000.00, 2000.00, 'COSMO-MI', 'FRANCE',
    'Anti_Aging_Skin_Rejuvenation', 
    'anti_aging_serum', 
    'Targets collagen stimulation and skin elasticity; broad spectrum protection is secondary.', 
    FALSE
),
(
    52021, 
    'VICHY LIFTACTIV H.A EPIDERMIC FILLER 30ML #C#', 
    'فيشي ليفت أكتيف إبيدرميك فيلر سيروم مالئ للبشرة 30 مل #C#', 
    1700.00, 1700.00, 'COSMO-MI', 'FRANCE',
    'Anti_Aging_Skin_Rejuvenation', 
    'wrinkle_filler_serum', 
    'Concentrated hyaluronic acid serum aimed at plumping deep wrinkles and fine lines.', 
    FALSE
),
(
    96273, 
    'VICHY LIFTACTIV NIGHT CREAM 50ML', 
    'فيشي ليفت أكتيف كريم ليلي 50 مل', 
    1700.00, 1700.00, 'COSMO-MI', 'FRANCE',
    'Anti_Aging_Skin_Rejuvenation', 
    'anti_aging_night_cream', 
    'Nighttime anti-wrinkle and firming moisturizer targeting skin rejuvenation.', 
    FALSE
),
(
    109761, 
    'VICHY LIFTACTIV VITAMIN C SERUM 20ML', 
    'فيشي ليفت أكتيف فيتامين سي سيروم 20 مل', 
    1700.00, 1700.00, 'COSMO-MI', 'FRANCE',
    'Anti_Aging_Skin_Rejuvenation', 
    'antioxidant_radiance_serum', 
    'High-potency Vitamin C antioxidant serum intended to boost skin radiance and fight photoaging.', 
    FALSE
),
(
    143224, 
    'VICHY LIFTACTIV(16) GLOW BOOST GEL 50ML COLLAGEN S', 
    'فيشي ليفت أكتيف 16 جلو بوست جل كولاجين 50 مل', 
    1100.00, 1100.00, 'COSMO-MI', 'FRANCE',
    'Anti_Aging_Skin_Rejuvenation', 
    'firming_radiance_gel', 
    'Light gel formula targeting collagen restoration, skin firmness, and brightness.', 
    FALSE
),
(
    140373, 
    'VICHY LIFTACTIV (B3)(SPF50)EYES CREAM 15ML', 
    'فيشي ليفت أكتيف بي3 كريم عين بواقي شمس SPF50 بحجم 15 مل', 
    1600.00, 1600.00, 'COSMO-MI', 'FRANCE',
    'Specialized_Care', 
    'eye_contour_care', 
    'Formulated for the delicate periocular skin region to target dark circles and wrinkles around the eyes.', 
    FALSE
),
(
    106920, 
    'VICHY LIFTACTIV COLLAGEN DAY CREAM 50ML', 
    'فيشي ليفت أكتيف كولاجين كريم نهاري 50 مل', 
    1590.00, 1590.00, 'COSMO-MI', 'FRANCE',
    'Anti_Aging_Skin_Rejuvenation', 
    'anti_aging_day_cream', 
    'Daily anti-aging moisturizer formulated to boost collagen fibers and firm the skin.', 
    FALSE
),
(
    95656, 
    'VICHY LIFTACTIV EYES CREAM 15ML #C#', 
    'فيشي ليفت أكتيف كريم عين 15 مل #C#', 
    1100.00, 1100.00, 'COSMO-MI', 'FRANCE',
    'Specialized_Care', 
    'eye_contour_care', 
    'Formulated specifically for eye contour rejuvenation, targeting wrinkles and dark circles.', 
    FALSE
),
(
    26659, 
    'VICHY MINERAL 89 EYE SERUM 15ML', 
    'فيشي مينيرال 89 سيروم عين 15 مل', 
    1220.00, 1220.00, 'COSMO-MI', 'FRANCE',
    'Specialized_Care', 
    'eye_contour_care', 
    'Targeted eye zone hydration and de-puffing formulation.', 
    FALSE
),
(
    105397, 
    'VICHY MINERAL 89 FACE SERUM 50ML', 
    'فيشي مينيرال 89 سيروم وجه 50 مل', 
    1350.00, 1350.00, 'COSMO-MI', 'FRANCE',
    'Skin_Moisturization_Barrier', 
    'barrier_repair_hydrator', 
    'Concentrated hyaluronic acid serum focused on reinforcing the skin barrier and deep hydration.', 
    FALSE
),
(
    145733, 
    'VICHY MINERAL 89 MOIST GEL MATTE 40ML', 
    'فيشي مينيرال 89 جل مرطب مطفي 40 مل', 
    800.00, 800.00, 'COSMO-MI', 'FRANCE',
    'Acne_Oil_Control', 
    'mattifying_moisturizer', 
    'Hydrating gel formulated with oil-control properties for mattifying oily/combination skin.', 
    FALSE
),
(
    144404, 
    'VICHY NORMADERM 200 + CAPITAL DRY TOUCH 50ML SPF5', 
    'فيشي نورماديرم + كابيتال دراي توش مجموعة واقي شمس 200 + 50 مل', 
    1528.00, 1528.00, 'COSMO-MI', 'COSMETICS',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Multi-product promotional bundle containing items across two distinct domains (Acne_Oil_Control / Skin_Cleansing + Sun_Protection).', 
    TRUE
),
INSERT INTO cosmeceutical_product_classification_full (
    code, name_en, name_ar, price_1, price_2, category, supplier,
    domain, subcategory, reason, review_required
) VALUES
(
    89862, 
    'LA ROCHE-POSAY CICAPLAST B5+ BALM SOOTH 40ML', 
    'لاروش بوزيه سيكابلاست بي 5+ بلسم مهدئ للبشرة 40 مل', 
    900.00, 900.00, 'COSMO-MI', 'FRANCE',
    'Skin_Moisturization_Barrier', 
    'barrier_repair_balm', 
    'Soothing multi-repairing balm formulated with Panthenol and Madecassoside to restore skin barrier function.', 
    FALSE
),
(
    134225, 
    'LA ROCHE-POSAY CICAPLAST B5+ SPF50 BALM 40ML', 
    'لاروش بوزيه سيكابلاست بي 5+ بلسم مهدئ واقي شمس SPF50 بحجم 40 مل', 
    990.00, 990.00, 'COSMO-MI', 'FRANCE',
    'Skin_Moisturization_Barrier', 
    'barrier_repair_balm', 
    'Barrier repair and soothing balm with added SPF50 to protect recovering skin from UV-induced hyperpigmentation.', 
    FALSE
),
(
    118179, 
    'LA ROCHE-POSAY CICAPLAST LEVRES BALM 7.5ML', 
    'لاروش بوزيه سيكابلاست ليفريس بلسم مرطب للشفاه 7.5 مل', 
    460.00, 460.00, 'COSMO-MI', 'FRANCE',
    'Lip_Care', 
    'lip_repair_balm', 
    'Barrier-repairing protective lip balm formulated for chapped and severely dry lips.', 
    FALSE
),
(
    85040, 
    'LA ROCHE-POSAY EFFACLAR DUO (+M) ANTI-IMPERFECTION 40ML', 
    'لاروش بوزيه إفكلار ديو إم كريم معالج ومضاد للشوائب 40 مل', 
    920.00, 920.00, 'COSMO-MI', 'GERMANY',
    'Acne_Oil_Control', 
    'acne_blemish_treatment', 
    'Comprehensive anti-blemish corrective moisturizer targeting pimples, marks, and excess sebum.', 
    FALSE
),
(
    118180, 
    'LA ROCHE-POSAY EFFACLAR DUO(+)UN IFIANT MEDIUM TINTED 40ML', 
    'لاروش بوزيه إفكلار ديو ملون بدرجة متوسطة كريم معالج 40 مل', 
    920.00, 920.00, 'COSMO-MI', 'GERMANY',
    'Acne_Oil_Control', 
    'tinted_acne_treatment', 
    'Tinted corrective acne treatment moisturizer providing blemish control and immediate skin tone coverage.', 
    FALSE
),
(
    136600, 
    'LA ROCHE-POSAY EFFACLAR DUO+M (22)PATCHS', 
    'لاروش بوزيه إفكلار ديو إم لصقات معالجة للحبوب 22 قطعة', 
    750.00, 750.00, 'COSMO-MI', 'FRANCE',
    'Acne_Oil_Control', 
    'acne_patch_treatment', 
    'Targeted hydrocolloid blemish patches designed to absorb impurities and protect localized breakouts.', 
    FALSE
),
(
    85161, 
    'LA ROCHE-POSAY EFFACLAR FOAMGEL OILY&SNSTVE 200M غسول', 
    'لاروش بوزيه إفكلار غسول جل للبشرة الدهنية والحساسة 200 مل', 
    730.00, 730.00, 'COSMO-MI', 'FRANCE',
    'Skin_Cleansing', 
    'purifying_cleansing_gel', 
    'Gentle foaming cleansing gel formulated to purify oily and sensitive skin without irritation.', 
    FALSE
),
(
    89434, 
    'LA ROCHE-POSAY EFFACLAR H CREAM ISO- BIOME 40M', 
    'لاروش بوزيه إفكلار إتش كريم مرطب وموازن للبشرة 40 مل', 
    920.00, 920.00, 'COSMO-MI', 'FRANCE',
    'Acne_Oil_Control', 
    'soothing_acne_moisturizer', 
    'Hydrating and soothing moisturizer specifically formulated for acne-prone skin weakened by drying treatments.', 
    FALSE
),
(
    1602, 
    'LA ROCHE-POSAY EFFACLAR H ISO-BIOME CLEANSING CREAM 200', 
    'لاروش بوزيه إفكلار إتش كريم غسول منظف وموازن للبشرة 200 مل', 
    830.00, 830.00, 'COSMO-MI', 'FRANCE',
    'Skin_Cleansing', 
    'soothing_cleansing_cream', 
    'Anti-imperfection soothing cleansing cream for irritated and fragile acne-prone skin.', 
    FALSE
),
(
    29260, 
    'LA ROCHE-POSAY EFFACLAR LOTION OILY TONER 200ML', 
    'لاروش بوزيه إفكلار لوشن تونر قابض للمسام للبشرة الدهنية 200 مل', 
    800.00, 800.00, 'COSMO-MI', 'FRANCE',
    'Acne_Oil_Control', 
    'astringent_pore_toner', 
    'Astringent micro-exfoliating toner designed to unclog pores and reduce shine in oily skin.', 
    FALSE
),
(
    32285, 
    'LA ROCHE-POSAY EFFACLAR MAT OILY SKIN 40ML', 
    'لاروش بوزيه إفكلار مات كريم مرطب ومطفي للبشرة الدهنية 40 مل', 
    920.00, 920.00, 'COSMO-MI', 'FRANCE',
    'Acne_Oil_Control', 
    'mattifying_moisturizer', 
    'Sebum-regulating mattifying moisturizer designed to control shine and tighten pores.', 
    FALSE
),
(
    8474, 
    'LA ROCHE-POSAY EFFACLAR MICRO PEELING GEL 200ML أحمر', 
    'لاروش بوزيه إفكلار ميكرو بييلنج غسول مقشر 200 مل', 
    790.00, 790.00, 'COSMO-MI', 'FRANCE',
    'Skin_Cleansing', 
    'exfoliating_cleansing_gel', 
    'Micro-peeling purifying cleansing gel targeting severe blemishes and body/face texture.', 
    FALSE
),
(
    9113, 
    'LA ROCHE-POSAY EFFACLAR SERUM ULTRA CONCETRE 30ML سيرم', 
    'لاروش بوزيه إفكلار سيروم مركز مقشر ومجدد للبشرة 30 مل', 
    1590.00, 1590.00, 'COSMO-MI', 'FRANCE',
    'Acne_Oil_Control', 
    'acne_resurfacing_serum', 
    'Ultra-concentrated exfoliating serum formulated with acids and niacinamide to target persistent blemishes and marks.', 
    FALSE
),
(
    146503, 
    'LA ROCHE-POSAY EFFACLAR SUPRA CLEANSER 200ML غسول بشرة دهني', 
    'لاروش بوزيه إفكلار سوبرا غسول منظف للبشرة الدهنية 200 مل', 
    680.00, 680.00, 'COSMO-MI', 'FRANCE',
    'Skin_Cleansing', 
    'purifying_cleansing_gel', 
    'Purifying cleanser tailored for cleansing and managing oily, blemish-prone skin.', 
    FALSE
),
(
    146505, 
    'LA ROCHE-POSAY EFFACLAR SUPRA CREAM 40ML OILYSKIN', 
    'لاروش بوزيه إفكلار سوبرا كريم مرطب للبشرة الدهنية 40 مل', 
    800.00, 800.00, 'COSMO-MI', 'FRANCE',
    'Acne_Oil_Control', 
    'mattifying_moisturizer', 
    'Targeted mattifying and balancing moisturizer for oily skin care regimens.', 
    FALSE
),
(
    85155, 
    'LA ROCHE-POSAY EFFACLAR ULTRA MICELLAR WATER OILY 200M', 
    'لاروش بوزيه إفكلار ماء ميسيلار فائق التنظيف للبشرة الدهنية 200 مل', 
    770.00, 770.00, 'COSMO-MI', 'FRANCE',
    'Skin_Cleansing', 
    'micellar_cleansing_water', 
    'Purifying micellar water designed to lift makeup and excess sebum from oily and acne-prone skin.', 
    FALSE
),
(
    95002, 
    'LA ROCHE-POSAY FOAM GEL (OILY) 400ML غسول للبشرة الدهنية', 
    'لاروش بوزيه غسول جل منظف للبشرة الدهنية 400 مل', 
    1140.00, 1140.00, 'COSMO-MI', 'FRANCE',
    'Skin_Cleansing', 
    'purifying_cleansing_gel', 
    'Large-size foaming purifying gel cleanser formulated for oily skin.', 
    FALSE
),
(
    124623, 
    'LA ROCHE-POSAY FOAM GEL (OILY) (كيس) 400ML غسول بشرة دهني', 
    'لاروش بوزيه غسول جل منظف للبشرة الدهنية عبوة كيس 400 مل', 
    999.99, 999.99, 'COSMO-MI', 'FRANCE',
    'Skin_Cleansing', 
    'purifying_cleansing_gel', 
    'Eco-refill pouch formatting of the purifying foaming gel for oily skin.', 
    FALSE
),
(
    32203, 
    'LA ROCHE-POSAY ANTHELIOS SHAKA TINTED FLUID50ML SPF50', 
    'لاروش بوزيه أنثيليوس شاكا فلويد ملون واقي شمس SPF50 بحجم 50 مل', 
    1070.00, 1070.00, 'COSMO-MI', 'FRANCE',
    'Sun_Protection', 
    'tinted_facial_sunscreen', 
    'High protection tinted fluid facial sunscreen offering ultra-resistant broad-spectrum defense.', 
    FALSE
),
(
    104643, 
    'LA ROCHE-POSAY ANTHE MIST SPF50 (DRY SPRAY) ANTI SHINE7', 
    'لاروش بوزيه أنثيليوس بخاخ رذاذ جاف ومضاد لللمعان واقي شمس SPF50 بحجم 75 مل', 
    820.00, 820.00, 'COSMO-MI', 'FRANCE',
    'Sun_Protection', 
    'sunscreen_spray_mist', 
    'Anti-shine dry touch mist sunscreen spray for convenient touch-ups and broad-spectrum SPF50 coverage.', 
    FALSE
),
(
    146502, 
    'LA ROCHE-POSAY ANTHE TEINT(UV AIR)SERUM50MLSUN(SPF50+)', 
    'لاروش بوزيه أنثيليوس يو في إير سيروم ملون واقي شمس SPF50+ بحجم 50 مل', 
    999.00, 999.00, 'COSMO-MI', 'FRANCE',
    'Sun_Protection', 
    'tinted_facial_sunscreen', 
    'Ultra-lightweight tinted serum sunscreen with high SPF50+ protection and even finish.', 
    FALSE
),
(
    140982, 
    'LA ROCHE-POSAY ANTHE(UV AIR)SERUM SUN50ML(SPF50+)', 
    'لاروش بوزيه أنثيليوس يو في إير سيروم واقي شمس SPF50+ بحجم 50 مل', 
    980.00, 980.00, 'COSMO-MI', 'FRANCE',
    'Sun_Protection', 
    'facial_sunscreen_fluid', 
    'Featherlight fluid serum facial sunscreen offering advanced broad-spectrum SPF50+ defense.', 
    FALSE
),
(
    90110, 
    'LA ROCHE-POSAY ANTHELIOS AGE CORRECT SPF50 50M', 
    'لاروش بوزيه أنثيليوس إيج كوريكت كريم مصحح لعلامات التقدم بالعمر واقي شمس SPF50 بحجم 50 مل', 
    1220.00, 1220.00, 'COSMO-MI', 'FRANCE',
    'Sun_Protection', 
    'anti_aging_sunscreen', 
    'Daily corrective facial sunscreen with SPF50 targeting wrinkles, dark spots, and elasticity loss.', 
    FALSE
),
(
    29616, 
    'LA ROCHE-POSAY ANTHELIOS AGE CORRECT TINTED SPF50 50ML', 
    'لاروش بوزيه أنثيليوس إيج كوريكت ملون ومصحح لعلامات التقدم بالعمر واقي شمس SPF50 بحجم 50 مل', 
    1250.00, 1250.00, 'COSMO-MI', 'FRANCE',
    'Sun_Protection', 
    'tinted_anti_aging_sunscreen', 
    'Tinted anti-aging corrective facial sunscreen combining high UV defense with tone evening.', 
    FALSE
),
(
    134227, 
    'LA ROCHE-POSAY ANTHELIOS DARK SPOTS FLUID SPF50 50ML', 
    'لاروش بوزيه أنثيليوس فلويد مضاد البقع الداكنة واقي شمس SPF50 بحجم 50 مل', 
    1100.00, 1100.00, 'COSMO-MI', 'FRANCE',
    'Sun_Protection', 
    'pigmentation_sunscreen_fluid', 
    'Specialized facial sunscreen fluid formulated to prevent and correct dark spots alongside SPF50 defense.', 
    FALSE
),
(
    87480, 
    'LA ROCHE-POSAY ANTHELIOS GEL CREAM SPF50 50ML', 
    'لاروش بوزيه أنثيليوس جل كريم واقي شمس SPF50 بحجم 50 مل', 
    1070.00, 1070.00, 'COSMO-MI', 'FRANCE',
    'Sun_Protection', 
    'hydrating_facial_sunscreen', 
    'Comfortable gel-cream facial sunscreen offering high broad-spectrum SPF50 protection.', 
    FALSE
),
(
    123604, 
    'LA ROCHE-POSAY ANTHELIOS HYDRAT LOTION (SPF50)75ML', 
    'لاروش بوزيه أنثيليوس لوشن مرطب واقي شمس SPF50 بحجم 75 مل', 
    1190.00, 1190.00, 'COSMO-MI', 'FRANCE',
    'Sun_Protection', 
    'body_sunscreen_lotion', 
    'Hydrating protective sunscreen lotion with SPF50 for skin sun defense.', 
    FALSE
),
(
    115755, 
    'LA ROCHE-POSAY ANTHELIOS INVISIBLE SPRAY KIDS SPF50 200ML', 
    'لاروش بوزيه أنثيليوس بخاخ مرشوش غير مرئي للأطفال واقي شمس SPF50 بحجم 200 مل', 
    1250.00, 1250.00, 'COSMO-MI', 'FRANCE',
    'Sun_Protection', 
    'kids_sunscreen_spray', 
    'High-protection invisible sunscreen spray specially formulated for children sensitive skin.', 
    FALSE
),
(
    115767, 
    'LA ROCHE-POSAY ANTHELIOS INVISIBLE SPRAY SPF50 200ML #C#', 
    'لاروش بوزيه أنثيليوس بخاخ مرشوش غير مرئي واقي شمس SPF50 بحجم 200 مل #C#', 
    1250.00, 1250.00, 'COSMO-MI', 'FRANCE',
    'Sun_Protection', 
    'body_sunscreen_spray', 
    'Broad-spectrum invisible sunscreen spray for body sun protection with SPF50.', 
    FALSE
),
(
    132417, 
    'LA ROCHE-POSAY ANTHELIOS OIL CONTROLFLUID SPF50 50ML', 
    'لاروش بوزيه أنثيليوس فلويد متحكم بالدهون واقي شمس SPF50 بحجم 50 مل', 
    1050.00, 1050.00, 'COSMO-MI', 'FRANCE',
    'Sun_Protection', 
    'mattifying_facial_sunscreen', 
    'Oil-control fluid facial sunscreen providing high SPF50 protection and anti-shine finish for oily skin.', 
    FALSE
),
(
    145482, 
    'LA ROCHE-POSAY ANTHELIOS SHAKA INVIS FLUID50ML SPF50', 
    'لاروش بوزيه أنثيليوس شاكا فلويد غير مرئي واقي شمس SPF50 بحجم 50 مل', 
    1070.00, 1070.00, 'COSMO-MI', 'FRANCE',
    'Sun_Protection', 
    'facial_sunscreen_fluid', 
    'Ultra-resistant invisible fluid facial sunscreen with broad-spectrum SPF50.', 
    FALSE
),
(
    41141, 
    'LA ROCHE-POSAY ANTHELIOS SPF50 HYDRATING CREAM 50ML', 
    'لاروش بوزيه أنثيليوس كريم مرطب واقي شمس SPF50 بحجم 50 مل', 
    1130.00, 1130.00, 'COSMO-MI', 'FRANCE',
    'Sun_Protection', 
    'hydrating_facial_sunscreen', 
    'Hydrating facial sunscreen cream with SPF50 tailored for dry to normal skin types.', 
    FALSE
),
(
    97200, 
    'LA ROCHE-POSAY ANTHELIOS SPRAY 200ML(BRUME)SPF50(FACE AN)', 
    'لاروش بوزيه أنثيليوس بخاخ رذاذ للوجه والجسم واقي شمس SPF50 بحجم 200 مل', 1250.00, 1250.00, 'COSMO-MI', 'FRANCE',
    'Sun_Protection', 
    'sunscreen_spray_mist', 
    'Refreshing mist spray sunscreen for face and body offering high SPF50 protection.', 
    FALSE
),
(
    102761, 
    'LA ROCHE-POSAY ANTHELIOS TINTED GEL CREAM 50ML SPF50', 
    'لاروش بوزيه أنثيليوس جل كريم ملون واقي شمس SPF50 بحجم 50 مل', 
    1070.00, 1070.00, 'COSMO-MI', 'FRANCE',
    'Sun_Protection', 
    'tinted_mattifying_sunscreen', 
    'Tinted gel-cream facial sunscreen providing matte sun protection and natural complexion coverage.', 
    FALSE
),
(
    102689, 
    'LA ROCHE-POSAY ANTHELIOS+6M BABYLOTION SPF50 50ML', 
    'لاروش بوزيه أنثيليوس لوشن للأطفال فوق 6 أشهر واقي شمس SPF50 بحجم 50 مل', 1200.00, 1200.00, 'COSMO-MI', 'FRANCE',
    'Sun_Protection', 
    'baby_sunsession_lotion', 
    'Formulated specifically for infant and baby skin (>6 months) offering safe high-factor sun protection.', 
    FALSE
),
(
    27251, 
    'LA ROCHE-POSAY CICAPLAST B5+ BALM SOOTH 100ML', 
    'لاروش بوزيه سيكابلاست بي 5+ بلسم مهدئ للبشرة 100 مل', 
    1300.00, 1300.00, 'COSMO-MI', 'FRANCE',
    'Skin_Moisturization_Barrier', 
    'barrier_repair_balm', 
    'Large-size soothing and repairing balm for irritated, dry skin and compromised skin barrier.', 
    FALSE
),
INSERT INTO cosmeceutical_product_classification_full (
    code, name_en, name_ar, price_1, price_2, category, supplier,
    domain, subcategory, reason, review_required
) VALUES
(
    137630, 
    'BIODERMA #ع# PHOTODERM LAIT ULTRA LOTION 100ML SPF50', 
    'بيوديرما فوتوديرم لابت فائق الحماية لوشن واقي شمس SPF50 بحجم 100 مل', 
    1199.00, 1199.00, 'COSMO-MI', 'FRANCE',
    'Sun_Protection', 
    'body_sunscreen_lotion', 
    'High-protection fluid body/face sunscreen lotion providing broad-spectrum SPF50 defense.', 
    FALSE
),
(
    21849, 
    'BIODERMA #ع# SENSIBIO GEL MOUSSANT 200ML (PUMP)FACE&EYES', 
    'بيوديرما سنسيبو جل غسول منظف للوجه والعينين 200 مل', 
    799.00, 799.00, 'COSMO-MI', 'COSMETICS',
    'Skin_Cleansing', 
    'soothing_cleansing_gel', 
    'Gentle foaming cleansing gel formulated for sensitive face and eyes.', 
    FALSE
),
(
    97543, 
    'BIODERMA #ع#ATODERM HAND CREAM 50ML(TUBE)', 
    'بيوديرما أتوديرم كريم مرطب لليدين 50 مل', 
    499.00, 499.00, 'COSMO-MI', 'FRANCE',
    'Specialized_Body_Care', 
    'hand_repair_cream', 
    'Nourishing and protective hand cream for dry and damaged skin.', 
    FALSE
),
(
    22687, 
    'BIODERMA #ع#CICABIO ARNICA+ 40ML', 
    'بيوديرما سيكابيو أرنيكا بلس كريم مهدئ ومزيل للكدمات 40 مل', 
    820.00, 820.00, 'COSMO-MI', 'FRANCE',
    'Specialized_Care', 
    'soothing_bruise_treatment', 
    'Targeted soothing cream formulated with Arnica to relieve bruising, swelling, and skin discomfort.', 
    FALSE
),
(
    137620, 
    'BIODERMA #ع#PHOTODERM(AKN MAT)SPF30 ACNE40ML', 
    'بيوديرما فوتوديرم إيه كيه إن مات واقي شمس ومطفي للبشرة المعرضة للحبوب SPF30 بحجم 40 مل', 
    799.00, 799.00, 'COSMO-MI', 'FRANCE',
    'Sun_Protection', 
    'mattifying_facial_sunscreen', 
    'Mattifying facial sunscreen specifically tailored for oily, acne-prone skin with SPF30.', 
    FALSE
),
(
    114626, 
    'BIODERMA ATODERM CREAM ULTRA(PUMP)200ML كود جِد #ع#', 
    'بيوديرما أتوديرم كريم مرطب فائق التغذية 200 مل', 
    699.00, 699.00, 'COSMO-MI', 'FRANCE',
    'Skin_Moisturization_Barrier', 
    'barrier_repair_hydrator', 
    'Daily ultra-nourishing and restructuring moisturizer for normal to dry sensitive skin.', 
    FALSE
),
(
    97542, 
    'BIODERMA PHOTODERM AQUA(CLAIRE LIGHT)SPF50 40ML الحنية', 
    'بيوديرما فوتوديرم أكوا فلويد ملون فاتح واقي شمس SPF50 بحجم 40 مل', 
    899.00, 899.00, 'COSMO-MI', 'FRANCE',
    'Sun_Protection', 
    'tinted_facial_sunscreen', 
    'Light-tinted fluid facial sunscreen offering high SPF50 protection and even tone.', 
    FALSE
),
(
    144246, 
    'BIODERMA SEBIUM FOAM GEL MOUSSANT 400ML(PUMP) البودرة', 
    'بيوديرما سيبيوم جل غسول منظف للبشرة الدهنية والمختلطة 400 مل', 
    1049.00, 1049.00, 'COSMO-MI', 'FRANCE',
    'Skin_Cleansing', 
    'purifying_cleansing_gel', 
    'Purifying foaming gel cleanser designed for combination to oily skin.', 
    FALSE
),
(
    47357, 
    'BIODERMA SEBIUM GEL MOUSSANT FOAM OILY 500ML #C# كود جِد', 
    'بيوديرما سيبيوم جل غسول منظف للبشرة الدهنية 500 مل', 
    1099.00, 1099.00, 'COSMO-MI', 'FRANCE',
    'Skin_Cleansing', 
    'purifying_cleansing_gel', 
    'Large-size purifying cleansing gel formulated to gently cleanse and control sebum in oily skin.', 
    FALSE
),
(
    145226, 
    'BIODERMA SEBIUM GOMMANT GEL75M(TUBE)(COMB&OILY)', 
    'بيوديرما سيبيوم جومانت جل مقشر ومنظف للبشرة الدهنية والمختلطة 75 مل', 
    749.00, 749.00, 'COSMO-MI', 'FRANCE',
    'Skin_Cleansing', 
    'exfoliating_cleansing_gel', 
    'Exfoliating purifying scrub gel designed to refine skin texture for combination and oily skin.', 
    FALSE
),
(
    143392, 
    'BIODERMA SENSIBIO GEL MOUSSANT 100M(TUBE)FACE&EYES #C#', 
    'بيوديرما سنسيبو جل غسول منظف للوجه والعينين 100 مل', 
    469.00, 469.00, 'COSMO-MI', 'FRANCE',
    'Skin_Cleansing', 
    'soothing_cleansing_gel', 
    'Travel/compact size soothing foaming cleansing gel for sensitive face and eyes.', 
    FALSE
),
(
    137611, 
    'BIODERMA SENSIBIO H2O MIC MAKE REMOV 100ML #C#', 
    'بيوديرما سنسيبو إتش تو أو ماء ميسيلار مزيل للمكياج 100 مل', 
    399.00, 399.00, 'COSMO-MI', 'FRANCE',
    'Skin_Cleansing', 
    'micellar_cleansing_water', 
    'Gentle micellar cleansing water formulated for sensitive skin makeup removal.', 
    FALSE
),
(
    99230, 
    'BIODERMA SENSIBIO H2O MICEL SOLUTION MAKEUP 500ML كود جِد', 
    'بيوديرما سنسيبو إتش تو أو محلول ميسيلار مزيل للمكياج 500 مل', 
    999.00, 999.00, 'COSMO-MI', 'FRANCE',
    'Skin_Cleansing', 
    'micellar_cleansing_water', 
    'Family-size micellar cleansing water for daily cleansing and makeup removal on sensitive skin.', 
    FALSE
),
(
    137602, 
    'BIODERMA #ع#ATODERM CREAM ULTRA 500ML(PUMP) بالبمب', 
    'بيوديرما أتوديرم كريم مرطب فائق التغذية بضخة 500 مل', 
    1299.00, 1299.00, 'COSMO-MI', 'FRANCE',
    'Skin_Moisturization_Barrier', 
    'barrier_repair_hydrator', 
    'Pump-dispenser body/face nourishing moisturizer for dry, sensitive skin barrier health.', 
    FALSE
),
(
    142283, 
    'BIODERMA #ع#ATODERM CREAM ULTRA(TUPE) 200ML العبوة', 
    'بيوديرما أتوديرم كريم مرطب فائق التغذية 200 مل', 
    749.00, 749.00, 'COSMO-MI', 'FRANCE',
    'Skin_Moisturization_Barrier', 
    'barrier_repair_hydrator', 
    'Tube-format nourishing moisturizer for daily skin barrier hydration.', 
    FALSE
),
(
    24161, 
    'BIODERMA #ع#ATODERM DOUCHE GEL GENTLE 200ML العبوة', 
    'بيوديرما أتوديرم دوش جل غسول لطيف للجسم 200 مل', 
    649.00, 649.00, 'COSMO-MI', 'FRANCE',
    'Skin_Cleansing', 
    'lipid_replenishing_cleanser', 
    'Gentle daily showering gel formulated to protect and cleanse sensitive dry skin.', 
    FALSE
),
(
    141048, 
    'BIODERMA #ع#ATODERM INTENS CLEANS BAR 150G', 
    'بيوديرما أتوديرم إنتنسيف صابونة تنظيف وترطيب البشرة 150 جرام', 
    499.00, 499.00, 'COSMO-MI', 'FRANCE',
    'Skin_Cleansing', 
    'lipid_replenishing_cleanser', 
    'Ultra-rich cleansing bar formulated to respect and protect dry, irritated skin barriers.', 
    FALSE
),
(
    106864, 
    'BIODERMA #ع#ATODERM INTENSIVE BALM 75ML', 
    'بيوديرما أتوديرم إنتنسيف بلسم مرطب ومضاد للتهيج 75 مل', 
    599.00, 599.00, 'COSMO-MI', 'FRANCE',
    'Skin_Moisturization_Barrier', 
    'lipid_replenishing_balm', 
    'Anti-itching soothing ultra-rich balm for dry to atopic-prone skin.', 
    FALSE
),
(
    99769, 
    'BIODERMA #ع# ATODERM INTENSIVE BALM 200ML TUBE العبوة', 
    'بيوديرما أتوديرم إنتنسيف بلسم مرطب ومضاد للتهيج 200 مل', 
    999.00, 999.00, 'COSMO-MI', 'FRANCE',
    'Skin_Moisturization_Barrier', 
    'lipid_replenishing_balm', 
    'Intensive anti-scratching and soothing balm for severe dry skin conditions.', 
    FALSE
),
(
    50608, 
    'BIODERMA #ع# ATODERM INTENSIVE GEL MOUSSANT 200ML TUBE', 
    'بيوديرما أتوديرم إنتنسيف جل غسول منظف ومرطب 200 مل', 
    749.00, 749.00, 'COSMO-MI', 'FRANCE',
    'Skin_Cleansing', 
    'lipid_replenishing_cleanser', 
    'Superfatting cleansing gel designed to soothe and protect atopic skin barriers.', 
    FALSE
),
(
    145991, 
    'BIODERMA #ع# CICABIO BAUME LAVANT CLEANS 200ML عبوة', 
    'بيوديرما سيكابيو بلسم لافانت غسول منظف ومجدد للبشرة 200 مل', 
    949.00, 949.00, 'COSMO-MI', 'FRANCE',
    'Skin_Cleansing', 
    'soothing_cleansing_cream', 
    'Purifying and soothing cleansing balm-gel for irritated or weakened skin.', 
    FALSE
),
(
    141363, 
    'BIODERMA #ع# CICABIO CREAM(+)FACE&BODY 40ML', 
    'بيوديرما سيكابيو بلس كريم مهدئ ومصلح للوجه والجسم 40 مل', 
    749.00, 749.00, 'COSMO-MI', 'FRANCE',
    'Skin_Moisturization_Barrier', 
    'barrier_repair_balm', 
    'Restorative and soothing cream designed to repair damaged skin on face and body.', 
    FALSE
),
(
    137621, 
    'BIODERMA #ع# NODE DS+ SHAM INTENS DANDRUFF 125ML', 
    'بيوديرما نود دي إس بلس شامبو مكثف لعلاج القشرة المستعصية 125 مل', 
    549.00, 549.00, 'COSMO-MI', 'FRANCE',
    'Hair_Scalp_Care', 
    'anti_dandruff_shampoo', 
    'Intensive anti-dandruff shampoo formulated to eliminate severe flaking and soothe itchy scalps.', 
    FALSE
),
(
    21429, 
    'BIODERMA #ع# PHOTODERM CREAM (INVISIBL) SPF50+ 40ML SENS', 
    'بيوديرما فوتوديرم كريم واقي شمس غير مرئي للبشرة الحساسة SPF50+ بحجم 40 مل', 
    999.00, 999.00, 'COSMO-MI', 'FRANCE',
    'Sun_Protection', 
    'hydrating_facial_sunscreen', 
    'Invisible high-protection facial sunscreen cream formulated specifically for sensitive skin.', 
    FALSE
),
(
    50677, 
    'BIODERMA #ع# PHOTODERM GEL CREAM AFTER SUN 200ML (TUBE)', 
    'بيوديرما فوتوديرم جل كريم مرطب وممهد بعد التعرض للشمس 200 مل', 
    699.00, 699.00, 'COSMO-MI', 'FRANCE',
    'Specialized_Care', 
    'after_sun_soothing_lotion', 
    'Refreshing after-sun gel-cream to hydrate, comfort, and prolong sun-exposed skin.', 
    FALSE
),
(
    7520, 
    'BIODERMA #ع# PHOTODERM SPOT AGE SPF50+GEL CREAM 40ML', 
    'بيوديرما فوتوديرم سبوت إيج جل كريم واقي شمس ومقاوم للبقع والتجاعيد SPF50+ بحجم 40 مل', 
    949.00, 949.00, 'COSMO-MI', 'FRANCE',
    'Sun_Protection', 
    'anti_aging_sunscreen', 
    'Anti-aging and anti-spot facial sunscreen gel-cream with SPF50+ defense.', 
    FALSE
),
(
    145992, 
    'BIODERMA #ع# PHOTODERM ULTRA FLUID(AR+) 40ML SPF50+', 
    'بيوديرما فوتوديرم ألترا فلويد إيه آر بلس واقي شمس ومضاد للاحمرار SPF50+ بحجم 40 مل', 
    999.00, 999.00, 'COSMO-MI', 'FRANCE',
    'Sun_Protection', 
    'anti_redness_sunscreen', 
    'Specialized fluid sunscreen with anti-redness care for sensitive skin prone to flushing and UV sensitivity.', 
    FALSE
),
(
    142781, 
    'BIODERMA #ع# PHOTODERM (01) XDEFEN (ULTRA-FLUID) 40ML SPF50', 
    'بيوديرما فوتوديرم إكس ديفيند ألترا فلويد ملون درجة 1 واقي شمس SPF50 بحجم 40 مل', 
    999.00, 999.00, 'COSMO-MI', 'IMPORTED',
    'Sun_Protection', 
    'tinted_facial_sunscreen', 
    'Shade 1 tinted ultra-fluid facial sunscreen providing high SPF50 broad-spectrum defense.', 
    FALSE
),
(
    142815, 
    'BIODERMA #ع# PHOTODERM (02) XDEFEN (ULTRA-FLUID) I40ML SPF50', 
    'بيوديرما فوتوديرم إكس ديفيند ألترا فلويد ملون درجة 2 واقي شمس SPF50 بحجم 40 مل', 
    999.00, 999.00, 'COSMO-MI', 'IMPORTED',
    'Sun_Protection', 
    'tinted_facial_sunscreen', 
    'Shade 2 tinted ultra-fluid facial sunscreen providing high SPF50 broad-spectrum defense.', 
    FALSE
),
(
    142780, 
    'BIODERMA #ع# PHOTODERM (03) XDEFEN (ULTRA-FLUID) 40ML SPF50', 
    'بيوديرما فوتوديرم إكس ديفيند ألترا فلويد ملون درجة 3 واقي شمس SPF50 بحجم 40 مل', 
    999.00, 999.00, 'COSMO-MI', 'IMPORTED',
    'Sun_Protection', 
    'tinted_facial_sunscreen', 
    'Shade 3 tinted ultra-fluid facial sunscreen providing high SPF50 broad-spectrum defense.', 
    FALSE
),
(
    137627, 
    'BIODERMA #ع# PHOTODERM (AR) SPF50 CREAM 30ML ANTI-RED', 
    'بيوديرما فوتوديرم إيه آر كريم واقي شمس ومضاد للاحمرار SPF50 بحجم 30 مل', 
    949.00, 949.00, 'COSMO-MI', 'FRANCE',
    'Sun_Protection', 
    'anti_redness_sunscreen', 
    'Anti-redness facial sunscreen cream formulated to soothe and protect reactive skin.', 
    FALSE
),
(
    142814, 
    'BIODERMA #ع# PHOTODERM (INVISIBLE) XDEFEN (ULTRA-FLUID) 40ML', 
    'بيوديرما فوتوديرم إكس ديفيند ألترا فلويد واقي شمس غير مرئي 40 مل', 
    999.00, 999.00, 'COSMO-MI', 'IMPORTED',
    'Sun_Protection', 
    'facial_sunscreen_fluid', 
    'Invisible ultra-fluid lightweight facial sunscreen offering high-performance UV protection.', 
    FALSE
),
(
    137628, 
    'BIODERMA #ع# PHOTODERM (LIGHT) CREAM SPF50+ 40ML SENS', 
    'بيوديرما فوتوديرم كريم واقي شمس ملون خفيف للبشرة الحساسة SPF50+ بحجم 40 مل', 
    899.00, 899.00, 'COSMO-MI', 'FRANCE',
    'Sun_Protection', 
    'tinted_facial_sunscreen', 
    'Lightly tinted facial sunscreen cream offering high protection for sensitive skin.', 
    FALSE
),
(
    21805, 
    'BIODERMA #ع# PIGMENTBIO C-CONCENTRATE 15ML DARK SPOTS', 
    'بيوديرما بيجمنتبيو سي كونستريت سيروم مركز مضاد للبقع الداكنة 15 مل', 
    1299.00, 1299.00, 'COSMO-MI', 'IMPORTED',
    'Pigmentation_Skin_Tone', 
    'anti_pigmentation_serum', 
    'High-potency Vitamin C concentrate serum targeted at reducing dark spots and brightening skin tone.', 
    FALSE
),
(
    41713, 
    'BIODERMA #ع# PIGMENTBIO DAILY CARE SPF 50+ 40ML', 
    'بيوديرما بيجمنتبيو داي كير كريم عناية يومية واقي شمس ومضاد للبقع SPF50+ بحجم 40 مل', 
    1299.00, 1299.00, 'COSMO-MI', 'FRANCE',
    'Pigmentation_Skin_Tone', 
    'pigmentation_day_cream', 
    'Daily brightening care moisturizer with SPF50+ targeting hyperpigmentation and dark spots.', 
    FALSE
),
(
    107355, 
    'BIODERMA #ع# PIGMENTBIO FOAMING CREAM 200ML (TUBE) سيرم', 
    'بيوديرما بيجمنتبيو غسول كريمي رغوي 200 مل', 
    849.00, 849.00, 'COSMO-MI', 'FRANCE',
    'Skin_Cleansing', 
    'brightening_cleansing_gel', 
    'Brightening exfoliating foaming cream cleanser designed to target dark spots and uneven complexion.', 
    FALSE
),
INSERT INTO cosmeceutical_product_classification_full (
    code, name_en, name_ar, price_1, price_2, category, supplier,
    domain, subcategory, reason, review_required
) VALUES
(
    28670, 
    'BIODERMA #ع# PIGMENTBIO NIGHT RENEWER 50ML', 
    'بيوديرما بيجمنتو نايت رينيوير كريم ليلي مجدد ومفتح للبشرة 50 مل', 
    1299.00, 1299.00, 'COSMO-MI', 'FRANCE',
    'Pigmentation_Skin_Tone', 
    'night_spot_corrector', 
    'Nighttime corrective cream designed to renew skin texture and reduce dark spots.', 
    FALSE
),
(
    29711, 
    'BIODERMA #ع# PIGMENTBIO SENSTIVE AREAS 75ML', 
    'بيوديرما بيجمنتو كريم تفتيح المناطق الحساسة 75 مل', 
    849.00, 849.00, 'COSMO-MI', 'FRANCE',
    'Pigmentation_Skin_Tone', 
    'anti_pigmentation_serum', 
    'Specialized corrective care cream formulated to brighten dark spots in sensitive body areas.', 
    FALSE
),
(
    38815, 
    'BIODERMA #ع# SEBIUM EXFOLIAT GE 100ML (TUBE) COM&OIL SKN', 
    'بيوديرما سيبيوم إكسفوليات جل مقشر ومنظف للبشرة المختلطة والدهنية 100 مل', 
    649.00, 649.00, 'COSMO-MI', 'FRANCE',
    'Skin_Cleansing', 
    'exfoliating_cleansing_gel', 
    'Purifying and exfoliating scrub cleansing gel for combination to oily skin.', 
    FALSE
),
(
    137606, 
    'BIODERMA #ع# SEBIUM GEL MOUSSANT FOAM 100ML(TUBE)', 
    'بيوديرما سيبيوم جل غسول منظف للبشرة الدهنية والمختلطة 100 مل', 
    449.00, 449.00, 'COSMO-MI', 'FRANCE',
    'Skin_Cleansing', 
    'purifying_cleansing_gel', 
    'Foaming cleansing gel formulated to purify and gently clean combination to oily skin.', 
    FALSE
),
(
    137609, 
    'BIODERMA #ع# SEBIUM GEL MOUSSANT FOAM 200ML (TUBE) كود باقم', 
    'بيوديرما سيبيوم جل غسول منظف للبشرة الدهنية والمختلطة 200 مل', 
    699.00, 699.00, 'COSMO-MI', 'FRANCE',
    'Skin_Cleansing', 
    'purifying_cleansing_gel', 
    'Tube packaging purifying foaming gel for combination and oily skin care.', 
    FALSE
),
(
    44087, 
    'BIODERMA #ع# SEBIUM GEL MOUSSANT FOAM 200ML COMB&OIL', 
    'بيوديرما سيبيوم جل غسول منظف للبشرة المختلطة والدهنية 200 مل', 
    769.00, 769.00, 'COSMO-MI', 'FRANCE',
    'Skin_Cleansing', 
    'purifying_cleansing_gel', 
    'Cleansing foaming gel designed to regulate sebum and purify combination to oily skin.', 
    FALSE
),
(
    96183, 
    'BIODERMA #ع# SEBIUM GLOBAL INTENSV CARE ACNE-PRONE 30ML', 
    'بيوديرما سيبيوم جلوبال عناية مركزة للبشرة المعرضة للحبوب 30 مل', 
    799.00, 799.00, 'COSMO-MI', 'FRANCE',
    'Acne_Oil_Control', 
    'acne_blemish_treatment', 
    'Intensive blemish-correcting treatment moisturizer for acne-prone skin.', 
    FALSE
),
(
    30816, 
    'BIODERMA #ع# SEBIUM H2O MICELLAR WATER OILY 250ML', 
    'بيوديرما سيبيوم إتش تو أو ماء ميسيلار مزيل للمكياج للبشرة الدهنية 250 مل', 
    699.00, 699.00, 'COSMO-MI', 'FRANCE',
    'Skin_Cleansing', 
    'micellar_cleansing_water', 
    'Purifying micellar cleansing water tailored for oily and acne-prone skin.', 
    FALSE
),
(
    137608, 
    'BIODERMA #ع# SEBIUM H2O MICELLAR WATER&OILY 100ML', 
    'بيوديرما سيبيوم إتش تو أو ماء ميسيلار مزيل للمكياج للبشرة الدهنية 100 مل', 
    349.00, 349.00, 'COSMO-MI', 'FRANCE',
    'Skin_Cleansing', 
    'micellar_cleansing_water', 
    'Compact purifying micellar water for cleansing and removing makeup from oily skin.', 
    FALSE
),
(
    97544, 
    'BIODERMA #ع# SEBIUM HYDRA FLUID ACTIV ACNE PRONE 40ML', 
    'بيوديرما سيبيوم هيدرا فلويد مرطب وملطف للبشرة المعرضة للحبوب 40 مل', 
    859.00, 859.00, 'COSMO-MI', 'FRANCE',
    'Acne_Oil_Control', 
    'soothing_acne_moisturizer', 
    'Compensating hydrating fluid formulated to soothe skin weakened by drying acne treatments.', 
    FALSE
),
(
    137604, 
    'BIODERMA #ع# SEBIUM KERATO+ GEL CREAM ACNE 30ML', 
    'بيوديرما سيبيوم كيراتوبلس جل كريم معالج للحبوب والشوائب 30 مل', 
    799.00, 799.00, 'COSMO-MI', 'FRANCE',
    'Acne_Oil_Control', 
    'acne_blemish_treatment', 
    'Anti-blemish gel-cream treatment designed to clear spots and marks on acne-prone skin.', 
    FALSE
),
(
    137605, 
    'BIODERMA #ع# SEBIUM PAN CLEAN BAR COM&OIL 100G', 
    'بيوديرما سيبيوم صابونة تنظيف للبشرة المختلطة والدهنية 100 جرام', 
    499.00, 499.00, 'COSMO-MI', 'FRANCE',
    'Skin_Cleansing', 
    'purifying_cleansing_bar', 
    'Purifying cleansing bar soap formulated for combination and oily skin.', 
    FALSE
),
(
    79949, 
    'BIODERMA #ع# SEBIUM PORE REFINER CREAM 30ML(OIL&COMB)', 
    'بيوديرما سيبيوم بور ريفاينر كريم لتقليص المسام للبشرة الدهنية والمختلطة 30 مل', 
    859.00, 859.00, 'COSMO-MI', 'FRANCE',
    'Acne_Oil_Control', 
    'pore_refining_treatment', 
    'Pore-tightening corrective treatment cream to refine texture in oily and combination skin.', 
    FALSE
),
(
    137607, 
    'BIODERMA #ع# SEBIUM SERUM ANTI-IMPER ACNE SKIN 30ML', 
    'بيوديرما سيبيوم سيروم مقشر ومضاد للشوائب للبشرة المعرضة للحبوب 30 مل', 
    1399.00, 1399.00, 'COSMO-MI', 'FRANCE',
    'Acne_Oil_Control', 
    'acne_resurfacing_serum', 
    'Resurfacing anti-blemish serum formulated with exfoliating acids for acne-prone skin.', 
    FALSE
),
(
    114628, 
    'BIODERMA #ع# SENSIBIO DEFENSIVE ACTIVE 40M SOOTH CREAM', 
    'بيوديرما سنسيبو ديفينسيف كريم نشط ومهدئ للبشرة الحساسة 40 مل', 
    849.00, 849.00, 'COSMO-MI', 'FRANCE',
    'Skin_Moisturization_Barrier', 
    'sensitive_skin_moisturizer', 
    'Active soothing moisturizer designed to reinforce sensitive skin defense mechanisms.', 
    FALSE
),
(
    137613, 
    'BIODERMA #ع# SENSIBIO EYE+ANTI-FATIGUE SENS 15ML', 
    'بيوديرما سنسيبو كريم للعين مضاد للإرهاق ومزيل للانتفاخ 15 مل', 
    799.00, 799.00, 'COSMO-MI', 'FRANCE',
    'Specialized_Care', 
    'eye_contour_care', 
    'Soothing anti-fatigue eye contour cream formulated for sensitive eyes to reduce puffiness.', 
    FALSE
),
(
    37360, 
    'BIODERMA #ع# SENSIBIO FORTE CREAM SOOTHING 40M SENSTIVE', 
    'بيوديرما سنسيبو فورت كريم مهدئ ومضاد للتهيج للبشرة الحساسة 40 مل', 
    899.00, 899.00, 'COSMO-MI', 'FRANCE',
    'Skin_Moisturization_Barrier', 
    'sensitive_skin_moisturizer', 
    'Rapid soothing and relief care cream for acute sensitive, irritated skin flare-ups.', 
    FALSE
),
(
    50609, 
    'BIODERMA #ع# SENSIBIO H2O MIC MAKE REMOV 250ML', 
    'بيوديرما سنسيبو إتش تو أو ماء ميسيلار مزيل للمكياج للبشرة الحساسة 250 مل', 
    749.00, 749.00, 'COSMO-MI', 'FRANCE',
    'Skin_Cleansing', 
    'micellar_cleansing_water', 
    'Soothing micellar cleansing water designed for daily cleansing of sensitive skin.', 
    FALSE
),
(
    138910, 
    'AVENE CLEAN(1+50)GEL TUBE 200ML+COMED 30ML', 
    'أفين كلينانس مجموعة غسول 200 مل + كوميدوميد 30 مل', 
    1365.00, 1365.00, 'COSMO-MI', 'AVENE',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Multi-product promotional bundle set combining cleanser and acne treatment serum.', 
    TRUE
),
(
    135473, 
    'AVENE CLEANANCE GEL (1+50%) OILY SKIN TUBE 200ML', 
    'أفين كلينانس جل غسول منظف للبشرة الدهنية عبوة عرض 200 مل', 
    1095.00, 1095.00, 'COSMO-MI', 'AVENE',
    'Skin_Cleansing', 
    'purifying_cleansing_gel', 
    'Purifying foaming gel cleanser formulated for oily and blemish-prone skin.', 
    FALSE
),
(
    102212, 
    'AVENE CLEANANCE SPF50 OILY SKIN 50ML #C#', 
    'أفين كلينانس واقي شمس للبشرة الدهنية SPF50 بحجم 50 مل #C#', 
    1019.00, 1019.00, 'COSMO-MI', 'AVENE',
    'Sun_Protection', 
    'mattifying_facial_sunscreen', 
    'Mattifying facial sunscreen with SPF50 tailored for oily and blemish-prone skin.', 
    FALSE
),
(
    143674, 
    'AVENE SOOTHING TONING LOTION 200ML(SENSITIVE)', 
    'أفين لوشن تونر مهدئ ومنعش للبشرة الحساسة 200 مل', 
    699.00, 699.00, 'COSMO-MI', 'AVENE',
    'Specialized_Care', 
    'soothing_thermal_water', 
    'Soothing and protective toning lotion formulated for sensitive skin.', 
    FALSE
),
(
    135474, 
    'AVENE (1+50) SUN FLUID 50ML+CLEANANCE GEL 200ML', 
    'أفين مجموعة فلويد واقي شمس 50 مل + كلينانس جل غسول 200 مل', 
    1395.00, 1395.00, 'COSMO-MI', 'AVENE',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Promotional combo bundle containing sunscreen and facial cleanser across distinct domains.', 
    TRUE
),
(
    130167, 
    'AVENE CICALFATE HAND CREME 100ML', 
    'أفين سيكالفات كريم مرطب ومصلح لليدين 100 مل', 
    669.00, 669.00, 'COSMO-MI', 'AVENE',
    'Specialized_Body_Care', 
    'hand_repair_cream', 
    'Repairing and protective hand cream for very dry and irritated hands.', 
    FALSE
),
(
    127299, 
    'AVENE CICALFATE(+) CREAM REPAIRING 40ML', 
    'أفين سيكالفات بلس كريم مرمم ومصلح للبشرة 40 مل', 
    709.00, 709.00, 'COSMO-MI', 'AVENE',
    'Skin_Moisturization_Barrier', 
    'barrier_repair_balm', 
    'Restorative protective cream designed to repair irritated and compromised skin barriers.', 
    FALSE
),
(
    139174, 
    'AVENE CICALFATE(+) LIP BALM REPAIR 10ML', 
    'أفين سيكالفات بلس بلسم مرمم ومصلح للشفاه 10 مل', 
    619.00, 619.00, 'COSMO-MI', 'AVENE',
    'Lip_Care', 
    'lip_repair_balm', 
    'Isolating and repairing lip balm for chapped, cracked, and irritated lips.', 
    FALSE
),
(
    30804, 
    'AVENE CLEANANCE COMEDOMED 30ML', 
    'أفين كلينانس كوميدوميد سيروم معالج للشوائب والحبوب 30 مل', 
    999.00, 999.00, 'COSMO-MI', 'AVENE',
    'Acne_Oil_Control', 
    'acne_blemish_treatment', 
    'Concentrated blemish-targeting anti-spot serum for blemish-prone oily skin.', 
    FALSE
),
(
    108232, 
    'AVENE CLEANANCE GEL OILY SKIN TUBE 200ML', 
    'أفين كلينانس جل غسول منظف للبشرة الدهنية 200 مل', 
    739.00, 739.00, 'COSMO-MI', 'AVENE',
    'Skin_Cleansing', 
    'purifying_cleansing_gel', 
    'Purifying and mattifying cleansing gel for oily, blemish-prone skin.', 
    FALSE
),
(
    143675, 
    'AVENE CLEANANCE GEL OILY SKIN 400ML بالبمب', 
    'أفين كلينانس جل غسول منظف للبشرة الدهنية بضخة 400 مل', 
    1199.00, 1199.00, 'COSMO-MI', 'AVENE',
    'Skin_Cleansing', 
    'purifying_cleansing_gel', 
    'Pump dispenser large-size purifying cleansing gel for oily skin care.', 
    FALSE
),
(
    102609, 
    'AVENE CLEANANCE HYDRA CREAM SKIN 40ML', 
    'أفين كلينانس هيدرا كريم مرطب ومهدئ للبشرة المعالجة 40 مل', 
    719.00, 719.00, 'COSMO-MI', 'AVENE',
    'Acne_Oil_Control', 
    'soothing_acne_moisturizer', 
    'Soothing and nourishing hydrating cream for acne-prone skin dried by medical treatments.', 
    FALSE
),
(
    97987, 
    'AVENE CLEANANCE MICE WATE 400ML تركواز', 
    'أفين كلينانس ماء ميسيلار منظف للبشرة الدهنية 400 مل', 
    779.00, 779.00, 'COSMO-MI', 'AVENE',
    'Skin_Cleansing', 
    'micellar_cleansing_water', 
    'Purifying micellar cleansing water formulated to cleanse and remove makeup from oily skin.', 
    FALSE
),
(
    72382, 
    'AVENE COLD CREAM 100ML V-DRY&SENSTV(FACE&BODY)', 
    'أفين كولد كريم غني مرطب للبشرة شديدة الجفاف والحساسة للوجه والجسم 100 مل', 
    719.00, 719.00, 'COSMO-MI', 'AVENE',
    'Skin_Moisturization_Barrier', 
    'lipid_replenishing_balm', 
    'Nourishing cold cream designed to protect and hydrate very dry, sensitive face and body skin.', 
    FALSE
),
(
    94899, 
    'AVENE COLD CREAM HAND DRY 50ML', 
    'أفين كولد كريم مرطب لليدين الجافة 50 مل', 
    619.00, 619.00, 'COSMO-MI', 'AVENE',
    'Specialized_Body_Care', 
    'hand_repair_cream', 
    'Nourishing cold cream hand balm for dry and chapped hands.', 
    FALSE
),
(
    136773, 
    'AVENE COLD CREAM LIP BALM STICK 4G', 
    'أفين كولد كريم مرطب للشفاه أصبع 4 جرام', 
    409.00, 409.00, 'COSMO-MI', 'AVENE',
    'Lip_Care', 
    'lip_repair_balm', 
    'Nourishing and protective lip balm stick for dry lips.', 
    FALSE
),
(
    94083, 
    'AVENE CREAM SPF50 HYDRA DRY SENS 50ML', 
    'أفين كريم مرطب واقي شمس للبشرة الجافة والحساسة SPF50 بحجم 50 مل', 
    1025.00, 1025.00, 'COSMO-MI', 'AVENE',
    'Sun_Protection', 
    'hydrating_facial_sunscreen', 
    'Hydrating facial sunscreen cream with high SPF50 protection for dry, sensitive skin.', 
    FALSE
),
(
    106919, 
    'AVENE ENTLE EXFOLIATING GEL SENS 75ML #C#', 
    'أفين جل مقشر لطيف للبشرة الحساسة 75 مل #C#', 
    899.00, 899.00, 'COSMO-MI', 'AVENE',
    'Skin_Cleansing', 
    'exfoliating_cleansing_gel', 
    'Gentle exfoliating scrub gel formulated to refine sensitive skin texture.', 
    FALSE
),
(
    106733, 
    'AVENE FLUIDE SPF50 ULTRA LIGHT 50ML #C#', 
    'أفين فلويد خفيف جداً واقي شمس SPF50 بحجم 50 مل #C#', 
    1025.00, 1025.00, 'COSMO-MI', 'AVENE',
    'Sun_Protection', 
    'facial_sunscreen_fluid', 
    'Ultra-lightweight fluid facial sunscreen offering high broad-spectrum SPF50 protection.', 
    FALSE
),
(
    143035, 
    'AVENE FLUIDE SPF50(1+1)FREE 50ML ULTRA LIGHT', 
    'أفين فلويد خفيف جداً واقي شمس SPF50 عرض قطعتين 50 مل', 
    1025.00, 1025.00, 'COSMO-MI', 'AVENE',
    'Sun_Protection', 
    'facial_sunscreen_fluid', 
    'Value pack ultra-light fluid facial sunscreen with high SPF50 protection.', 
    FALSE
),
(
    145157, 
    'AVENE HYALURON ACTIV(B3)EYE CARE 15ML', 
    'أفين هيالورون أكتيف بي 3 كريم العناية بالعين ومقاوم التجاعيد 15 مل', 
    699.00, 699.00, 'COSMO-MI', 'AVENE',
    'Specialized_Care', 
    'eye_contour_care', 
    'Anti-aging eye care contour cream formulated with Niacinamide and hyaluronic acid to smooth wrinkles.', 
    FALSE
),
(
    145878, 
    'AVENE LAIT-LOTION SPF50 (DRY TOUCH) 100ML العبوة', 
    'أفين لوشن حليبي واقي شمس بملمس جاف SPF50 بحجم 100 مل', 
    1499.00, 1499.00, 'COSMO-MI', 'AVENE',
    'Sun_Protection', 
    'mattifying_facial_sunscreen', 
    'Dry-touch milk lotion sunscreen with high SPF50 for body and face protection.', 
    FALSE
),
(
    136772, 
    'AVENE LAIT-LOTION SPF50 SENSI SKIN 100ML', 
    'أفين لوشن حليبي واقي شمس للبشرة الحساسة SPF50 بحجم 100 مل', 
    1449.00, 1449.00, 'COSMO-MI', 'AVENE',
    'Sun_Protection', 
    'body_sunscreen_lotion', 
    'High-protection milk sunscreen lotion tailored for sensitive skin types.', 
    FALSE
),
(
    106769, 
    'AVENE SPF50 TINTED FLUIDE SENSITVE 50ML', 
    'أفين فلويد ملون واقي شمس للبشرة الحساسة SPF50 بحجم 50 مل', 
    1025.00, 1025.00, 'COSMO-MI', 'AVENE',
    'Sun_Protection', 
    'tinted_facial_sunscreen', 
    'Tinted fluid facial sunscreen offering high-factor protection for sensitive skin.', 
    FALSE
),
(
    51076, 
    'AVENE THERMAL SPRAY SPRING WATER 150ML', 
    'أفين مياه ينبوع حرارية بخاخ 150 مل', 
    569.00, 569.00, 'COSMO-MI', 'AVENE',
    'Specialized_Care', 
    'soothing_thermal_water', 
    'Pure soothing thermal spring water spray for sensitive and irritated skin.', 
    FALSE
),
(
    143671, 
    'AVENE THERMAL SPRAY SPRING WATER 300ML', 
    'أفين مياه ينبوع حرارية بخاخ 300 مل', 
    959.00, 959.00, 'COSMO-MI', 'AVENE',
    'Specialized_Care', 
    'soothing_thermal_water', 
    'Family-size soothing thermal spring water spray to calm and refresh sensitive skin.', 
    FALSE
),
(
    136771, 
    'AVENE TINTED CREAM SPF50 50ML', 
    'أفين كريم ملون واقي شمس SPF50 بحجم 50 مل', 
    1025.00, 1025.00, 'COSMO-MI', 'AVENE',
    'Sun_Protection', 
    'tinted_facial_sunscreen', 
    'Tinted facial sunscreen cream providing broad-spectrum SPF50 protection and even tone.', 
    FALSE
),
(
    145156, 
    'AVENE VIT ACTIV(CG)CORRECT SERUM 30ML', 
    'أفين فيتامين أكتيف سي جي سيروم مصحح ومضاد للشيخوخة 30 مل', 
    1549.00, 1549.00, 'COSMO-MI', 'AVENE',
    'Anti_Aging_Skin_Rejuvenation', 
    'antioxidant_radiance_serum', 
    'Vitamin C and active antioxidant serum designed to correct wrinkles and boost skin radiance.', 
    FALSE
),
(
    85639, 
    'ACM #ع#DEPIWHITE ADVANCED CREAM40ML BROWN', 
    'إيه سي إم ديبايوايت أدفانسد كريم معالج للبقع الداكنة 40 مل', 
    599.00, 599.00, 'COSMO-MI', 'ACM',
    'Pigmentation_Skin_Tone', 
    'anti_pigmentation_serum', 
    'Intensive depigmenting cream formulated to reduce brown spots and hyperpigmentation.', 
    FALSE
),
(
    85640, 
    'ACM DEPIWHITE PEEL OFF FACE MASK 40ML BROWN SPOT 4', 
    'إيه سي إم ديبايوايت قناع مقشر ومنظف للبقع الداكنة للوجه 40 مل', 
    539.00, 539.00, 'COSMO-MI', 'ACM',
    'Pigmentation_Skin_Tone', 
    'night_spot_corrector', 
    'Peel-off clarifying mask designed to target brown spots and brighten facial complexion.', 
    FALSE
),
(
    120053, 
    'ACM DUOLYS CREAM SOLAIRE SPF50 ANTI AGE 50ML', 
    'إيه سي إم ديوليس كريم واقي شمس ومقاوم للشيخوخة SPF50 بحجم 50 مل', 
    799.00, 799.00, 'COSMO-MI', 'ACM',
    'Sun_Protection', 
    'anti_aging_sunscreen', 
    'Anti-aging facial sunscreen cream with SPF50 protecting against photoaging and wrinkles.', 
    FALSE
),
(
    136101, 
    'ACM MEDISUN CREAM (1+1) SPF 50+ HIGH PROTECTION 40', 
    'إيه سي إم ميديسن كريم واقي شمس فائقة الحماية عرض قطعتين SPF50+ بحجم 40 مل', 
    535.00, 535.00, 'COSMO-MI', 'ACM',
    'Sun_Protection', 
    'hydrating_facial_sunscreen', 
    'High protection sunscreen cream offer pack with SPF50+ defense.', 
    FALSE
),
(
    111465, 
    'ACM MEDISUN CREAM SPF 50+ HIGH PROTECTION 40ML 136', 
    'إيه سي إم ميديسن كريم واقي شمس عالي الحماية SPF50+ بحجم 40 مل', 
    535.00, 535.00, 'COSMO-MI', 'ACM',
    'Sun_Protection', 
    'hydrating_facial_sunscreen', 
    'High protection broad-spectrum facial sunscreen cream with SPF50+.', 
    FALSE
),
(
    143648, 
    'ACM NOVOPHANE CAP FOOD SUPPLEMENT 60P', 
    'إيه سي إم نوفوفان كابسولات مكمل غذائي للشعر والأظافر 60 كبسولة', 
    330.00, 990.00, 'ORAL', 'ACM',
    'Specialized_Care', 
    'hair_nail_dietary_supplement', 
    'Oral nutritional dietary supplement capsules formulated to support hair and nail strength.', 
    FALSE
),
(
    85642, 
    'ACM NOVOPHANE LOTION HAIR LOSS 100ML #C#', 
    'إيه سي إم نوفوفان لوشن معالج ومضاد لتساقط الشعر 100 مل', 
    839.00, 839.00, 'COSMO-MI', 'ACM',
    'Hair_Scalp_Care', 
    'anti_hair_loss_treatment', 
    'Scalp lotion treatment formulated to stimulate hair growth and combat hair loss.', 
    FALSE
),
(
    72212, 
    'ACM#ع# CICASTIM REPAIR CREAM 20ML', 
    'إيه سي إم سيكاستيم كريم مرمم ومصلح للبشرة 20 مل', 
    259.00, 259.00, 'COSMO-MI', 'ACM',
    'Skin_Moisturization_Barrier', 
    'barrier_repair_balm', 
    'Restorative soothing cream designed to repair and accelerate skin healing after minor lesions.', 
    FALSE
),
(
    99716, 
    'ACM#ع# DEPIWHITE BODY MILK WHITENING DRY SKIN 200ML', 
    'إيه سي إم ديبايوايت حليب مرطب ومفتح للجسم للبشرة الجافة 200 مل', 
    599.00, 599.00, 'COSMO-MI', 'ACM',
    'Pigmentation_Skin_Tone', 
    'body_pigmentation_treatment', 
    'Depigmenting moisturizing body milk formulated to brighten and unify dry body skin tone.', 
    FALSE
),
(
    86180, 
    'ACM#ع# DEPIWHITE GEL EYE CONTOUR ANTI-DARK 15ML', 
    'إيه سي إم ديبايوايت جل للعين مضاد للهالات السوداء 15 مل', 
    399.00, 399.00, 'COSMO-MI', 'ACM',
    'Specialized_Care', 
    'eye_contour_care', 
    'Targeted eye contour gel formulated to reduce dark circles and illuminate eye zone.', 
    FALSE
),
(
    107356, 
    'ACM#ع# DUOLYS EYE CONTOUR CREAM 15ML', 
    'إيه سي إم ديوليس كريم العناية بمنطقة العين 15 مل', 
    399.00, 399.00, 'COSMO-MI', 'ACM',
    'Specialized_Care', 
    'eye_contour_care', 
    'Anti-aging eye contour cream designed to smooth wrinkles and firm eye skin.', 
    FALSE
),
(
    111467, 
    'ACM#ع# MEDISUN GEL SPF 50+ HIGH PROTECTION 40ML', 
    'إيه سي إم ميديسن جل واقي شمس عالي الحماية SPF50+ بحجم 40 مل', 
    559.00, 559.00, 'COSMO-MI', 'ACM',
    'Sun_Protection', 
    'facial_sunscreen_fluid', 
    'High protection gel texture sunscreen offering broad-spectrum SPF50+ defense.', 
    FALSE
),
(
    125945, 
    'ACM#ع# MEDISUN MATTIFYING GEL SPF50 40ML', 
    'إيه سي إم ميديسن جل واقي شمس ومطفي للبشرة SPF50 بحجم 40 مل', 
    569.00, 569.00, 'COSMO-MI', 'ACM',
    'Sun_Protection', 
    'mattifying_facial_sunscreen', 
    'Mattifying sun protection gel formulated with SPF50 for oily and combination skin.', 
    FALSE
),
(
    125946, 
    'ACM#ع# MEDISUN(TINTED CREAM)SPF50 LIGHT 40ML', 
    'إيه سي إم ميديسن كريم ملون واقي شمس درجة فاتحة SPF50 بحجم 40 مل', 
    559.00, 559.00, 'COSMO-MI', 'ACM',
    'Sun_Protection', 
    'tinted_facial_sunscreen', 
    'Light shade tinted facial sunscreen cream providing high SPF50 protection.', 
    FALSE
),
(
    72211, 
    'ACM#ع# NOVOPHANE DS SHAMP ANTI-DANDRUFF 125ML', 
    'إيه سي إم نوفوفان دي إس شامبو مضاد للقشرة 125 مل', 
    639.00, 639.00, 'COSMO-MI', 'ACM',
    'Hair_Scalp_Care', 
    'anti_dandruff_shampoo', 
    'Anti-dandruff shampoo formulated to clear persistent flakes and soothe irritated scalps.', 
    FALSE
),
(
    72213, 
    'ACM#ع# NOVOPHANE NAIL CREAM 15ML', 
    'إيه سي إم نوفوفان كريم مرطب ومقوي للأظافر 15 مل', 
    325.00, 325.00, 'COSMO-MI', 'ACM',
    'Specialized_Care', 
    'nail_strengthening_cream', 
    'Strengthening and moisturizing nail care cream for brittle and damaged nails.', 
    FALSE
),
(
    125944, 
    'ACM#ع# SEBIONEX CREAM HYDRA REPAR 40ML', 
    'إيه سي إم سيبيونيكس كريم مرطب ومرمم للبشرة 40 مل', 
    565.00, 565.00, 'COSMO-MI', 'ACM',
    'Acne_Oil_Control', 
    'soothing_acne_moisturizer', 
    'Restorative and hydrating cream designed for acne-prone skin undergoing drying treatments.', 
    FALSE
),
(
    86426, 
    'ACM#ع# SEBIONEX FOAMING GEL FACE&BODY OILY 200ML', 
    'إيه سي إم سيبيونيكس جل غسول رغوي للوجه والجسم للبشرة الدهنية 200 مل', 
    459.00, 459.00, 'COSMO-MI', 'ACM',
    'Skin_Cleansing', 
    'purifying_cleansing_gel', 
    'Purifying foaming gel cleanser for oily and blemish-prone face and body skin.', 
    FALSE
),
(
    99719, 
    'ACM#ع# SEBIONEX GEL MATTIFYING SPF50+ 40M', 
    'إيه سي إم سيبيونيكس جل واقي شمس ومطفي للبشرة SPF50+ بحجم 40 مل', 
    565.00, 565.00, 'COSMO-MI', 'ACM',
    'Sun_Protection', 
    'mattifying_facial_sunscreen', 
    'Mattifying sunscreen gel with high SPF50+ protection tailored for oily skin.', 
    FALSE
),
(
    99718, 
    'ACM#ع# SEBIONEX TRIO FACE SOOTHING CREAM 40ML', 
    'إيه سي إم سيبيونيكس تريو كريم مهدئ ومعالج للوجه 40 مل', 
    409.00, 409.00, 'COSMO-MI', 'ACM',
    'Acne_Oil_Control', 
    'acne_blemish_treatment', 
    'Corrective blemish care cream for acne-prone and oily skin imperfections.', 
    FALSE
),
INSERT INTO cosmeceutical_product_classification_full (
    code, name_en, name_ar, price_1, price_2, category, supplier,
    domain, subcategory, reason, review_required
) VALUES
(
    124028, 
    'CERAVE BLEMISH CONTROL CLEAN GEL 236ML', 
    'سيرافي بليمش كنترول جل غسول للتحكم بالشوائب 236 مل', 
    700.00, 700.00, 'COSMO-MI', 'CERAVE',
    'Acne_Oil_Control', 
    'acne_cleansing_gel', 
    'Salicylic acid purifying cleansing gel formulated to clear blemishes and unclog pores in blemish-prone skin.', 
    FALSE
),
(
    124029, 
    'CERAVE BLEMISH CONTROL GEL 40ML', 
    'سيرافي بليمش كنترول جل معالج للحبوب والشوائب 40 مل', 
    520.00, 520.00, 'COSMO-MI', 'CERAVE',
    'Acne_Oil_Control', 
    'acne_blemish_treatment', 
    'Targeted treatment gel with AHAs and BHAs to reduce blemishes and prevent breakouts.', 
    FALSE
),
(
    25560, 
    'CERAVE DAILY MOIST LOTION 236ML', 
    'سيرافي لوشن مرطب يومي للبشرة 236 مل', 
    640.00, 640.00, 'COSMO-MI', 'CERAVE',
    'Skin_Moisturization_Barrier', 
    'lightweight_barrier_moisturizer', 
    'Lightweight daily moisturizing lotion with ceramides and hyaluronic acid to restore skin barrier.', 
    FALSE
),
(
    27203, 
    'CERAVE DAILY MOIST LOTION 473ML', 
    'سيرافي لوشن مرطب يومي للبشرة 473 مل', 
    1030.00, 1030.00, 'COSMO-MI', 'CERAVE',
    'Skin_Moisturization_Barrier', 
    'lightweight_barrier_moisturizer', 
    'Large-size daily moisturizing lotion for face and body skin barrier hydration.', 
    FALSE
),
(
    145736, 
    'CERAVE DAILY MOIST LOTION 88ML', 
    'سيرافي لوشن مرطب يومي للبشرة 88 مل', 
    342.00, 342.00, 'COSMO-MI', 'CERAVE',
    'Skin_Moisturization_Barrier', 
    'lightweight_barrier_moisturizer', 
    'Compact travel size daily moisturizing lotion with essential ceramides.', 
    FALSE
),
(
    6959, 
    'CERAVE EYE REPAIR CREAM 14ML #C#', 
    'سيرافي كريم إصلاح العين 14 مل #C#', 
    550.00, 550.00, 'COSMO-MI', 'CERAVE',
    'Specialized_Care', 
    'eye_contour_care', 
    'Restorative eye cream formulated with ceramides and hyaluronic acid to reduce dark circles and puffiness.', 
    FALSE
),
(
    118494, 
    'CERAVE FACIAL MOIST LOTION SPF30(AM) 52ML', 
    'سيرافي لوشن مرطب للوجه مع واقي شمس SPF30 (نهاري) 52 مل', 
    590.00, 590.00, 'COSMO-MI', 'CERAVE',
    'Sun_Protection', 
    'day_moisturizing_sunscreen', 
    'Morning facial moisturizing lotion providing broad-spectrum SPF30 protection and barrier support.', 
    FALSE
),
(
    42923, 
    'CERAVE FACIAL MOIST LOTION(PM) 52ML', 
    'سيرافي لوشن مرطب للوجه (ليلي) 52 مل', 
    590.00, 590.00, 'COSMO-MI', 'CERAVE',
    'Skin_Moisturization_Barrier', 
    'night_barrier_moisturizer', 
    'Nighttime facial moisturizer with niacinamide and ceramides to calm and restore skin.', 
    FALSE
),
(
    41537, 
    'CERAVE FOAMING CLEANSER 236ML', 
    'سيرافي جل غسول رغوي للبشرة 236 مل', 
    620.00, 620.00, 'COSMO-MI', 'CERAVE',
    'Skin_Cleansing', 
    'purifying_cleansing_gel', 
    'Refreshing foaming cleansing gel formulated for normal to oily skin.', 
    FALSE
),
(
    32097, 
    'CERAVE FOAMING CLEANSER 473ML', 
    'سيرافي جل غسول رغوي للبشرة 473 مل', 
    960.00, 960.00, 'COSMO-MI', 'CERAVE',
    'Skin_Cleansing', 
    'purifying_cleansing_gel', 
    'Large-size foaming gel cleanser designed to remove excess oil without disrupting skin barrier.', 
    FALSE
),
(
    145734, 
    'CERAVE FOAMING CLEANSER 88ML', 
    'سيرافي جل غسول رغوي للبشرة 88 مل', 
    319.00, 319.00, 'COSMO-MI', 'CERAVE',
    'Skin_Cleansing', 
    'purifying_cleansing_gel', 
    'Compact size foaming gel cleanser for normal to oily skin cleansing.', 
    FALSE
),
(
    30363, 
    'CERAVE HAND CREAM 50ML', 
    'سيرافي كريم مرطب لليدين 50 مل', 
    350.00, 350.00, 'COSMO-MI', 'CERAVE',
    'Specialized_Body_Care', 
    'hand_repair_cream', 
    'Protective and moisturizing hand cream formulated to soothe dry, chapped hands.', 
    FALSE
),
(
    28417, 
    'CERAVE HYDRATING CLEANSER 236ML غسول', 
    'سيرافي جل غسول مرطب ومنظف للبشرة 236 مل', 
    620.00, 620.00, 'COSMO-MI', 'CERAVE',
    'Skin_Cleansing', 
    'hydrating_cleansing_lotion', 
    'Non-foaming hydrating cleansing lotion for normal to dry skin types.', 
    FALSE
),
(
    5827, 
    'CERAVE HYDRATING CLEANSER 473ML', 
    'سيرافي جل غسول مرطب ومنظف للبشرة 473 مل', 
    960.00, 960.00, 'COSMO-MI', 'CERAVE',
    'Skin_Cleansing', 
    'hydrating_cleansing_lotion', 
    'Large-size gentle hydrating cleanser for daily cleansing of dry skin.', 
    FALSE
),
(
    143237, 
    'CERAVE INVISIBLE HYDRATING SUN SPF50 177ML(عبوة FA', 
    'سيرافي واقي شمس مرطب وغير مرئي SPF50 بحجم 177 مل', 
    1100.00, 1100.00, 'COSMO-MI', 'CERAVE',
    'Sun_Protection', 
    'body_sunscreen_lotion', 
    'Hydrating and invisible sun protection lotion with SPF50 for face and body.', 
    FALSE
),
(
    142659, 
    'CERAVE INVISIBLE HYDRATING SUN SPF50 75ML(FAC(عبوة', 
    'سيرافي واقي شمس مرطب وغير مرئي SPF50 بحجم 75 مل', 
    800.00, 800.00, 'COSMO-MI', 'CERAVE',
    'Sun_Protection', 
    'hydrating_facial_sunscreen', 
    'Lightweight invisible hydrating facial sunscreen with high SPF50 defense.', 
    FALSE
),
(
    138934, 
    'CERAVE MOIST LOTION 236ML عرض دكتور لوشن', 
    'سيرافي لوشن مرطب عرض خاص 236 مل', 
    575.00, 575.00, 'COSMO-MI', 'CERAVE',
    'Skin_Moisturization_Barrier', 
    'lightweight_barrier_moisturizer', 
    'Promotional bundle daily moisturizing lotion with ceramides.', 
    FALSE
),
(
    145735, 
    'CERAVE MOISTURISING CREAM 50ML #C#', 
    'سيرافي كريم مرطب للبشرة 50 مل #C#', 
    269.00, 269.00, 'COSMO-MI', 'CERAVE',
    'Skin_Moisturization_Barrier', 
    'barrier_repair_hydrator', 
    'Travel size rich moisturizing cream for dry to very dry skin barrier repair.', 
    FALSE
),
(
    23372, 
    'CERAVE MOISTURIZING CREAM 177ML', 
    'سيرافي كريم مرطب للبشرة 177 مل', 
    550.00, 550.00, 'COSMO-MI', 'CERAVE',
    'Skin_Moisturization_Barrier', 
    'barrier_repair_hydrator', 
    'Rich moisturizing cream formulated with ceramides for intense skin barrier hydration.', 
    FALSE
),
(
    34742, 
    'CERAVE MOISTURIZING CREAM 340ML', 
    'سيرافي كريم مرطب للبشرة 340 مل', 
    850.00, 850.00, 'COSMO-MI', 'CERAVE',
    'Skin_Moisturization_Barrier', 
    'barrier_repair_hydrator', 
    'Deeply nourishing moisturizing cream for face and body barrier restoration.', 
    FALSE
),
(
    31759, 
    'CERAVE MOISTURIZING CREAM 454ML', 
    'سيرافي كريم مرطب للبشرة 454 مل', 
    1050.00, 1050.00, 'COSMO-MI', 'CERAVE',
    'Skin_Moisturization_Barrier', 
    'barrier_repair_hydrator', 
    'Large jar rich moisturizing cream for intensive dry skin barrier care.', 
    FALSE
),
(
    132380, 
    'CERAVE OIL CONTROL MOIST GEL CREAM OILY SKIN 52ML', 
    'سيرافي أيل كنترول جل كريم مرطب ومتحكم بالدهون للبشرة الدهنية 52 مل', 
    660.00, 660.00, 'COSMO-MI', 'CERAVE',
    'Acne_Oil_Control', 
    'mattifying_moisturizer', 
    'Oil-absorbing mattifying gel-cream moisturizer tailored for oily skin.', 
    FALSE
),
(
    114846, 
    'CERAVE SA SMOOTH CLEANSER GEL 236ML', 
    'سيرافي إس إي سموث جل غسول مقشر ومنعم للبشرة 236 مل', 
    700.00, 700.00, 'COSMO-MI', 'CERAVE',
    'Skin_Cleansing', 
    'exfoliating_cleansing_gel', 
    'Salicylic acid smoothing cleanser designed to exfoliate and soften rough, bumpy skin.', 
    FALSE
),
(
    115005, 
    'CERAVE SA SMOOTH CLEANSER GEL 473ML #C#', 
    'سيرافي إس إي سموث جل غسول مقشر ومنعم للبشرة 473 مل #C#', 
    1050.00, 1050.00, 'COSMO-MI', 'CERAVE',
    'Skin_Cleansing', 
    'exfoliating_cleansing_gel', 
    'Large-size salicylic acid smoothing cleanser for rough and uneven skin texture.', 
    FALSE
),
(
    118183, 
    'CERAVE SA SMOOTH CREAM 177ML', 
    'سيرافي إس إي سموث كريم مقشر ومنعم للبشرة 177 مل', 
    800.00, 800.00, 'COSMO-MI', 'CERAVE',
    'Skin_Moisturization_Barrier', 
    'exfoliating_body_cream', 
    'Salicylic acid exfoliating moisturizing cream for rough and bumpy skin.', 
    FALSE
),
(
    136200, 
    'CERAVE SERUM RETINOL ANTI-MARKS 30ML', 
    'سيرافي ريتينول سيروم مضاد للآثار ومجدد للبشرة 30 مل', 
    870.00, 870.00, 'COSMO-MI', 'CERAVE',
    'Acne_Oil_Control', 
    'acne_resurfacing_serum', 
    'Resurfacing retinol serum formulated to reduce post-acne marks and smooth skin texture.', 
    FALSE
),
(
    143239, 
    'CERAVE SUN SPF50 FLUID 50ML (NORM&DRY SKIN)', 
    'سيرافي فلويد واقي شمس للبشرة العادية والجافة SPF50 بحجم 50 مل', 
    790.00, 790.00, 'COSMO-MI', 'CERAVE',
    'Sun_Protection', 
    'hydrating_facial_sunscreen', 
    'Fluid facial sunscreen with SPF50 formulated for normal to dry skin types.', 
    FALSE
),
(
    142658, 
    'CERAVE SUN SPF50 FLUID 50ML (NORM&OILY SKIN)', 
    'سيرافي فلويد واقي شمس للبشرة العادية والدهنية SPF50 بحجم 50 مل', 
    790.00, 790.00, 'COSMO-MI', 'CERAVE',
    'Sun_Protection', 
    'mattifying_facial_sunscreen', 
    'Fluid facial sunscreen with SPF50 formulated for normal to oily skin types.', 
    FALSE
),
(
    143533, 
    'CERAVE (1+1) FOAM CLEANS 236ML+OIL GEL CREAM 52ML عرض خصم', 
    'سيرافي مجموعة عرض غسول رغوي 236 مل + جل كريم مرطب 52 مل', 
    960.00, 960.00, 'COSMO-MI', 'CERAVE',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Multi-product promotional kit combining cleanser and moisturizer across distinct domains.', 
    TRUE
),
(
    38701, 
    'CETAPHIL SKIN CLEANSER 200ML (XX)', 
    'سيتافيل غسول منظف للبشرة 200 مل', 
    40.00, 40.00, 'COSMO-ME', 'AWAD AWAD',
    'Skin_Cleansing', 
    'hydrating_cleansing_lotion', 
    'Gentle daily cleanser formulated for sensitive skin cleansing.', 
    FALSE
),
(
    77103, 
    'CETAPHIL CLEANSER 200ML+LOTION 236ML (1+1) عرض خصم', 
    'سيتافيل مجموعة عرض غسول 200 مل + لوشن 236 مل', 
    365.00, 365.00, 'COSMO-ME', 'البادى للاستثمار',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Promotional bundle set combining facial cleanser and body lotion across multiple domains.', 
    TRUE
),
(
    97660, 
    'CETAPHIL FACE CLEANSER NORMAL&OILY 125ML #B# حجم آخر', 
    'سيتافيل غسول للوجه للبشرة العادية والدهنية 125 مل', 
    165.00, 165.00, 'COSMO-ME', 'ابن سينا فارما المنصورة',
    'Skin_Cleansing', 
    'purifying_cleansing_gel', 
    'Daily facial cleanser tailored for normal to oily skin types.', 
    FALSE
),
(
    97661, 
    'CETAPHIL FACE CLEANSER NORMAL&OILY 236ML #B#3# حجم ال', 
    'سيتافيل غسول للوجه للبشرة العادية والدهنية 236 مل', 
    275.00, 275.00, 'COSMO-ME', 'ابن سينا فارما المنصورة',
    'Skin_Cleansing', 
    'purifying_cleansing_gel', 
    'Daily cleansing formulation for normal to oily skin.', 
    FALSE
),
(
    97663, 
    'CETAPHIL FACE&BODY GENTLE CLEAN DRY&SNSTV 236ML #B#', 
    'سيتافيل غسول لطيف للوجه والجسم للبشرة الجافة والحساسة 236 مل', 
    275.00, 275.00, 'COSMO-ME', 'ابن سينا فارما المنصورة',
    'Skin_Cleansing', 
    'hydrating_cleansing_lotion', 
    'Gentle skin cleanser for face and body tailored for dry and sensitive skin.', 
    FALSE
),
(
    99184, 
    'CETAPHIL FACE&BODYGENTLECLEANSERDRY&SNSTV 118ML#B', 
    'سيتافيل غسول لطيف للوجه والجسم للبشرة الجافة والحساسة 118 مل', 
    165.00, 165.00, 'COSMO-ME', 'ابن سينا فارما المنصورة',
    'Skin_Cleansing', 
    'hydrating_cleansing_lotion', 
    'Compact size gentle cleanser for dry and sensitive face and body skin.', 
    FALSE
),
(
    77102, 
    'CETAPHIL MOIST CREAM 100G+LOTION 236ML (1+1) عرض خصم', 
    'سيتافيل مجموعة عرض كريم مرطب 100 جرام + لوشن 236 مل', 
    410.00, 410.00, 'COSMO-ME', 'البادى للاستثمار',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Promotional bundle combining moisturizing cream and body lotion.', 
    TRUE
),
(
    97662, 
    'CETAPHIL MOISTURIZ CREAM FACE&BODY 100G', 
    'سيتافيل كريم مرطب للوجه والجسم 100 جرام', 
    240.00, 240.00, 'COSMO-ME', 'البادى للاستثمار',
    'Skin_Moisturization_Barrier', 
    'barrier_repair_hydrator', 
    'Intensive moisturizing cream for dry, sensitive face and body skin.', 
    FALSE
),
(
    37102, 
    'CETAPHIL MOISTURIZ LOTION FACE&BODY ALL SKIN 236ML', 
    'سيتافيل لوشن مرطب للوجه والجسم لجميع أنواع البشرة 236 مل', 
    320.00, 320.00, 'COSMO-ME', 'European Uni',
    'Skin_Moisturization_Barrier', 
    'lightweight_barrier_moisturizer', 
    'Daily moisturizing lotion for face and body suitable for all skin types.', 
    FALSE
),
(
    77105, 
    'CETAPHIL MOISTURIZING LOTION 236ML (1+1) عرض خصم', 
    'سيتافيل لوشن مرطب عرض قطعتين 236 مل', 
    390.00, 390.00, 'COSMO-ME', 'البادى للاستثمار',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Promotional twin-pack bundle of moisturizing lotion.', 
    TRUE
),
(
    35753, 
    'CETAPHIL NON IRRITATING CLEANSER FACE&BODY 200ML', 
    'سيتافيل غسول منظف غير ممهد للوجه والجسم 200 مل', 
    220.00, 220.00, 'COSMO-ME', 'البادى للاستثمار',
    'Skin_Cleansing', 
    'hydrating_cleansing_lotion', 
    'Non-irritating gentle cleansing lotion for face and body.', 
    FALSE
),
(
    99185, 
    'CETAPHIL RESTORADERM BODY WASH DRY SKIN 295ML #B#', 
    'سيتافيل ريستوراديرم غسول استحمام مرطب للبشرة الجافة 295 مل', 
    475.00, 475.00, 'COSMO-ME', 'ابن سينا فارما المنصورة',
    'Skin_Cleansing', 
    'lipid_replenishing_cleanser', 
    'Soothing wash body cleanser formulated for very dry, eczema-prone skin.', 
    FALSE
),
(
    146494, 
    'DUCRAY ANAPHASE CREASTIM 60ML HAIR LOTION', 
    'دوكري أنافاز كرياستيم لوشن معالج لتساقط الشعر 60 مل', 
    2700.00, 2700.00, 'COSMO-MI', 'DUCRAY',
    'Hair_Scalp_Care', 
    'anti_hair_loss_treatment', 
    'Anti-hair loss scalp lotion formulated to stimulate hair growth and density.', 
    FALSE
),
(
    6332, 
    'DUCRAY DENSIAGE CONDITIONER REDENSIFYING 200ML #C#', 
    'دوكري دنسياج بلسم مكثف ومجدد لحجم الشعر 200 مل', 
    525.00, 525.00, 'COSMO-MI', 'DUCRAY',
    'Hair_Scalp_Care', 
    'hair_conditioner_balm', 
    'Redensifying anti-aging hair conditioner for thinning hair volume.', 
    FALSE
),
(
    78723, 
    'DUCRAY KELUAL DS SHAM TREAT ANT-DAND100ML #C#', 
    'دوكري كيلوال دي إس شامبو معالج ومضاد للقشرة 100 مل', 
    819.00, 819.00, 'COSMO-MI', 'DUCRAY',
    'Hair_Scalp_Care', 
    'anti_dandruff_shampoo', 
    'Intensive anti-dandruff treatment shampoo for severe flaking and scaling scalps.', 
    FALSE
),
(
    79831, 
    'DUCRAY NUTRICERAT EMULSION HAIR NURTRV #B#', 
    'دوكري نوتري سيرات مستحلب مغذي ومرطب للشعر الجاف 75 مل', 
    250.00, 250.00, 'COSMO-MI', 'DUCRAY',
    'Hair_Scalp_Care', 
    'hair_conditioner_balm', 
    'Nutritive hair emulsion designed to repair and nourish dry hair strands.', 
    FALSE
),
(
    146493, 
    'DUCRAY RUBEFIANT TONIFYING GEL 30ML (HAIR LOSS)', 
    'دوكري جل منشط ومحفز لفروة الرأس ومقاوم لتساقط الشعر 30 مل', 
    750.00, 750.00, 'COSMO-MI', 'DUCRAY',
    'Hair_Scalp_Care', 
    'scalp_treatment_leave_in', 
    'Tonifying scalp gel treatment formulated to stimulate microcirculation and fight hair loss.', 
    FALSE
),
(
    83439, 
    'DUCRAY (ANAPHASE+)SHAM 200ML بوبرية HAIR LOSS', 
    'دوكري أنافاز بلس شامبو معالج ومضاد لتساقط الشعر 200 مل', 
    719.00, 719.00, 'COSMO-MI', 'DUCRAY',
    'Hair_Scalp_Care', 
    'anti_hair_loss_shampoo', 
    'Complementary anti-hair loss strengthening shampoo to restore hair volume and vigor.', 
    FALSE
),
(
    145487, 
    'DUCRAY (ANAPHASE+)SHAM 200ML +COND 200ML DUO(1+1)FR', 
    'دوكري مجموعة أنافاز بلس شامبو 200 مل + بلسم 200 مل', 
    819.00, 819.00, 'COSMO-MI', 'DUCRAY',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Promotional bundle set combining anti-hair loss shampoo and conditioner.', 
    TRUE
),
(
    109676, 
    'EUCERIN DERMO-PURIFYER OIL SOOTH CREAM 50ML كود جديد', 
    'يوسيرين ديرمو بيوريفايير كريم مهدئ للبشرة المعرضة للشوائب 50 مل', 
    941.00, 941.00, 'COSMO-MI', 'GERMANY',
    'Acne_Oil_Control', 
    'soothing_acne_moisturizer', 
    'Soothing and calming moisturizing cream for blemish-prone skin weakened by drying treatments.', 
    FALSE
),
(
    138681, 
    'EUCERIN DERMOPURE(TRIPLE ACTION) SERUM 40ML', 
    'يوسيرين ديرمو بيور سيروم ثلاثي المفعول للبشرة 40 مل', 
    850.00, 850.00, 'COSMO-MI', 'GERMANY',
    'Acne_Oil_Control', 
    'acne_resurfacing_serum', 
    'Triple-action serum formulated with Thiamidol and acids to target blemishes and post-acne marks.', 
    FALSE
),
(
    109665, 
    'EUCERIN HYALURON-FILLER DAY CREAM SPF15 50ML', 
    'يوسيرين هيالورون فيلر كريم نهاري مقاوم للتجاعيد SPF15 بحجم 50 مل', 
    1700.00, 1700.00, 'COSMO-MI', 'POLANDA',
    'Anti_Aging_Skin_Rejuvenation', 
    'anti_aging_day_cream', 
    'Anti-aging day cream with hyaluronic acid and SPF15 to plump deep wrinkles.', 
    FALSE
),
(
    109671, 
    'EUCERIN HYALURON-FLR EYE EFFECT SPF15 15ML', 
    'يوسيرين هيالورون فيلر كريم العين المقاوم للتجاعيد SPF15 بحجم 15 مل', 
    1255.00, 1255.00, 'COSMO-MI', 'POLANDA',
    'Specialized_Care', 
    'eye_contour_care', 
    'Anti-aging eye contour cream with SPF15 to target wrinkles around the eyes.', 
    FALSE
),
(
    111134, 
    'EUCERIN SUN CREAM SPF50+ 50ML', 
    'يوسيرين كريم واقي شمس عالي الحماية SPF50+ بحجم 50 مل', 
    1100.00, 1100.00, 'COSMO-MI', 'GERMANY',
    'Sun_Protection', 
    'hydrating_facial_sunscreen', 
    'High protection facial sunscreen cream with broad-spectrum SPF50+.', 
    FALSE
),
(
    140087, 
    'EUCERIN (DERMO PURE)TRIPLE CLEAN GEL 150ML كود جديد', 
    'يوسيرين ديرمو بيور جل غسول منظف ثلاثي المفعول 150 مل', 
    635.00, 635.00, 'COSMO-MI', 'GERMANY',
    'Skin_Cleansing', 
    'purifying_cleansing_gel', 
    'Triple-action purifying cleansing gel for blemish-prone and oily skin.', 
    FALSE
),
(
    141463, 
    'EUCERIN (DERMO-PURE)150M CLEAN GEL CORRECTعبوة', 
    'يوسيرين ديرمو بيور جل غسول منظف مصحح 150 مل', 
    805.00, 805.00, 'COSMO-MI', 'GERMANY',
    'Skin_Cleansing', 
    'purifying_cleansing_gel', 
    'Corrective cleansing gel for clearing impurities and excess sebum.', 
    FALSE
),
(
    131535, 
    'EUCERIN (DERMO-PURIFYER)TRIPLE CLEAN GEL 150ML كود', 
    'يوسيرين ديرمو بيوريفايير جل غسول منظف ثلاثي المفعول 150 مل', 
    635.00, 635.00, 'COSMO-MI', 'GERMANY',
    'Skin_Cleansing', 
    'purifying_cleansing_gel', 
    'Purifying cleansing gel formulated to target blemishes and clear pores.', 
    FALSE
),
(
    139371, 
    'EUCERIN DERMO PURE CLEANS GEL 200ML', 
    'يوسيرين ديرمو بيور جل غسول منظف للبشرة 200 مل', 
    799.00, 799.00, 'COSMO-MI', 'GERMANY',
    'Skin_Cleansing', 
    'purifying_cleansing_gel', 
    'Cleansing gel designed to purify oily, blemish-prone skin gently.', 
    FALSE
),
(
    139372, 
    'EUCERIN DERMO PURE PURIFY TONER 200ML', 
    'يوسيرين ديرمو بيور لوشن تونر منظف ومقشر 200 مل', 
    799.00, 799.00, 'COSMO-MI', 'GERMANY',
    'Acne_Oil_Control', 
    'astringent_pore_toner', 
    'Purifying clarifying toner to unclog pores and refine skin texture.', 
    FALSE
),
(
    145869, 
    'EUCERIN DERMO PURE(1+30%)HYDRA40M+GEL 200ML ان خصم', 
    'يوسيرين ديرمو بيور مجموعة كريم هيدرا 40 مل + غسول 200 مل', 
    1221.00, 1221.00, 'COSMO-MI', 'GERMANY',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Promotional combo bundle containing moisturizer and purifying cleanser.', 
    TRUE
),
(
    115002, 
    'EUCERIN DERMO PURIF PROTECT FLUID 50M SPF30', 
    'يوسيرين ديرمو بيوريفايير فلويد حماية واقي شمس SPF30 بحجم 50 مل', 
    950.00, 950.00, 'COSMO-MI', 'POLANDA',
    'Sun_Protection', 
    'mattifying_facial_sunscreen', 
    'Protective fluid sunscreen with SPF30 tailored for blemish-prone skin.', 
    FALSE
),
(
    109677, 
    'EUCERIN DERMO-PURIFYER CLEANS GEL 200ML 13 كود جديد', 
    'يوسيرين ديرمو بيوريفايير جل غسول منظف للبشرة 200 مل', 
    635.00, 635.00, 'COSMO-MI', 'GERMANY',
    'Skin_Cleansing', 
    'purifying_cleansing_gel', 
    'Daily cleansing gel for purifying oily and acne-prone skin.', 
    FALSE
),
(
    109675, 
    'EUCERIN DERMO-PURIFYER SKIN RENEWAL 40ML', 
    'يوسيرين ديرمو بيوريفايير سيروم مجدد ومقشر للبشرة 40 مل', 
    775.00, 775.00, 'COSMO-MI', 'POLANDA',
    'Acne_Oil_Control', 
    'acne_resurfacing_serum', 
    'Skin renewal treatment serum formulated to unclog pores and resurface blemish-prone skin.', 
    FALSE
),
(
    115366, 
    'EUCERIN DERMO-PURIFYER TONER 200ML 139372 كود جديد', 
    'يوسيرين ديرمو بيوريفايير لوشن تونر منظف ومقشر 200 مل', 
    599.00, 599.00, 'COSMO-MI', 'GERMANY',
    'Acne_Oil_Control', 
    'astringent_pore_toner', 
    'Clarifying facial toner for clearing impurities and tightening pores.', 
    FALSE
),
(
    109680, 
    'EUCERIN DERMO-PURIFYER TRIPLE SERUM 40ML 1 كود جديد', 
    'يوسيرين ديرمو بيوريفايير سيروم ثلاثي المفعول 40 مل', 
    799.00, 799.00, 'COSMO-MI', 'GERMANY',
    'Acne_Oil_Control', 
    'acne_resurfacing_serum', 
    'Triple effect anti-blemish and anti-mark serum for problem skin.', 
    FALSE
),
(
    138686, 
    'EUCERIN DERMO-PURIFYER(1+50)GEL 200ML+TONER 200ML', 
    'يوسيرين ديرمو بيوريفايير مجموعة جل غسول 200 مل + تونر 200 مل', 
    899.00, 899.00, 'COSMO-MI', 'GERMANY',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Promotional combo bundle containing cleansing gel and toner.', 
    TRUE
),
(
    141907, 
    'EUCERIN DERMOPURE HYDRA REPAIR 40ML', 
    'يوسيرين ديرمو بيور كريم هيدرا مرمم ومهدئ للبشرة 40 مل', 
    945.00, 945.00, 'COSMO-MI', 'GERMANY',
    'Acne_Oil_Control', 
    'soothing_acne_moisturizer', 
    'Intensive soothing and moisturizing care for acne-prone skin undergoing medical treatments.', 
    FALSE
),
INSERT INTO cosmeceutical_product_classification_full (
    code, name_en, name_ar, price_1, price_2, category, supplier,
    domain, subcategory, reason, review_required
) VALUES
(
    138687, 
    'EUCERIN HYALU-FILLER(1+1)NIGHT CREAM 50ML +EYE 15ML %25', 
    'يوسيرين هيالورون فيلر مجموعة كريم ليلي 50 مل + كريم عين 15 مل', 
    1932.00, 1932.00, 'COSMO-MI', 'POLANDA',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Promotional combo bundle set combining anti-aging night cream and eye cream.', 
    TRUE
),
(
    109673, 
    'EUCERIN HYALURON-FILLER NIGHT CREAM 50ML', 
    'يوسيرين هيالورون فيلر كريم ليلي مقاوم للتجاعيد 50 مل', 
    1500.00, 1500.00, 'COSMO-MI', 'POLANDA',
    'Anti_Aging_Skin_Rejuvenation', 
    'anti_aging_night_cream', 
    'Anti-aging nighttime moisturizing cream with hyaluronic acid to plump and reduce wrinkles.', 
    FALSE
),
(
    109674, 
    'EUCERIN HYALURON-FLR VITAMIN C SERUM 8ML #B#', 
    'يوسيرين هيالورون فيلر سيروم فيتامين سي المضاد للشيخوخة 8 مل', 
    975.00, 975.00, 'COSMO-MI', 'GERMANY',
    'Anti_Aging_Skin_Rejuvenation', 
    'antioxidant_radiance_serum', 
    'Vitamin C booster serum designed to fight photoaging, brighten, and smooth skin.', 
    FALSE
),
(
    109672, 
    'EUCERIN HYALURON-FLR SERUM 30ML MOISTURE BOOSTER', 
    'يوسيرين هيالورون فيلر سيروم مرطب معزز لنضارة البشرة 30 مل', 
    1500.00, 1500.00, 'COSMO-MI', 'POLANDA',
    'Anti_Aging_Skin_Rejuvenation', 
    'anti_aging_serum', 
    'Moisture-boosting facial serum formulated with hyaluronic acid for deep hydration and fine line smoothing.', 
    FALSE
),
(
    133919, 
    'EUCERIN MOIST BOOSTER 30ML+PHOTO AGE SUN FLUID 50ML F', 
    'يوسيرين مجموعة مويست بوستر سيروم 30 مل + فوتو إيج واقي شمس 50 مل', 
    1850.00, 1850.00, 'COSMO-MI', 'GERMANY',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Promotional combo bundle containing moisture serum and sun fluid across distinct domains.', 
    TRUE
),
(
    130599, 
    'EUCERIN PIG-PERFECT CLEANS GEL 200ML', 
    'يوسيرين بيجمنت بيرفكت جل غسول منظف ومفتح للبشرة 200 مل', 
    850.00, 850.00, 'COSMO-MI', 'GERMANY',
    'Skin_Cleansing', 
    'brightening_cleansing_gel', 
    'Brightening and purifying facial cleansing gel designed to target uneven skin tone.', 
    FALSE
),
(
    130808, 
    'EUCERIN PIG-PERFECT EYE CREAM 15ML', 
    'يوسيرين بيجمنت بيرفكت كريم العناية بالعين ومقاوم البقع 15 مل', 
    1755.00, 1755.00, 'COSMO-MI', 'GERMANY',
    'Specialized_Care', 
    'eye_contour_care', 
    'Specialized eye contour cream targeting dark circles and hyperpigmentation around the eyes.', 
    FALSE
),
(
    109682, 
    'EUCERIN PIGMENT PERFECT DAY CRE SPF30 50ML', 
    'يوسيرين بيجمنت بيرفكت كريم نهاري واقي شمس ومفتح للبقع SPF30 بحجم 50 مل', 
    1755.00, 1755.00, 'COSMO-MI', 'GERMANY',
    'Pigmentation_Skin_Tone', 
    'pigmentation_day_cream', 
    'Daily corrective day cream with Thiamidol and SPF30 to reduce and prevent dark spots.', 
    FALSE
),
(
    109681, 
    'EUCERIN PIGMENT PERFECT DUAL SERUM 30ML', 
    'يوسيرين بيجمنت بيرفكت سيروم مزدوج المفعول لعلاج البقع الداكنة 30 مل', 
    2300.00, 2300.00, 'COSMO-MI', 'GERMANY',
    'Pigmentation_Skin_Tone', 
    'anti_pigmentation_serum', 
    'Dual-action intensive serum formulated to reduce stubborn hyperpigmentation and even skin tone.', 
    FALSE
),
(
    130600, 
    'EUCERIN PIGMENT PERFECT ILLUMINAT SERum 30ML', 
    'يوسيرين بيجمنت بيرفكت سيروم مضيء وموحد للون البشرة 30 مل', 
    1800.00, 1800.00, 'COSMO-MI', 'GERMANY',
    'Pigmentation_Skin_Tone', 
    'anti_pigmentation_serum', 
    'Illuminating serum designed to boost radiance and fade dark spots.', 
    FALSE
),
(
    109683, 
    'EUCERIN PIGMENT PERFECT NIGHT CREAM 50ML', 
    'يوسيرين بيجمنت بيرفكت كريم ليلي مجدد ومفتح للبشرة 50 مل', 
    1755.00, 1755.00, 'COSMO-MI', 'GERMANY',
    'Pigmentation_Skin_Tone', 
    'night_spot_corrector', 
    'Nighttime corrective cream designed to renew skin and reduce dark spots while sleeping.', 
    FALSE
),
(
    115365, 
    'EUCERIN SUN HYDRO PROTECT ULTRA LIGHT FLUID SPF50', 
    'يوسيرين سان هيدرو بروتكت فلويد خفيف جداً واقي شمس SPF50 بحجم 50 مل', 
    1100.00, 1100.00, 'COSMO-MI', 'GERMANY',
    'Sun_Protection', 
    'facial_sunscreen_fluid', 
    'Ultra-lightweight hydrating facial sunscreen fluid with broad-spectrum SPF50.', 
    FALSE
),
(
    133380, 
    'EUCERIN SUN OILDRY TOUCH 50M+ GEL200M+TONER200ML', 
    'يوسيرين مجموعة واقي شمس دراي توش 50 مل + جل غسول 200 مل + تونر 200 مل', 
    1588.00, 1588.00, 'COSMO-MI', 'POLANDA',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Multi-product promotional bundle set combining sunscreen, cleanser, and toner across distinct domains.', 
    TRUE
),
(
    109688, 
    'EUCERIN SUN PIGMENT CONTROL SPF50+ 50ML', 
    'يوسيرين سان بيجمنت كنترول واقي شمس مضاد للبقع SPF50+ بحجم 50 مل', 
    1100.00, 1100.00, 'COSMO-MI', 'GERMANY',
    'Sun_Protection', 
    'pigmentation_sunscreen_fluid', 
    'Anti-pigmentation facial sunscreen with very high SPF50+ defense against sun-induced dark spots.', 
    FALSE
),
(
    109687, 
    'EUCERIN SUN-OIL DRY TOUCH SPF50 50ML', 
    'يوسيرين سان أيل دراي توش واقي شمس ملمس جاف للبشرة الدهنية SPF50 بحجم 50 مل', 
    1100.00, 1100.00, 'COSMO-MI', 'POLANDA',
    'Sun_Protection', 
    'mattifying_facial_sunscreen', 
    'Dry-touch oil-control facial sunscreen with SPF50 tailored for oily and acne-prone skin.', 
    FALSE
),
(
    109686, 
    'EUCERIN SUN-PHOTO AGE FLUID SPF50 50ML', 
    'يوسيرين سان فوتو إيج فلويد واقي شمس ومقاوم لعلامات الشيخوخة SPF50 بحجم 50 مل', 
    1050.00, 1050.00, 'COSMO-MI', 'POLANDA',
    'Sun_Protection', 
    'anti_aging_sunscreen', 
    'Anti-aging photo-protective facial fluid sunscreen with SPF50.', 
    FALSE
),
(
    89133, 
    'LOREAL SHAMP EXTRA NORMAL 600ML ELVIVE', 
    'لوريال إلفيف إكستรอأوردينيري شامبو مغذي للشعر العادي 600 مل', 
    255.00, 255.00, 'Hair Shamp', 'LOREAL',
    'Hair_Scalp_Care', 
    'nourishing_hair_shampoo', 
    'Nourishing shampoo formulated for normal hair care and cleansing.', 
    FALSE
),
(
    89134, 
    'LOREAL SHAMP EXTRA OIL JOJOBA DRY 600ML ELVIVE', 
    'لوريال إلفيف إكسترا أوردينيري شامبو بالزيوت المستخلصة للجافة 600 مل', 
    255.00, 255.00, 'Hair Shamp', 'LOREAL',
    'Hair_Scalp_Care', 
    'nourishing_hair_shampoo', 
    'Nourishing oil-infused shampoo designed for dry hair hydration.', 
    FALSE
),
(
    91971, 
    'LOREAL SHAMP EXTRA OIL NOURIS DRY 200ML ELVIVE', 
    'لوريال إلفيف إكسترا أوردينيري شامبو مغذي للشعر الجاف 200 مل', 
    120.00, 120.00, 'Hair Shamp', 'LOREAL',
    'Hair_Scalp_Care', 
    'nourishing_hair_shampoo', 
    'Nourishing shampoo for dry hair care cleansing.', 
    FALSE
),
(
    46453, 
    'LOREAL SHAMP FALL RESIST 200ML ELVIVE', 
    'لوريال إلفيف فول ريزيست شامبو مقاوم لتساقط الشعر 200 مل', 
    120.00, 120.00, 'Hair Shamp', 'LOREAL',
    'Hair_Scalp_Care', 
    'anti_hair_loss_shampoo', 
    'Anti-hair fall reinforcing shampoo formulated to strengthen fragile hair.', 
    FALSE
),
(
    46451, 
    'LOREAL SHAMP FALL RESIST 400ML ELVIVE', 
    'لوريال إلفيف فول ريزيست شامبو مقاوم لتساقط الشعر 400 مل', 
    193.00, 193.00, 'Hair Shamp', 'LOREAL',
    'Hair_Scalp_Care', 
    'anti_hair_loss_shampoo', 
    'Medium-size reinforcing anti-hair fall shampoo for weak hair.', 
    FALSE
),
(
    50101, 
    'LOREAL SHAMP FALL RESIST 600ML ELVIVE', 
    'لوريال إلفيف فول ريزيست شامبو مقاوم لتساقط الشعر 600 مل', 
    255.00, 255.00, 'Hair Shamp', 'LOREAL',
    'Hair_Scalp_Care', 
    'anti_hair_loss_shampoo', 
    'Large-size anti-hair fall strengthening shampoo.', 
    FALSE
),
(
    76966, 
    'LOREAL SHAMP HYALURON MOISTURE 200ML شعر الجاف ELV', 
    'لوريال إلفيف هيالورون مويستشر شامبو مرطب للشعر الجاف 200 مل', 
    130.00, 130.00, 'Hair Shamp', 'LOREAL',
    'Hair_Scalp_Care', 
    'moisturizing_hair_shampoo', 
    'Hyaluronic acid-infused moisturizing shampoo for dry hair hydration.', 
    FALSE
),
(
    76987, 
    'LOREAL SHAMP HYALURON MOISTURE 400ML شعر الجاف ELV', 
    'لوريال إلفيف هيالورون مويستشر شامبو مرطب للشعر الجاف 400 مل', 
    213.00, 213.00, 'Hair Shamp', 'LOREAL',
    'Hair_Scalp_Care', 
    'moisturizing_hair_shampoo', 
    'Hydrating moisture-locking shampoo for dry hair.', 
    FALSE
),
(
    76988, 
    'LOREAL SHAMP HYALURON MOISTURE 600ML شعر الجاف ELV', 
    'لوريال إلفيف هيالورون مويستشر شامبو مرطب للشعر الجاف 600 مل', 
    275.00, 275.00, 'Hair Shamp', 'LOREAL',
    'Hair_Scalp_Care', 
    'moisturizing_hair_shampoo', 
    'Large-size moisture-replenishing shampoo for dry hair.', 
    FALSE
),
(
    7660, 
    'LOREAL SHAMP LOW EXTRA OIL DRY HAIR 400ML 3IN1 ELV', 
    'لوريال إلفيف إكسترا أوردينيري شامبو كريمي 3 في 1 للشعر الجاف 400 مل', 
    427.00, 427.00, 'Hair Shamp', 'LOREAL',
    'Hair_Scalp_Care', 
    'nourishing_hair_shampoo', 
    '3-in-1 low-lather creamy cleansing shampoo for dry hair care.', 
    FALSE
),
(
    87050, 
    'LOREAL SHAMP T.REPAIR DAMAGE HAIR 400ML ELVIVE', 
    'لوريال إلفيف توتال ريبير شامبو معالج للشعر التالف 400 مل', 
    193.00, 193.00, 'Hair Shamp', 'LOREAL',
    'Hair_Scalp_Care', 
    'repairing_hair_shampoo', 
    'Repairing shampoo formulated for damaged and weakened hair strands.', 
    FALSE
),
(
    50096, 
    'LOREAL SHAMP T.REPAIR DAMAGE HAIR 600ML ELVIVE', 
    'لوريال إلفيف توتال ريبير شامبو معالج للشعر التالف 600 مل', 
    255.00, 255.00, 'Hair Shamp', 'LOREAL',
    'Hair_Scalp_Care', 
    'repairing_hair_shampoo', 
    'Large-size hair repairing and strengthening shampoo.', 
    FALSE
),
(
    87110, 
    'LOREAL SHAMP TOTAL REPAIR DAMAGED 200ML ELVIVE', 
    'لوريال إلفيف توتال ريبير شامبو معالج للشعر التالف 200 مل', 
    120.00, 120.00, 'Hair Shamp', 'LOREAL',
    'Hair_Scalp_Care', 
    'repairing_hair_shampoo', 
    'Damage-repairing shampoo for dry and broken hair.', 
    FALSE
),
(
    145101, 
    'LOREAL SHAMP(COLLAGEN LIFTER)200ML الشعر الخفيف ELV', 
    'لوريال إلفيف كولاجين ليفت شامبو مكثف للشعر الخفيف 200 مل', 
    130.00, 130.00, 'Hair Shamp', 'LOREAL',
    'Hair_Scalp_Care', 
    'volumizing_hair_shampoo', 
    'Volumizing and lifting shampoo for fine and thinning hair.', 
    FALSE
),
(
    145102, 
    'LOREAL SHAMP(COLLAGEN LIFTER)400ML الشعر الخفيف ELV', 
    'لوريال إلفيف كولاجين ليفت شامبو مكثف للشعر الخفيف 400 مل', 
    213.00, 213.00, 'Hair Shamp', 'LOREAL',
    'Hair_Scalp_Care', 
    'volumizing_hair_shampoo', 
    'Medium-size body-building volume shampoo for fine hair.', 
    FALSE
),
(
    145106, 
    'LOREAL SHAMP(COLLAGEN LIFTER)600ML الشعر الخفيف ELV', 
    'لوريال إلفيف كولاجين ليفت شامبو مكثف للشعر الخفيف 600 مل', 
    275.00, 275.00, 'Hair Shamp', 'LOREAL',
    'Hair_Scalp_Care', 
    'volumizing_hair_shampoo', 
    'Large-size volumizing shampoo for fine hair fiber support.', 
    FALSE
),
(
    137380, 
    'LOREAL SPRAY GLYCOLIC GLOSS 6% 150ML الشعر الباهت', 
    'لوريال جلايكوليك جلوس بخاخ لمعان للشعر الباهت 6% بحجم 150 مل', 
    550.00, 550.00, 'Hair Oil', 'LOREAL',
    'Hair_Scalp_Care', 
    'hair_gloss_treatment', 
    'Gloss-enhancing laminate spray treatment for dull and lifeless hair.', 
    FALSE
),
(
    145804, 
    'LOREAL(1+1)HAIR DRY SERUM100M+SHAM NORM200M FRE', 
    'لوريال مجموعة عرض سيروم جاف 100 مل + شامبو عادي 200 مل', 
    550.00, 550.00, 'Hair Oil', 'LOREAL',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Promotional bundle set combining hair serum and shampoo across hair care categories.', 
    TRUE
),
(
    146214, 
    'LOREAL REVITALIFT NIGHT CREAM 50ML كريم ترطيب ليلي', 
    'لوريال ريفيتاليفت كريم ترطيب ليلي مقاوم للتجاعيد 50 مل', 
    400.00, 400.00, 'Cream Top', 'LOREAL',
    'Anti_Aging_Skin_Rejuvenation', 
    'anti_aging_night_cream', 
    'Anti-wrinkle firming night cream formulated for facial skin rejuvenation.', 
    FALSE
),
(
    123905, 
    'LOREAL SERUM FALL (AMINEXIL) 102ML ELVIVE', 
    'لوريال إلفيف أمينكسيل سيروم معالج ومضاد لتساقط الشعر 102 مل', 
    675.00, 675.00, 'NA', 'LOREAL',
    'Hair_Scalp_Care', 
    'anti_hair_loss_treatment', 
    'Aminexil-infused scalp serum treatment to anchor roots and reduce hair loss.', 
    FALSE
),
(
    129964, 
    'LOREAL SERUM OI. CONTROL102ML(HYALURON PURE)', 
    'لوريال هيالورون بيور سيروم متحكم بالدهون لفروة الرأس 102 مل', 
    460.00, 460.00, 'NA', 'LOREAL',
    'Hair_Scalp_Care', 
    'scalp_treatment_leave_in', 
    'Scalp balancing and oil-controlling pre-shampoo/leave-in serum for oily scalps.', 
    FALSE
),
(
    133423, 
    'LOREAL SHAMP (GLYCOLIC GLOSS ) 200ML شامبو فائق لـ', 
    'لوريال جلايكوليك جلوس شامبو لمعان الشعر الفائق 200 مل', 
    130.00, 130.00, 'NA', 'LOREAL',
    'Hair_Scalp_Care', 
    'gloss_hair_shampoo', 
    'Glycolic acid gloss-infusing shampoo to laminate and brighten dull hair.', 
    FALSE
),
(
    133422, 
    'LOREAL SHAMP (GLYCOLIC GLOSS ) 400ML شامبو فائق لـ', 
    'لوريال جلايكوليك جلوس شامبو لمعان الشعر الفائق 400 مل', 
    213.00, 213.00, 'NA', 'LOREAL',
    'Hair_Scalp_Care', 
    'gloss_hair_shampoo', 
    'Medium-size glycolic gloss shampoo for hair shine restoration.', 
    FALSE
),
(
    133418, 
    'LOREAL SHAMP (GLYCOLIC GLOSS ) 600ML شامبو فائق لـ', 
    'لوريال جلايكوليك جلوس شامبو لمعان الشعر الفائق 600 مل', 
    275.00, 275.00, 'NA', 'LOREAL',
    'Hair_Scalp_Care', 
    'gloss_hair_shampoo', 
    'Large-size gloss shampoo for enhanced hair reflection and smoothness.', 
    FALSE
),
(
    123907, 
    'LOREAL SHAMP (HYALU PURE ) 400ML الشعر الدهني ELV', 
    'لوريال إلفيف هيالورون بيور شامبو لتنظيف وعناية الشعر الدهني 400 مل', 
    213.00, 213.00, 'NA', 'LOREAL',
    'Hair_Scalp_Care', 
    'purifying_hair_shampoo', 
    'Purifying balancing shampoo formulated for oily hair and roots.', 
    FALSE
),
(
    123906, 
    'LOREAL SHAMP (HYALURON PURE ) 200ML الشعر الدهني E', 
    'لوريال إلفيف هيالورون بيور شامبو لتنظيف وعناية الشعر الدهني 200 مل', 
    130.00, 130.00, 'NA', 'LOREAL',
    'Hair_Scalp_Care', 
    'purifying_hair_shampoo', 
    'Purifying shampoo for managing oily hair and roots.', 
    FALSE
),
(
    123908, 
    'LOREAL SHAMP (HYALURON PURE ) 600ML الشعر الدهني EL', 
    'لوريال إلفيف هيالورون بيور شامبو لتنظيف وعناية الشعر الدهني 600 مل', 
    275.00, 275.00, 'NA', 'LOREAL',
    'Hair_Scalp_Care', 
    'purifying_hair_shampoo', 
    'Large-size purifying shampoo for oily scalp and hair care.', 
    FALSE
),
(
    85041, 
    'LOREAL SHAMP DREAM LONG 200ML ELVIVE #C#', 
    'لوريال إلفيف دريم لونج شامبو لشعر طويل ومتقصف 200 مل', 
    120.00, 120.00, 'Hair Shamp', 'LOREAL',
    'Hair_Scalp_Care', 
    'repairing_hair_shampoo', 
    'Restorative shampoo formulated for long, damaged hair with split ends.', 
    FALSE
),
(
    85075, 
    'LOREAL SHAMP DREAM LONG 400ML ELVIVE #C#', 
    'لوريال إلفيف دريم لونج شامبو لشعر طويل ومتقصف 400 مل', 
    190.00, 190.00, 'Hair Shamp', 'LOREAL',
    'Hair_Scalp_Care', 
    'repairing_hair_shampoo', 
    'Medium-size restorative shampoo for long, brittle hair.', 
    FALSE
),
(
    3279, 
    'LOREAL SHAMP DREAM LONG 600ML ELVIVE #C#', 
    'لوريال إلفيف دريم لونج شامبو لشعر طويل ومتقصف 600 مل', 
    250.00, 250.00, 'Hair Shamp', 'LOREAL',
    'Hair_Scalp_Care', 
    'repairing_hair_shampoo', 
    'Large-size restorative long-hair strengthening shampoo.', 
    FALSE
),
(
    23575, 
    'LOREAL SHAMP DREAM LONG STRAIGH 400ML ELVIVE', 
    'لوريال إلفيف دريم لونج سترايت شامبو لتنعيم الشعر الطويل 400 مل', 
    193.00, 193.00, 'Hair Shamp', 'LOREAL',
    'Hair_Scalp_Care', 
    'smoothing_hair_shampoo', 
    'Smoothing and straightening shampoo formulated for long hair control.', 
    FALSE
),
(
    49283, 
    'LOREAL SHAMP DREAM LONG STRAIGHT 200ML ELVIVE', 
    'لوريال إلفيف دريم لونج سترايت شامبو لتنعيم الشعر الطويل 200 مل', 
    120.00, 120.00, 'Hair Shamp', 'LOREAL',
    'Hair_Scalp_Care', 
    'smoothing_hair_shampoo', 
    'Smoothing shampoo for managing long hair frizz and straightening.', 
    FALSE
),
(
    37599, 
    'LOREAL SHAMP DREAM LONGSTRAIGH 600ML ELVIVE', 
    'لوريال إلفيف دريم لونج سترايت شامبو لتنعيم الشعر الطويل 600 مل', 
    255.00, 255.00, 'Hair Shamp', 'LOREAL',
    'Hair_Scalp_Care', 
    'smoothing_hair_shampoo', 
    'Large-size smoothing anti-frizz shampoo for long hair.', 
    FALSE
),
(
    91970, 
    'LOREAL SHAMP EXTR OIL JOJOBA DRY 400ML ELVIVE', 
    'لوريال إلفيف إكسترا أوردينيري شامبو بالزيوت للشعر الجاف 400 مل', 
    193.00, 193.00, 'Hair Shamp', 'LOREAL',
    'Hair_Scalp_Care', 
    'nourishing_hair_shampoo', 
    'Nourishing oil shampoo for dry hair care and moisture restoration.', 
    FALSE
),
(
    91968, 
    'LOREAL SHAMP EXTRA NORMAL 200ML ELVIVE', 
    'لوريال إلفيف إكسترا أوردينيري شامبو مغذي للشعر العادي 200 مل', 
    120.00, 120.00, 'Hair Shamp', 'LOREAL',
    'Hair_Scalp_Care', 
    'nourishing_hair_shampoo', 
    'Nourishing everyday shampoo for normal hair cleansing.', 
    FALSE
),
(
    91987, 
    'LOREAL SHAMP EXTRA NORMAL 400ML ELVIVE', 
    'لوريال إلفيف إكسترا أوردينيري شامبو مغذي للشعر العادي 400 مل', 
    193.00, 193.00, 'Hair Shamp', 'LOREAL',
    'Hair_Scalp_Care', 
    'nourishing_hair_shampoo', 
    'Medium-size nourishing shampoo for normal hair.', 
    FALSE
),
(
    130602, 
    'LOREAL PRODIGY (2.1) COLOR اسود رمادي', 
    'لوريال بروديجى صبغة شعر لون أسود رمادي', 
    450.00, 450.00, 'Hair Dyes', 'LOREAL',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Cosmetic permanent hair dye product outside core cosmeceutical scope.', 
    TRUE
),
(
    94761, 
    'LOREAL PRODIGY (3.0) COLOR بني غامق', 
    'لوريال بروديجى صبغة شعر لون بني غامق', 
    450.00, 450.00, 'Hair Dyes', 'LOREAL',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Cosmetic permanent hair dye product outside core cosmeceutical scope.', 
    TRUE
),
(
    97368, 
    'LOREAL PRODIGY (4.0) COLOR مسبيا بني', 
    'لوريال بروديجى صبغة شعر لون بني طبيعي', 
    450.00, 450.00, 'Hair Dyes', 'LOREAL',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Cosmetic permanent hair dye product outside core cosmeceutical scope.', 
    TRUE
),
(
    98780, 
    'LOREAL PRODIGY (4.15) COLOR بني بارد', 
    'لوريال بروديجى صبغة شعر لون بني بارد', 
    450.00, 450.00, 'Hair Dyes', 'LOREAL',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Cosmetic permanent hair dye product outside core cosmeceutical scope.', 
    TRUE
),
(
    95570, 
    'LOREAL PRODIGY (5.3) COLOR بني ذهبي فاتح', 
    'لوريال بروديجى صبغة شعر لون بني ذهبي فاتح', 
    450.00, 450.00, 'Hair Dyes', 'LOREAL',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Cosmetic permanent hair dye product outside core cosmeceutical scope.', 
    TRUE
),
(
    94762, 
    'LOREAL PRODIGY (6.0) COLOR اشقر غامق', 
    'لوريال بروديجى صبغة شعر لون أشقر غامق', 
    450.00, 450.00, 'Hair Dyes', 'LOREAL',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Cosmetic permanent hair dye product outside core cosmeceutical scope.', 
    TRUE
),
(
    132718, 
    'LOREAL PRODIGY (6.6) COLOR احمر غامق', 
    'لوريال بروديجى صبغة شعر لون أحمر غامق', 
    450.00, 450.00, 'Hair Dyes', 'LOREAL',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Cosmetic permanent hair dye product outside core cosmeceutical scope.', 
    TRUE
),
(
    94764, 
    'LOREAL PRODIGY (7.0) COLOR اشقر دافئ', 
    'لوريال بروديجى صبغة شعر لون أشقر دافئ', 
    450.00, 450.00, 'Hair Dyes', 'LOREAL',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Cosmetic permanent hair dye product outside core cosmeceutical scope.', 
    TRUE
),
(
    99429, 
    'LOREAL PRODIGY (7.1) COLOR اشقر رمادي', 
    'لوريال بروديجى صبغة شعر لون أشقر رمادي', 
    450.00, 450.00, 'Hair Dyes', 'LOREAL',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Cosmetic permanent hair dye product outside core cosmeceutical scope.', 
    TRUE
),
(
    94765, 
    'LOREAL PRODIGY (8.0) COLOR اشقر فاتح', 
    'لوريال بروديجى صبغة شعر لون أشقر فاتح', 
    450.00, 450.00, 'Hair Dyes', 'LOREAL',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Cosmetic permanent hair dye product outside core cosmeceutical scope.', 
    TRUE
),
(
    99430, 
    'LOREAL PRODIGY (8.1) COLOR اشقر فتح رمادي', 
    'لوريال بروديجى صبغة شعر لون أشقر فاتح رمادي', 
    450.00, 450.00, 'Hair Dyes', 'LOREAL',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Cosmetic permanent hair dye product outside core cosmeceutical scope.', 
    TRUE
),
(
    80630, 
    'LOREAL PRODIGY (5.0) COLOR LIGHT BROWN بني فتح', 
    'لوريال بروديجى صبغة شعر لون بني فاتح', 
    450.00, 450.00, 'Hair Dyes', 'LOREAL',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Cosmetic permanent hair dye product outside core cosmeceutical scope.', 
    TRUE
),
(
    98781, 
    'LOREAL PRODIGY(6.32)COLOR اشقر ذهبي غامق', 
    'لوريال بروديجى صبغة شعر لون أشقر ذهبي غامق', 
    450.00, 450.00, 'Hair Dyes', 'LOREAL',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Cosmetic permanent hair dye product outside core cosmeceutical scope.', 
    TRUE
),
(
    146213, 
    'LOREAL REVITALIFT DAY CREAM 50ML كريم ترطيب نهارى', 
    'لوريال ريفيتاليفت كريم ترطيب نهاري مقاوم للتجاعيد 50 مل', 
    400.00, 400.00, 'Cream Top', 'LOREAL',
    'Anti_Aging_Skin_Rejuvenation', 
    'anti_aging_day_cream', 
    'Anti-aging day cream formulated to firm skin and reduce wrinkles.', 
    FALSE
),
(
    143581, 
    'LOREAL REVITALIFT GLOW MASK 25G (GLASS SKIN) قناع بريق', 
    'لوريال ريفيتاليفت قناع بريق ونضارة البشرة الزجاجية 25 جرام', 
    350.55, 350.55, 'Facial Sup', 'LOREAL',
    'Anti_Aging_Skin_Rejuvenation', 
    'firming_radiance_gel', 
    'Radiance-boosting facial sheet mask for skin brightening and glass-skin effect.', 
    FALSE
),
(
    146212, 
    'LOREAL REVITALIFT LASER EYE BAG 15ML (INSTANT ERASE)', 
    'لوريال ريفيتاليفت ليزر كريم علاج انتفاخات وعلامات العين 15 مل', 
    650.00, 650.00, 'Cream Top', 'LOREAL',
    'Specialized_Care', 
    'eye_contour_care', 
    'Targeted eye contour cream designed to smooth wrinkles and reduce eye bags.', 
    FALSE
),
(
    146211, 
    'LOREAL REVITALIFT LASER SERUM30ML', 
    'لوريال ريفيتاليفت ليزر سيروم مكافح للشيخوخة ومجدد للبشرة 30 مل', 
    670.00, 670.00, 'European Unic', 'LOREAL',
    'Anti_Aging_Skin_Rejuvenation', 
    'anti_aging_serum', 
    'Concentrated anti-aging laser-action serum targeting wrinkles and skin texture.', 
    FALSE
),
(
    143580, 
    'LOREAL REVITALIFT LIQUID CREAM 50M(GLASS SKIN) كريم', 
    'لوريال ريفيتاليفت كريم سائل مرطب وممنح لنضارة البشرة الزجاجية 50 مل', 
    600.00, 600.00, 'Cream Top', 'LOREAL',
    'Anti_Aging_Skin_Rejuvenation', 
    'antioxidant_radiance_serum', 
    'Hydrating liquid cream designed to impart radiance and smooth skin texture.', 
    FALSE
),
INSERT INTO cosmeceutical_product_classification_full (
    code, name_en, name_ar, price_1, price_2, category, supplier,
    domain, subcategory, reason, review_required
) VALUES
(
    45685, 
    'LOREAL HYALURON DAY CREAM SPF20 50ML', 
    'لوريال هيالورون إكسبيرت كريم مرطب نهاري واقي شمس SPF20 بحجم 50 مل', 
    545.00, 545.00, 'Cream Top', 'LOREAL',
    'Anti_Aging_Skin_Rejuvenation', 
    'anti_aging_day_cream', 
    'Plumping anti-aging day cream with hyaluronic acid and broad-spectrum SPF20.', 
    FALSE
),
(
    90743, 
    'LOREAL HYALURON EXPERT EYE SERUM 20ML سيروم للعينين', 
    'لوريال هيالورون إكسبيرت سيروم مرطب ومقاوم لتجاعيد العينين 20 مل', 
    810.00, 810.00, 'Facial Sup', 'LOREAL',
    'Specialized_Care', 
    'eye_contour_care', 
    'Concentrated eye serum formulated with hyaluronic acid to hydrate and smooth fine lines around the eyes.', 
    FALSE
),
(
    45513, 
    'LOREAL HYALURON EXPERT SERUM(1.5) 30ML سيروم للبشرة', 
    'لوريال هيالورون إكسبيرت سيروم مركز بنسبة 1.5% هيالورونيك أسيد 30 مل', 
    650.00, 650.00, 'Hair Oil', 'LOREAL',
    'Skin_Moisturization_Barrier', 
    'barrier_repair_hydrator', 
    'Concentrated 1.5% hyaluronic acid facial serum for intense hydration and plumping.', 
    FALSE
),
(
    84810, 
    'LOREAL HYALURON EXPERT SERUM(1.5) 15ML سيروم للبشرة', 
    'لوريال هيالورون إكسبيرت سيروم مركز بنسبة 1.5% هيالورونيك أسيد 15 مل', 
    430.00, 430.00, 'Skin Care f', 'LOREAL',
    'Skin_Moisturization_Barrier', 
    'barrier_repair_hydrator', 
    'Compact 1.5% hyaluronic acid facial serum designed to re-plump and deeply hydrate skin.', 
    FALSE
),
(
    45555, 
    'LOREAL HYALURON EYE CREAM 15ML كريم للعين', 
    'لوريال هيالورون إكسبيرت كريم مرطب ومجدد لمنطقة العين 15 مل', 
    325.00, 325.00, 'Cream Top', 'LOREAL',
    'Specialized_Care', 
    'eye_contour_care', 
    'Eye contour cream formulated with hyaluronic acid to smooth wrinkles and re-plump delicate eye area.', 
    FALSE
),
(
    109200, 
    'LOREAL HYALURON HAIR SERUM SPRAY 150ML ELVIVE #C#', 
    'لوريال إلفيف هيالورون بخاخ سيروم مرطب للشعر 150 مل #C#', 
    500.00, 500.00, 'Hair Oil', 'LOREAL',
    'Hair_Scalp_Care', 
    'scalp_treatment_leave_in', 
    'Leave-in hydrating hair spray serum formulated with hyaluronic acid to lock in moisture.', 
    FALSE
),
(
    45686, 
    'LOREAL HYALURON MASK MOIST EXP 30G ماسك ورقي للوجه', 
    'لوريال هيالورون إكسبيرت قناع ورقي مرطب للوجه 30 جرام', 
    100.00, 100.00, 'Cream Top', 'LOREAL',
    'Skin_Moisturization_Barrier', 
    'hydrating_sheet_mask', 
    'Ultra-thin tissue facial mask soaked in hyaluronic acid for intense skin re-plumping.', 
    FALSE
),
(
    45681, 
    'LOREAL HYALURON NIGHT CREAM 50ML كريم ليل', 
    'لوريال هيالورون إكسبيرت كريم مرطب ليلي 50 مل', 
    545.00, 545.00, 'Cream Top', 'LOREAL',
    'Anti_Aging_Skin_Rejuvenation', 
    'anti_aging_night_cream', 
    'Overnight re-plumping anti-aging mask-cream formulated with hyaluronic acid.', 
    FALSE
),
(
    85235, 
    'LOREAL MASK DREAM LONG 300ML ELVIVE', 
    'لوريال إلفيف دريم لونج قناع معكم ومغذي لشعر طويل ومتقصف 300 مل', 
    480.00, 480.00, 'Hair Cream', 'LOREAL',
    'Hair_Scalp_Care', 
    'repairing_hair_mask', 
    'Intensive hair mask formulated to repair long hair fiber and reduce split ends.', 
    FALSE
),
(
    92212, 
    'LOREAL MASK EXTRAORDINARY VERY DRY HAIR 300ML EL', 
    'لوريال إلفيف إكسترا أوردينيري قناع مغذي وعميق للشعر شديد الجفاف 300 مل', 
    480.00, 480.00, 'Mask skin', 'LOREAL',
    'Hair_Scalp_Care', 
    'nourishing_hair_mask', 
    'Deeply nourishing oil-infused hair mask for dry to very dry hair.', 
    FALSE
),
(
    44511, 
    'LOREAL MASK FALL RESIST POWER 300ML ELVIVE', 
    'لوريال إلفيف فول ريزيست قناع قوي ومقوي لشعر مقاوم للتساقط 300 مل', 
    480.00, 480.00, 'Hair Cream', 'LOREAL',
    'Hair_Scalp_Care', 
    'anti_hair_loss_mask', 
    'Strengthening hair mask treatment formulated to reinforce fragile, fall-prone hair.', 
    FALSE
),
(
    134291, 
    'LOREAL MICELLAR WATER 3 IN1 400ML ماء ميلاستر تنظيف', 
    'لوريال ماء ميسيلار منظف ومزيل للمكياج 3 في 1 بحجم 400 مل', 
    400.00, 400.00, 'Skin Care f', 'LOREAL',
    'Skin_Cleansing', 
    'micellar_cleansing_water', 
    '3-in-1 micellar cleansing water for makeup removal and gentle facial cleansing.', 
    FALSE
),
(
    89159, 
    'LOREAL OIL REPL FALL RESIST AMINEXIL 300ML ELVIVE', 
    'لوريال إلفيف بديل الزيت فول ريزيست معأمينكسيل مقوي ضد التساقط 300 مل', 
    193.00, 193.00, 'Hair Oil', 'LOREAL',
    'Hair_Scalp_Care', 
    'hair_oil_replacement', 
    'Aminexil-infused leave-in oil replacement cream to strengthen hair and combat fall out.', 
    FALSE
),
(
    25484, 
    'LOREAL OIL REPLACE DREAM LONG STRAIGHT 300ML ELVI', 
    'لوريال إلفيف دريم لونج سترايت بديل الزيت لتنعيم الشعر الطويل 300 مل', 
    193.00, 193.00, 'Hair Oil', 'LOREAL',
    'Hair_Scalp_Care', 
    'hair_oil_replacement', 
    'Leave-in oil replacement cream designed to smooth and manage long frizzy hair.', 
    FALSE
),
(
    96915, 
    'LOREAL OIL REPLACE T.REPAIR DAMAGE HAIR 300ML ELV', 
    'لوريال إلفيف توتال ريبير بديل الزيت المعالج لشعر تالف 300 مل', 
    193.00, 193.00, 'Hair Cream', 'LOREAL',
    'Hair_Scalp_Care', 
    'hair_oil_replacement', 
    'Restorative leave-in oil replacement cream for damaged hair fiber repair.', 
    FALSE
),
(
    92752, 
    'LOREAL OIL REPLACM EXTRAORDINARY 300ML ELVIVE', 
    'لوريال إلفيف إكسترا أوردينيري بديل الزيت المغذي للشعر 300 مل', 
    193.00, 193.00, 'Hair Cream', 'LOREAL',
    'Hair_Scalp_Care', 
    'hair_oil_replacement', 
    'Nourishing oil replacement leave-in treatment for dry, lifeless hair.', 
    FALSE
),
(
    94759, 
    'LOREAL PRODIGY (1.0) COLOR اسود', 
    'لوريال بروديجى صبغة شعر لون أسود', 
    450.00, 450.00, 'Hair Dyes0', 'LOREAL',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Cosmetic permanent hair dye product outside core cosmeceutical scope.', 
    TRUE
),
(
    130601, 
    'LOREAL PRODIGY (10.1) COLOR اشقر رمادي', 
    'لوريال بروديجى صبغة شعر لون أشقر رمادي فاتح جداً', 
    450.00, 450.00, 'Hair Dyes0', 'LOREAL',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Cosmetic permanent hair dye product outside core cosmeceutical scope.', 
    TRUE
),
(
    31757, 
    'LOREAL EXCELLENCE ASH (7.17) COLOR اشقر رمادي', 
    'لوريال إكسيلانس آش صبغة شعر لون أشقر رمادي', 
    370.00, 370.00, 'Hair Dyes0', 'LOREAL',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Cosmetic permanent hair dye product outside core cosmeceutical scope.', 
    TRUE
),
(
    30077, 
    'LOREAL EXCELLENCE ASH (8.12) COLOR اشقر لؤلؤي', 
    'لوريال إكسيلانس آش صبغة شعر لون أشقر لؤلؤي', 
    350.00, 350.00, 'Hair Dyes0', 'LOREAL',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Cosmetic permanent hair dye product outside core cosmeceutical scope.', 
    TRUE
),
(
    31655, 
    'LOREAL EXCELLENCE ASH (9.12) COLOR اشقر فاتح جدا', 
    'لوريال إكسيلانس آش صبغة شعر لون أشقر فاتح جداً لؤلؤي', 
    370.00, 370.00, 'Hair Dyes0', 'LOREAL',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Cosmetic permanent hair dye product outside core cosmeceutical scope.', 
    TRUE
),
(
    88485, 
    'LOREAL EXTRA OIL SUBLME HAIR DRY SERUM 100ML ELV', 
    'لوريال إلفيف إكسترا أوردينيري سيروم معالج ومغذي للشعر الجاف 100 مل', 
    550.00, 550.00, 'Hair Oil0', 'LOREAL',
    'Hair_Scalp_Care', 
    'nourishing_hair_serum', 
    'Nourishing oil serum designed to smooth and soften dry hair strands.', 
    FALSE
),
(
    131220, 
    'LOREAL EXTRA OIL(MIDNIGHT SERUM) DRY HAIR 100ML EL', 
    'لوريال إلفيف ميدنايت سيروم ليلي مغذي للشعر الجاف 100 مل', 
    550.00, 550.00, 'Hair Oil0', 'LOREAL',
    'Hair_Scalp_Care', 
    'nourishing_hair_serum', 
    'Overnight nourishing leave-in serum for intense dry hair hydration.', 
    FALSE
),
(
    136971, 
    'LOREAL GLYCOL BRIGHT(SPF30)DAY CREAM 50ML', 
    'لوريال جلايكوليك برايت كريم نهاري مضاد للبقع واقي شمس SPF30 بحجم 50 مل', 
    610.00, 610.00, 'Skin Care f', 'LOREAL',
    'Pigmentation_Skin_Tone', 
    'pigmentation_day_cream', 
    'Brightening day cream with glycolic acid and SPF30 targeting dark spots.', 
    FALSE
),
(
    120792, 
    'LOREAL GLYCOLIC BRIGHT DARK SPOT SERUM 15ML', 
    'لوريال جلايكوليك برايت سيروم مصحح للبقع الداكنة 15 مل', 
    500.00, 500.00, 'Skin Care f', 'LOREAL',
    'Pigmentation_Skin_Tone', 
    'anti_pigmentation_serum', 
    'Glycolic acid dark spot correcting serum for skin tone evening.', 
    FALSE
),
(
    111349, 
    'LOREAL GLYCOLIC BRIGHT DARK SPOT SERUM 30ML', 
    'لوريال جلايكوليك برايت سيروم مصحح للبقع الداكنة 30 مل', 
    700.00, 700.00, 'Hair Oil0', 'LOREAL',
    'Pigmentation_Skin_Tone', 
    'anti_pigmentation_serum', 
    'Standard size glycolic acid serum for fading hyperpigmentation and dark spots.', 
    FALSE
),
(
    120793, 
    'LOREAL GLYCOLIC BRIGHT EYE SERUM 20ML سيروم للعينين', 
    'لوريال جلايكوليك برايت سيروم تفتيح وعناية منطقة العين 20 مل', 
    750.00, 750.00, 'Facial Sup', 'LOREAL',
    'Specialized_Care', 
    'eye_contour_care', 
    'Eye contour serum designed to brighten dark circles around the eyes.', 
    FALSE
),
(
    111350, 
    'LOREAL GLYCOLIC BRIGHT FOAM CLEANSE 100ML(DAILY)', 
    'لوريال جلايكوليك برايت جل غسول رغوي يومي لتفتيح البشرة 100 مل', 
    230.00, 230.00, 'Hair Oil0', 'LOREAL',
    'Skin_Cleansing', 
    'brightening_cleansing_gel', 
    'Daily exfoliating foaming cleanser with glycolic acid for skin brightening.', 
    FALSE
),
(
    111351, 
    'LOREAL GLYCOLIC BRIGHT NIGHT CREAM 50ML', 
    'لوريال جلايكوليك برايت كريم ليلي لتفتيح وموحد للون البشرة 50 مل', 
    580.00, 580.00, 'Hair Oil0', 'LOREAL',
    'Pigmentation_Skin_Tone', 
    'night_spot_corrector', 
    'Overnight dark spot correcting cream formulated to even skin tone.', 
    FALSE
),
(
    133510, 
    'LOREAL GLYCOLIC GLOSS COMBING CREAM 200ML كريم تمشيط', 
    'لوريال جلايكوليك جلوس كريم تمشيط ومعالج للشعر 200 مل', 
    273.00, 273.00, 'Hair Cream', 'LOREAL',
    'Hair_Scalp_Care', 
    'hair_conditioner_balm', 
    'Leave-in combing cream formulated to smooth hair and enhance shine.', 
    FALSE
),
(
    115705, 
    'LOREAL HAIR CREAM EXTRA V.DRY 200ML ELVIVE #C#', 
    'لوريال إلفيف كريم مغذي لشعر شديد الجفاف 200 مل', 
    260.00, 260.00, 'Hair Cream', 'LOREAL',
    'Hair_Scalp_Care', 
    'hair_conditioner_balm', 
    'Nourishing leave-in cream for very dry hair moisture replenishment.', 
    FALSE
),
(
    96918, 
    'LOREAL HAIR CREAM FALL RESIST 200ML ELVIVE #C#', 
    'لوريال إلفيف فول ريزيست كريم مقوي ومضاد لتساقط الشعر 200 مل', 
    253.00, 253.00, 'Cream Top', 'LOREAL',
    'Hair_Scalp_Care', 
    'hair_conditioner_balm', 
    'Reinforcing leave-in hair cream designed to reduce hair breakage and fall out.', 
    FALSE
),
(
    115707, 
    'LOREAL HYALU EXPERT SHINE GEL CREAM 50ML #C#', 
    'لوريال هيالورون إكسبيرت جل كريم مرطب ومضفي للنضارة 50 مل', 
    500.00, 500.00, 'Cream Top', 'LOREAL',
    'Skin_Moisturization_Barrier', 
    'barrier_repair_hydrator', 
    'Lightweight hydrating gel-cream formulated with hyaluronic acid for radiant skin.', 
    FALSE
),
(
    112088, 
    'LOREAL HYALU HAIR CREAM 200ML NIGHT MOIST FILLING', 
    'لوريال هيالورون كريم مرطب ليلي مالئ ومغذي للشعر 200 مل', 
    273.00, 273.00, 'Hair Sham', 'LOREAL',
    'Hair_Scalp_Care', 
    'hair_conditioner_balm', 
    'Overnight leave-in moisture filling hair cream with hyaluronic acid.', 
    FALSE
),
(
    45514, 
    'LOREAL HYALU REPLUMPING GEL WASH 200ML غسول جل #C#', 
    'لوريال هيالورون إكسبيرت غسول جل مالئ ومرطب للبشرة 200 مل', 
    335.00, 335.00, 'Facial Sup', 'LOREAL',
    'Skin_Cleansing', 
    'soothing_cleansing_gel', 
    'Hydrating re-plumping gel wash with hyaluronic acid for daily facial cleansing.', 
    FALSE
),
(
    115706, 
    'LOREAL HYALU(OIL)DEEP CLEANS GEL 200ML البودرة المل', 
    'لوريال هيالورون جل غسول عميق ومنظف للبشرة 200 مل', 
    340.00, 340.00, 'Facial Sup', 'LOREAL',
    'Skin_Cleansing', 
    'purifying_cleansing_gel', 
    'Deep cleansing gel formulated to clear impurities while preserving skin moisture.', 
    FALSE
),
(
    145104, 
    'LOREAL COND(COLLAGEN LIFTER) 200ML الشعر الخفيف ELVI', 
    'لوريال إلفيف كولاجين ليفت بلسم مكثف للشعر الخفيف 200 مل', 
    138.00, 138.00, 'Hair Condit', 'LOREAL',
    'Hair_Scalp_Care', 
    'hair_conditioner_balm', 
    'Volumizing hair conditioner formulated for fine and thinning hair.', 
    FALSE
),
(
    145105, 
    'LOREAL COND(COLLAGEN LIFTER) 360ML الشعر الخفيف ELVI', 
    'لوريال إلفيف كولاجين ليفت بلسم مكثف للشعر الخفيف 360 مل', 
    223.00, 223.00, 'Hair Condit', 'LOREAL',
    'Hair_Scalp_Care', 
    'hair_conditioner_balm', 
    'Medium-size body-building volume conditioner for fine hair.', 
    FALSE
),
(
    32810, 
    'LOREAL COND(COLLAGEN LIFTER) SERUM 100ML ELVIV 32810', 
    'لوريال إلفيف كولاجين ليفت سيروم مكثف للشعر الخفيف 100 مل', 
    460.00, 460.00, 'Hair Oil0', 'LOREAL',
    'Hair_Scalp_Care', 
    'nourishing_hair_serum', 
    'Density-boosting leave-in serum for fine hair fiber thickening.', 
    FALSE
),
(
    28788, 
    'LOREAL EXCELLENCE (1) CREAM COLOR اسود', 
    'لوريال إكسيلانس كريم صبغة شعر لون أسود', 
    370.00, 370.00, 'Hair Dyes0', 'LOREAL',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Cosmetic permanent hair dye product outside core cosmeceutical scope.', 
    TRUE
),
(
    28805, 
    'LOREAL EXCELLENCE (3) COLOR بني داكن', 
    'لوريال إكسيلانس صبغة شعر لون بني داكن', 
    370.00, 370.00, 'Hair Dyes0', 'LOREAL',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Cosmetic permanent hair dye product outside core cosmeceutical scope.', 
    TRUE
),
(
    28789, 
    'LOREAL EXCELLENCE (4) COLOR بني', 
    'لوريال إكسيلانس صبغة شعر لون بني', 
    350.00, 350.00, 'Hair Dyes0', 'LOREAL',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Cosmetic permanent hair dye product outside core cosmeceutical scope.', 
    TRUE
),
(
    133421, 
    'LOREAL EXCELLENCE (4.15) COLOR بني مموج', 
    'لوريال إكسيلانس صبغة شعر لون بني مموج', 
    350.00, 350.00, 'Hair Dyes0', 'LOREAL',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Cosmetic permanent hair dye product outside core cosmeceutical scope.', 
    TRUE
),
(
    28790, 
    'LOREAL EXCELLENCE (5) COLOR بني فاتح', 
    'لوريال إكسيلانس صبغة شعر لون بني فاتح', 
    370.00, 370.00, 'Hair Dyes0', 'LOREAL',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Cosmetic permanent hair dye product outside core cosmeceutical scope.', 
    TRUE
),
(
    28807, 
    'LOREAL EXCELLENCE (5.3) CREAM COLOR بني ذهبي فاتح', 
    'لوريال إكسيلانس كريم صبغة شعر لون بني ذهبي فاتح', 
    370.00, 370.00, 'Hair Dyes0', 'LOREAL',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Cosmetic permanent hair dye product outside core cosmeceutical scope.', 
    TRUE
),
(
    28791, 
    'LOREAL EXCELLENCE (6) CREME COLOR اشقر غامق', 
    'لوريال إكسيلانس كريم صبغة شعر لون أشقر غامق', 
    370.00, 370.00, 'Hair Dyes0', 'LOREAL',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Cosmetic permanent hair dye product outside core cosmeceutical scope.', 
    TRUE
),
(
    98134, 
    'LOREAL EXCELLENCE (6.7) COLOR بني شوكولاتة', 
    'لوريال إكسيلانس صبغة شعر لون بني شوكولاتة', 
    370.00, 370.00, 'Hair Dyes0', 'LOREAL',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Cosmetic permanent hair dye product outside core cosmeceutical scope.', 
    TRUE
),
(
    28792, 
    'LOREAL EXCELLENCE (7) COLOR اشقر', 
    'لوريال إكسيلانس صبغة شعر لون أشقر', 
    370.00, 370.00, 'Hair Dyes0', 'LOREAL',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Cosmetic permanent hair dye product outside core cosmeceutical scope.', 
    TRUE
),
(
    73583, 
    'LOREAL EXCELLENCE (7.1) CREAM COLOR اشقر رمادي', 
    'لوريال إكسيلانس كريم صبغة شعر لون أشقر رمادي', 
    370.00, 370.00, 'Hair Dyes0', 'LOREAL',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Cosmetic permanent hair dye product outside core cosmeceutical scope.', 
    TRUE
),
(
    97796, 
    'LOREAL EXCELLENCE (7.7) COLOR بني عسلي', 
    'لوريال إكسيلانس صبغة شعر لون بني عسلي', 
    370.00, 370.00, 'Hair Dyes0', 'LOREAL',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Cosmetic permanent hair dye product outside core cosmeceutical scope.', 
    TRUE
),
(
    90645, 
    'LOREAL EXCELLENCE (8) COLOR اشقر فاتح', 
    'لوريال إكسيلانس صبغة شعر لون أشقر فاتح', 
    370.00, 370.00, 'Hair Dyes0', 'LOREAL',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Cosmetic permanent hair dye product outside core cosmeceutical scope.', 
    TRUE
),
(
    28794, 
    'LOREAL EXCELLENCE (8.1) COLOR اشقر فاتح رمادي', 
    'لوريال إكسيلانس صبغة شعر لون أشقر فاتح رمادي', 
    370.00, 370.00, 'Hair Dyes0', 'LOREAL',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Cosmetic permanent hair dye product outside core cosmeceutical scope.', 
    TRUE
),
(
    90646, 
    'LOREAL EXCELLENCE (9.1) CREAM COLOR اشقر رمادي فاتح', 
    'لوريال إكسيلانس كريم صبغة شعر لون أشقر رمادي فاتح', 
    370.00, 370.00, 'Hair Dyes0', 'LOREAL',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Cosmetic permanent hair dye product outside core cosmeceutical scope.', 
    TRUE
),
(
    24248, 
    'LOREAL EXCELLENCE ASH (7.12) COLOR اشقر لؤلؤي رمادي', 
    'لوريال إكسيلانس آش صبغة شعر لون أشقر لؤلؤي رمادي', 
    370.00, 370.00, 'Hair Dyes0', 'LOREAL',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Cosmetic permanent hair dye product outside core cosmeceutical scope.', 
    TRUE
),
(
    140345, 
    'LOREAL COLLAGEN EXPERT MOIST CREAM 50ML كريم مرطب قل', 
    'لوريال كولاجين إكسبيرت كريم مرطب ومقاوم لعلامات الشيخوخة 50 مل', 
    365.00, 365.00, 'Cream Top', 'LOREAL',
    'Anti_Aging_Skin_Rejuvenation', 
    'anti_aging_day_cream', 
    'Anti-aging collagen moisturizer formulated to smooth fine lines and restore firmness.', 
    FALSE
),
(
    140344, 
    'LOREAL COLLAGEN EXPERT SERUM AGE 30ML سيروم تصحيح تق', 
    'لوريال كولاجين إكسبيرت سيروم مصحح ومكافح لتجاعيد التقدم بالسن 30 مل', 
    440.00, 440.00, 'Skin Care f', 'LOREAL',
    'Anti_Aging_Skin_Rejuvenation', 
    'anti_aging_serum', 
    'Corrective anti-aging facial serum targeted at boosting collagen and smoothing wrinkles.', 
    FALSE
),
(
    91963, 
    'LOREAL COND EXTRAORIDANRY NORMAL HAIR 360ML ELV', 
    'لوريال إلفيف إكسترا أوردينيري بلسم مغذي للشعر العادي 360 مل', 
    203.00, 203.00, 'Hair Condit', 'LOREAL',
    'Hair_Scalp_Care', 
    'hair_conditioner_balm', 
    'Nourishing daily hair conditioner for normal hair moisture and softness.', 
    FALSE
),
(
    133419, 
    'LOREAL COND (GLYCOLIC GLOSS ) 200ML بلسم الفم', 
    'لوريال جلايكوليك جلوس بلسم لمعان الشعر الفائق 200 مل', 
    138.00, 138.00, 'Hair Condit', 'LOREAL',
    'Hair_Scalp_Care', 
    'hair_conditioner_balm', 
    'Gloss-enhancing hair conditioner with glycolic acid to smooth and illuminate dull hair.', 
    FALSE
),
(
    133417, 
    'LOREAL COND (GLYCOLIC GLOSS ) 360ML بلسم مثبت الفم', 
    'لوريال جلايكوليك جلوس بلسم لمعان الشعر الفائق 360 مل', 
    223.00, 223.00, 'Hair Condit', 'LOREAL',
    'Hair_Scalp_Care', 
    'hair_conditioner_balm', 
    'Medium-size gloss conditioner for hair fiber shine and smoothness.', 
    FALSE
),
(
    123909, 
    'LOREAL COND (HYALURON PURE ) 200ML ELVIVE', 
    'لوريال إلفيف هيالورون بيور بلسم منظف ومنعش للشعر الدهني 200 مل', 
    138.00, 138.00, 'Hair Condit', 'LOREAL',
    'Hair_Scalp_Care', 
    'hair_conditioner_balm', 
    'Lightweight purifying hair conditioner formulated for oily hair and dry lengths.', 
    FALSE
),
(
    123904, 
    'LOREAL COND (HYALURON PURE ) 360ML ELVIVE', 
    'لوريال إلفيف هيالورون بيور بلسم منظف ومنعش للشعر الدهني 360 مل', 
    223.00, 223.00, 'Hair Condit', 'LOREAL',
    'Hair_Scalp_Care', 
    'hair_conditioner_balm', 
    'Medium-size lightweight purifying conditioner for oily hair roots.', 
    FALSE
),
(
    84979, 
    'LOREAL COND DREAM LONG 200ML ELVIVE #C#', 
    'لوريال إلفيف دريم لونج بلسم لشعر طويل ومتقصف 200 مل', 
    125.00, 125.00, 'Hair Condit', 'LOREAL',
    'Hair_Scalp_Care', 
    'hair_conditioner_balm', 
    'Detangling and restorative hair conditioner for long hair with split ends.', 
    FALSE
),
(
    84984, 
    'LOREAL COND DREAM LONG 360ML ELVIVE #C#', 
    'لوريال إلفيف دريم لونج بلسم لشعر طويل ومتقصف 360 مل', 
    200.00, 200.00, 'Hair Condit', 'LOREAL',
    'Hair_Scalp_Care', 
    'hair_conditioner_balm', 
    'Medium-size restorative conditioner for long hair protection.', 
    FALSE
),
(
    29371, 
    'LOREAL COND DREAMLONG STRAIGH 360ML ELVIVE', 
    'لوريال إلفيف دريم لونج سترايت بلسم لتنعيم الشعر الطويل 360 مل', 
    203.00, 203.00, 'Hair Condit', 'LOREAL',
    'Hair_Scalp_Care', 
    'hair_conditioner_balm', 
    'Smoothing conditioner formulated to tame frizz and straighten long hair.', 
    FALSE
),
(
    30721, 
    'LOREAL COND DREAMLONG STRAIGHT 200ML ELVIVE', 
    'لوريال إلفيف دريم لونج سترايت بلسم لتنعيم الشعر الطويل 200 مل', 
    128.00, 128.00, 'Hair Condit', 'LOREAL',
    'Hair_Scalp_Care', 
    'hair_conditioner_balm', 
    'Smoothing hair conditioner for long frizzy hair control.', 
    FALSE
),
(
    91964, 
    'LOREAL COND EXTRAORIDANRY NORMAL 200ML ELVIVE', 
    'لوريال إلفيف إكسترا أوردينيري بلسم مغذي للشعر العادي 200 مل', 
    128.00, 128.00, 'Hair Shamp', 'LOREAL',
    'Hair_Scalp_Care', 
    'hair_conditioner_balm', 
    'Nourishing oil conditioner for normal hair softness.', 
    FALSE
),
(
    46452, 
    'LOREAL COND FALL RESIST 200ML ELVIVE', 
    'لوريال إلفيف فول ريزيست بلسم مقاوم لتساقط الشعر 200 مل', 
    128.00, 128.00, 'Hair Condit', 'LOREAL',
    'Hair_Scalp_Care', 
    'hair_conditioner_balm', 
    'Reinforcing anti-hair fall conditioner for weak hair strength.', 
    FALSE
),
(
    46459, 
    'LOREAL COND FALL RESIST 360ML ELVIVE', 
    'لوريال إلفيف فول ريزيست بلسم مقاوم لتساقط الشعر 360 مل', 
    203.00, 203.00, 'Hair Condit', 'LOREAL',
    'Hair_Scalp_Care', 
    'hair_conditioner_balm', 
    'Medium-size reinforcing anti-hair fall conditioner.', 
    FALSE
),
(
    76984, 
    'LOREAL COND HYALURON MOISTURE 200ML ELVIVE', 
    'لوريال إلفيف هيالورون مويستشر بلسم مرطب للشعر الجاف 200 مل', 
    138.00, 138.00, 'Hair Condit', 'LOREAL',
    'Hair_Scalp_Care', 
    'hair_conditioner_balm', 
    'Hyaluronic acid-infused moisturizing conditioner for dry hair detangling.', 
    FALSE
),
(
    76985, 
    'LOREAL COND HYALURON MOISTURE360ML ELVIVE', 
    'لوريال إلفيف هيالورون مويستشر بلسم مرطب للشعر الجاف 360 مل', 
    223.00, 223.00, 'Hair Condit', 'LOREAL',
    'Hair_Scalp_Care', 
    'hair_conditioner_balm', 
    'Medium-size moisture-locking hair conditioner for dry hair.', 
    FALSE
),
(
    89617, 
    'LOREAL COND TOTAL REPAIR 360ML ELVIVE', 
    'لوريال إلفيف توتال ريبير بلسم معالج للشعر التالف 360 مل', 
    203.00, 203.00, 'Hair Shamp', 'LOREAL',
    'Hair_Scalp_Care', 
    'hair_conditioner_balm', 
    'Restorative hair conditioner formulated for damaged and split hair.', 
    FALSE
),
(
    87112, 
    'LOREAL COND TOTAL REPAIR DAMAGED 200ML ELVIVE', 
    'لوريال إلفيف توتال ريبير بلسم معالج للشعر التالف 200 مل', 
    128.00, 128.00, 'Hair Condit', 'LOREAL',
    'Hair_Scalp_Care', 
    'hair_conditioner_balm', 
    'Damage-repairing hair conditioner for hair restoration.', 
    FALSE
),
INSERT INTO cosmeceutical_product_classification_full (
    code, name_en, name_ar, price_1, price_2, category, supplier,
    domain, subcategory, reason, review_required
) VALUES
(
    111352, 
    'LOREAL GLYCOL BRIGHT(SPF17)DAY CREAM 50ML كود جدي', 
    'لوريال جلايكوليك برايت كريم نهاري مضاد للبقع واقي شمس SPF17 بحجم 50 مل', 
    565.00, 565.00, 'Skin Care f', 'LOREAL',
    'Pigmentation_Skin_Tone', 
    'pigmentation_day_cream', 
    'Brightening day cream with glycolic acid and SPF17 targeting dark spots and skin tone.', 
    FALSE
),
(
    85234, 
    'LOREAL HAIR CREAM DREAM LONG 200ML ELVIVE #C#', 
    'لوريال إلفيف دريم لونج كريم مغذي ومعالج لشعر طويل ومتقصف 200 مل', 
    235.00, 235.00, 'Hair Cream', 'LOREAL',
    'Hair_Scalp_Care', 
    'hair_conditioner_balm', 
    'Leave-in nourishing hair cream formulated to restore and protect long, damaged hair.', 
    FALSE
),
(
    79989, 
    'LOREAL CASTING (200) CREAM COLOR اسود غامق عميق', 
    'لوريال كاستينج كريم صبغة شعر لون أسود غامق عميق', 
    470.00, 470.00, 'Hair Dyes0', 'LOREAL',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Cosmetic permanent hair dye product outside core cosmeceutical scope.', 
    TRUE
),
(
    91246, 
    'LOREAL CASTING (300) CREAM COLOR بني غامق داكن جدا', 
    'لوريال كاستينج كريم صبغة شعر لون بني غامق داكن جداً', 
    495.00, 495.00, 'Hair Dyes0', 'LOREAL',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Cosmetic permanent hair dye product outside core cosmeceutical scope.', 
    TRUE
),
(
    78521, 
    'LOREAL CASTING (316) CREAM COLOR عسبي', 
    'لوريال كاستينج كريم صبغة شعر لون عسبي', 
    495.00, 495.00, 'Hair Dyes0', 'LOREAL',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Cosmetic permanent hair dye product outside core cosmeceutical scope.', 
    TRUE
),
(
    134245, 
    'LOREAL CASTING (360) CREAM COLOR #C# اسود كريزي', 
    'لوريال كاستينج كريم صبغة شعر لون أسود جريء', 
    470.00, 470.00, 'Hair Dyes0', 'LOREAL',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Cosmetic permanent hair dye product outside core cosmeceutical scope.', 
    TRUE
),
(
    78545, 
    'LOREAL CASTING (360) CREAM COLOR #C# احمر عميق', 
    'لوريال كاستينج كريم صبغة شعر لون أحمر عميق', 
    400.00, 400.00, 'Hair Dyes0', 'LOREAL',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Cosmetic permanent hair dye product outside core cosmeceutical scope.', 
    TRUE
),
(
    101035, 
    'LOREAL CASTING (400) CREAM COLOR بني', 
    'لوريال كاستينج كريم صبغة شعر لون بني', 
    495.00, 495.00, 'Hair Dyes0', 'LOREAL',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Cosmetic permanent hair dye product outside core cosmeceutical scope.', 
    TRUE
),
(
    78522, 
    'LOREAL CASTING (500) CREAM COLOR بني فاتح', 
    'لوريال كاستينج كريم صبغة شعر لون بني فاتح', 
    495.00, 495.00, 'Hair Dyes0', 'LOREAL',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Cosmetic permanent hair dye product outside core cosmeceutical scope.', 
    TRUE
),
(
    135426, 
    'LOREAL CASTING (513) CREAM COLOR لون جديد شوكولاتة', 
    'لوريال كاستينج كريم صبغة شعر لون شوكولاتة', 
    459.00, 459.00, 'Hair Dyes0', 'LOREAL',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Cosmetic permanent hair dye product outside core cosmeceutical scope.', 
    TRUE
),
(
    87149, 
    'LOREAL CASTING (513) CREAM COLOR بني فاتح 135426جديد', 
    'لوريال كاستينج كريم صبغة شعر لون بني فاتح شوكولاتة', 
    400.00, 400.00, 'Hair Dyes0', 'LOREAL',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Cosmetic permanent hair dye product outside core cosmeceutical scope.', 
    TRUE
),
(
    78525, 
    'LOREAL CASTING (535) CREAM COLOR بني ذهبي فاتح ارجو', 
    'لوريال كاستينج كريم صبغة شعر لون بني ذهبي فاتح', 
    495.00, 495.00, 'Hair Dyes0', 'LOREAL',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Cosmetic permanent hair dye product outside core cosmeceutical scope.', 
    TRUE
),
(
    133076, 
    'LOREAL CASTING (535) CREME COLOR شوكولاتة', 
    'لوريال كاستينج كريم صبغة شعر لون شوكولاتة دافئة', 
    470.00, 470.00, 'Hair Dyes0', 'LOREAL',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Cosmetic permanent hair dye product outside core cosmeceutical scope.', 
    TRUE
),
(
    74926, 
    'LOREAL CASTING (550) CREAM COLOR #C# بني فاتح ارجواني', 
    'لوريال كاستينج كريم صبغة شعر لون بني فاتح أرجواني', 
    495.00, 495.00, 'Hair Dyes0', 'LOREAL',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Cosmetic permanent hair dye product outside core cosmeceutical scope.', 
    TRUE
),
(
    78544, 
    'LOREAL CASTING (600) CREAM COLOR اشقر غامق', 
    'لوريال كاستينج كريم صبغة شعر لون أشقر غامق', 
    400.00, 400.00, 'Hair Dyes0', 'LOREAL',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Cosmetic permanent hair dye product outside core cosmeceutical scope.', 
    TRUE
),
(
    78524, 
    'LOREAL CASTING (630) CREAM COLOR #C# اشقر فاتح ذهبي', 
    'لوريال كاستينج كريم صبغة شعر لون أشقر فاتح ذهبي', 
    470.00, 470.00, 'Hair Dyes0', 'LOREAL',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Cosmetic permanent hair dye product outside core cosmeceutical scope.', 
    TRUE
),
(
    81077, 
    'LOREAL CASTING (700) CREAM COLOR اشقر', 
    'لوريال كاستينج كريم صبغة شعر لون أشقر', 
    495.00, 495.00, 'Hair Dyes0', 'LOREAL',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Cosmetic permanent hair dye product outside core cosmeceutical scope.', 
    TRUE
),
(
    78529, 
    'LOREAL CASTING (810) CREAM COLOR اشقر رمادي', 
    'لوريال كاستينج كريم صبغة شعر لون أشقر رمادي', 
    495.00, 495.00, 'Hair Dyes0', 'LOREAL',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Cosmetic permanent hair dye product outside core cosmeceutical scope.', 
    TRUE
),
(
    144687, 
    'LUNA SPRAY SUN SPF45 INVISIBL PROTECT 150ML', 
    'لونا بخاخ واقي شمس غير مرئي SPF45 بحجم 150 مل', 
    350.00, 350.00, 'dosage', 'ودا مستحضرات التجميل',
    'Sun_Protection', 
    'sunscreen_spray_mist', 
    'Invisible protective spray sunscreen with SPF45 for broad-spectrum defense.', 
    FALSE
),
(
    108054, 
    'LUNA SPRAY SUN TAN OIL SPF15 ALL SKIN 200ML', 
    'لونا بخاخ زيت للتسمير واقي شمس SPF15 لجميع أنواع البشرة 200 مل', 
    240.00, 240.00, 'Sun produ', 'ودا مستحضرات التجميل',
    'Sun_Protection', 
    'body_sunscreen_water', 
    'Tanning oil spray with SPF15 designed to protect while enhancing natural tanning.', 
    FALSE
),
(
    76135, 
    'LUNA STREPS PASTILLES CHERRY 100PCS كرز', 
    'لونا استريبس أقراص استحلاب للحلق بنكهة الكرز 100 قرص', 
    1.50, 150.00, 'Candy', 'ودا مستحضرات التجميل',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Throat lozenge product outside core cosmeceutical skincare scope.', 
    TRUE
),
(
    77065, 
    'LUNA STREPS PASTILLES LEMON&HONEY 100PCS ليمون وعسل', 
    'لونا استريبس أقراص استحلاب للحلق بنكهة الليمون والعسل 100 قرص', 
    1.50, 150.00, 'Candy', 'ودا مستحضرات التجميل',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Throat lozenge product outside core cosmeceutical skincare scope.', 
    TRUE
),
(
    76134, 
    'LUNA STREPS PASTILLES MINT 100PCS نعناع', 
    'لونا استريبس أقراص استحلاب للحلق بنكهة النعناع 100 قرص', 
    1.50, 150.00, 'Candy', 'ودا مستحضرات التجميل',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Throat lozenge product outside core cosmeceutical skincare scope.', 
    TRUE
),
(
    143255, 
    'LUNA STREPS PASTILLES MIXED BOX 300PCS مكس', 
    'لونا استريبس مجموعة أقراص استحلاب متنوعة للحلق 300 قرص', 
    1.25, 375.00, 'Candy', 'ودا مستحضرات التجميل',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Throat lozenge box outside core cosmeceutical skincare scope.', 
    TRUE
),
(
    76133, 
    'LUNA STREPS PASTILLES ORANGE 100PCS برتقال', 
    'لونا استريبس أقراص استحلاب للحلق بنكهة البرتقال 100 قرص', 
    1.50, 150.00, 'Candy', 'ودا مستحضرات التجميل',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Throat lozenge product outside core cosmeceutical skincare scope.', 
    TRUE
),
(
    87439, 
    'LUNA STREPS PASTILLES WITH STRAWBERRY 100PCS فراوله', 
    'لونا استريبس أقراص استحلاب للحلق بنكهة الفراولة 100 قرص', 
    1.50, 150.00, 'Candy', 'ودا مستحضرات التجميل',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Throat lozenge product outside core cosmeceutical skincare scope.', 
    TRUE
),
(
    144688, 
    'LUNA SUN CARE SPF50 ANTI-BROWN SPOTS 50ML', 
    'لونا صن كير كريم واقي شمس ومضاد للبقع البنية SPF50 بحجم 50 مل', 
    220.00, 220.00, 'dosage', 'ودا مستحضرات التجميل',
    'Sun_Protection', 
    'pigmentation_sunscreen_fluid', 
    'Targeted facial sunscreen with SPF50 formulated to prevent brown spots and hyperpigmentation.', 
    FALSE
),
(
    144689, 
    'LUNA SUN CARE SPF50 TINTED SUNSCREEN 50ML', 
    'لونا صن كير كريم واقي شمس ملون SPF50 بحجم 50 مل', 
    220.00, 220.00, 'dosage', 'ودا مستحضرات التجميل',
    'Sun_Protection', 
    'tinted_facial_sunscreen', 
    'Tinted facial sunscreen providing high SPF50 protection and complexion coverage.', 
    FALSE
),
(
    124357, 
    'LUNA SUN SCREEN KIDS SPF50 (20%) 130ML', 
    'لونا واقي شمس للأطفال SPF50 بحجم 130 مل', 
    220.00, 220.00, 'Cream Top', 'ودا مستحضرات التجميل',
    'Sun_Protection', 
    'kids_sunscreen_spray', 
    'High-protection sunscreen lotion specially formulated for children sensitive skin.', 
    FALSE
),
(
    124356, 
    'LUNA SUN SCREEN SPORT SPF50 (20%) 130ML', 
    'لونا واقي شمس رياضي SPF50 بحجم 130 مل', 
    220.00, 220.00, 'Cream Top', 'ودا مستحضرات التجميل',
    'Sun_Protection', 
    'body_sunscreen_lotion', 
    'Water-resistant sport sunscreen lotion with high SPF50 defense for outdoor activities.', 
    FALSE
),
(
    27894, 
    'LUNA SUN SCREEN SPORT SPF50 FOR ALL SKIN 130ML', 
    'لونا واقي شمس رياضي لجميع أنواع البشرة SPF50 بحجم 130 مل', 
    275.00, 275.00, 'Lotion', 'ودا مستحضرات التجميل',
    'Sun_Protection', 
    'body_sunscreen_lotion', 
    'Broad-spectrum sport sunscreen lotion suitable for all skin types.', 
    FALSE
),
(
    126717, 
    'LUNA شنطة مجموعة ترطيب لونا 4 قطع % 10 خصم', 
    'لونا شنطة مجموعة ترطيب للعناية بالبشرة 4 قطع', 
    216.00, 216.00, 'Cream Top', 'ودا مستحضرات التجميل',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Multi-product promotional gift kit containing items across skincare categories.', 
    TRUE
),
(
    132632, 
    'LUNA شنطة مجموعة ترطيب لونا 3 قطع', 
    'لونا شنطة مجموعة ترطيب للعناية بالبشرة 3 قطع', 
    183.00, 183.00, 'Cream Top', 'ودا مستحضرات التجميل',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Multi-product promotional kit containing items across skincare categories.', 
    TRUE
),
(
    145493, 
    'LUNA(1+1)SHOWER GEL FLOWERS+COCONUT 500ML %20 خصم', 
    'لونا مجموعة شاور جل غسول بالزهور + جوز الهند 500 مل', 
    155.00, 155.00, 'Gel Topica', 'ودا مستحضرات التجميل',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Multi-product promotional bundle set containing body wash variants.', 
    TRUE
),
(
    145494, 
    'LUNA(1+1)SHOWER GEL TWIST+COCONUT 500ML %20 خصم', 
    'لونا مجموعة شاور جل غسول تويست بيري + جوز الهند 500 مل', 
    155.00, 155.00, 'Gel Topica', 'ودا مستحضرات التجميل',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Multi-product promotional bundle set containing body wash variants.', 
    TRUE
),
(
    132622, 
    'LUNAPRIST 24 MCG 20 CAP', 
    'لونا بريست أقراص مكمل غذائي 20 كبسولة', 
    40.00, 80.00, 'ORAL', 'ميدزين للصناعات الدولية',
    'Specialized_Care', 
    'hair_nail_dietary_supplement', 
    'Oral dietary supplement capsules formulated to support general health and vitality.', 
    FALSE
),
(
    138639, 
    'LEAVES (001)(FAIR LIGHT)CONCEALER 12ML SPF40', 
    'ليفز خافي عيوب كونسيلر درجة فاتحة واقي شمس SPF40 بحجم 12 مل', 
    249.00, 249.00, 'COSMO-MI', 'سكن تون',
    'Specialized_Care', 
    'tinted_complexion_concealer', 
    'Tinted liquid concealer with SPF40 providing blemish and dark circle coverage.', 
    FALSE
),
(
    138638, 
    'LEAVES (001)(FAIR LIGHT)FOUNDATION 25ML SPF40', 
    'ليفز كريم أساس فاونديشن درجة فاتحة واقي شمس SPF40 بحجم 25 مل', 
    300.00, 300.00, 'COSMO-MI', 'سكن تون',
    'Specialized_Care', 
    'tinted_complexion_foundation', 
    'Tinted liquid foundation with SPF40 offering skin tone evening and coverage.', 
    FALSE
),
(
    136206, 
    'LEAVES (001)LIGHT CONCEALER SPF40 12ML , كود بديل', 
    'ليفز خافي عيوب كونسيلر درجة خفيفة واقي شمس SPF40 بحجم 12 مل', 
    249.00, 249.00, 'COSMO-MI', 'سكن تون',
    'Specialized_Care', 
    'tinted_complexion_concealer', 
    'Light shade concealing makeup cream with SPF40 UV defense.', 
    FALSE
),
(
    136204, 
    'LEAVES (001)LIGHT FOUNDATION SPF40 25ML كود بديل', 
    'ليفز كريم أساس فاونديشن درجة خفيفة واقي شمس SPF40 بحجم 25 مل', 
    270.00, 270.00, 'COSMO-MI', 'سكن تون',
    'Specialized_Care', 
    'tinted_complexion_foundation', 
    'Light shade liquid foundation with protective SPF40 formula.', 
    FALSE
),
(
    136205, 
    'LEAVES (002)MEDI CONCEALER SPF40 12ML', 
    'ليفز خافي عيوب كونسيلر درجة متوسطة واقي شمس SPF40 بحجم 12 مل', 
    239.00, 239.00, 'COSMO-MI', 'سكن تون',
    'Specialized_Care', 
    'tinted_complexion_concealer', 
    'Medium shade concealer with SPF40 for complexion balancing.', 
    FALSE
),
(
    136203, 
    'LEAVES (002)MEDI FOUNDATION SPF40 25ML', 
    'ليفز كريم أساس فاونديشن درجة متوسطة واقي شمس SPF40 بحجم 25 مل', 
    270.00, 270.00, 'COSMO-MI', 'سكن تون',
    'Specialized_Care', 
    'tinted_complexion_foundation', 
    'Medium shade liquid foundation with SPF40 sun protection.', 
    FALSE
),
(
    136207, 
    'LEAVES AFTER SUN CREAM ALL SKIN 100ML', 
    'ليفز كريم مهدئ ومرطب بعد التعرض للشمس لجميع أنواع البشرة 100 مل', 
    249.00, 249.00, 'COSMO-MI', 'سكن تون',
    'Specialized_Care', 
    'after_sun_soothing_lotion', 
    'Soothing and hydrating cream designed to comfort skin after sun exposure.', 
    FALSE
),
(
    141346, 
    'LEAVES BODY MILK COTTON TOUCH 300MLبامب كوتون تاتش', 
    'ليفز حليب مرطب للجسم برائحة لمسة القطن بضخة 300 مل', 
    289.00, 289.00, 'COSMO-MI', 'سكن تون',
    'Specialized_Body_Care', 
    'body_moisturizing_lotion', 
    'Fragrant body moisturizing milk formulated to soften and hydrate body skin.', 
    FALSE
),
(
    141344, 
    'LEAVES BODY MILK HYDRAT 300MLبامب بدون رائحة', 
    'ليفز حليب مرطب للجسم بدون رائحة بضخة 300 مل', 
    279.00, 279.00, 'COSMO-MI', 'سكن تون',
    'Specialized_Body_Care', 
    'body_moisturizing_lotion', 
    'Fragrance-free hydrating body milk for sensitive body skin moisturization.', 
    FALSE
),
(
    116810, 
    'LEAVES CREAM NOURISHING HAIR LOSS 200ML', 
    'ليفز كريم مغذي ومعالج لتساقط الشعر 200 مل', 
    394.00, 394.00, 'COSMO-MI', 'سكن تون',
    'Hair_Scalp_Care', 
    'hair_conditioner_balm', 
    'Nourishing and anti-hair loss leave-in cream to strengthen hair fiber.', 
    FALSE
),
(
    141349, 
    'LEAVES HAIR SERUM HAIR LOSS 80ML', 
    'ليفز سيروم معالج ومضاد لتساقط الشعر 80 مل', 
    414.00, 414.00, 'COSMO-MI', 'سكن تون',
    'Hair_Scalp_Care', 
    'scalp_treatment_leave_in', 
    'Targeted scalp treatment serum formulated to combat hair loss and stimulate roots.', 
    FALSE
),
(
    139955, 
    'LEAVES INSTANT HYDRAT CREAMY GEL 60ML141347 كود اخر', 
    'ليفز جل كريمي مرطب فوري للبشرة 60 مل', 
    159.00, 159.00, 'COSMO-MI', 'سكن تون',
    'Skin_Moisturization_Barrier', 
    'lightweight_barrier_moisturizer', 
    'Instant hydrating creamy gel providing lightweight moisture and barrier support.', 
    FALSE
),
(
    141347, 
    'LEAVES INSTANT HYDRAT CREAMY GEL 75MLبشره عاديه وجافه', 
    'ليفز جل كريمي مرطب فوري للبشرة العادية والجافة 75 مل', 
    185.00, 185.00, 'COSMO-MI', 'سكن تون',
    'Skin_Moisturization_Barrier', 
    'lightweight_barrier_moisturizer', 
    'Hydrating creamy gel for normal to dry skin barrier hydration.', 
    FALSE
),
(
    116808, 
    'LEAVES LEAVE-IN COND INTENSIVE HAIR LOSS 200ML', 
    'ليفز بلسم يترك على الشعر مكثف ومعالج لتساقط الشعر 200 مل', 
    309.00, 309.00, 'COSMO-MI', 'سكن تون',
    'Hair_Scalp_Care', 
    'scalp_treatment_leave_in', 
    'Intensive leave-in conditioner formulated to target hair thinning and loss.', 
    FALSE
),
(
    116811, 
    'LEAVES MASCARA LASH TREATMENT 10ML', 
    'ليفز ماسكارا معالجة ومقوية للرموش 10 مل', 
    510.00, 510.00, 'COSMO-MI', 'سكن تون',
    'Specialized_Care', 
    'nail_strengthening_cream', 
    'Treatment mascara formulated to nourish, condition, and strengthen eyelashes.', 
    FALSE
),
(
    116809, 
    'LEAVES MASK REPAIRING ANTI HAIR LOSS 200ML', 
    'ليفز قناع مرمم ومعالج لتساقط الشعر 200 مل', 
    324.00, 324.00, 'COSMO-MI', 'سكن تون',
    'Hair_Scalp_Care', 
    'repairing_hair_mask', 
    'Restorative anti-hair loss hair mask treatment for damaged, fragile hair.', 
    FALSE
),
(
    126512, 
    'LEAVES NAIL & CUTICLE SERUM 5ML', 
    'ليفز سيروم مرطب ومغذي للأظافر والجلد حولها 5 مل', 
    270.00, 270.00, 'COSMO-MI', 'سكن تون',
    'Specialized_Care', 
    'nail_strengthening_cream', 
    'Nourishing nail and cuticle serum designed to strengthen nails and soften cuticles.', 
    FALSE
),
(
    143278, 
    'LEAVES NIACINAMID SERUM 30ML', 
    'ليفز نياسيناميد سيروم منقي ومفتح للبشرة 30 مل', 
    364.00, 364.00, 'COSMO-MI', 'سكن تون',
    'Pigmentation_Skin_Tone', 
    'anti_pigmentation_serum', 
    'Clarifying and brightening facial serum formulated with Niacinamide to target blemishes and uneven tone.', 
    FALSE
),
(
    143276, 
    'LEAVES RETINOL SERUM 30ML', 
    'ليفز ريتينول سيروم مجدد ومقاوم لعلامات الشيخوخة 30 مل', 
    414.00, 414.00, 'COSMO-MI', 'سكن تون',
    'Anti_Aging_Skin_Rejuvenation', 
    'retinol_anti_aging_serum', 
    'Anti-aging serum formulated with Retinol to resurface skin texture and smooth wrinkles.', 
    FALSE
),
(
    136218, 
    'LEAVES ROLL-ON (1+1)(BULGARIAN ROSE+BABY POWDER) 50ML عرض', 
    'ليفز مزيل عرق رول أون مجموعة ورد بلغاري + بودرة أطفال 50 مل', 
    260.00, 260.00, 'COSMO-MI', 'سكن تون',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Multi-product promotional bundle set containing deodorant roll-on variants.', 
    TRUE
),
(
    136220, 
    'LEAVES ROLL-ON (1+1)(ORIGINAL+BABY POWDER) 50MLعرض', 
    'ليفز مزيل عرق رول أون مجموعة أصلي + بودرة أطفال 50 مل', 
    270.00, 270.00, 'COSMO-MI', 'سكن تون',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Multi-product promotional bundle set containing deodorant roll-on variants.', 
    TRUE
),
(
    136219, 
    'LEAVES ROLL-ON (1+1)(ORIGINAL+BULGARIAN ROSE) 50Mعرض', 
    'ليفز مزيل عرق رول أون مجموعة أصلي + ورد بلغاري 50 مل', 
    260.00, 260.00, 'COSMO-MI', 'سكن تون',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Multi-product promotional bundle set containing deodorant roll-on variants.', 
    TRUE
),
(
    136216, 
    'LEAVES ROLL-ON (1+1)(VELVET VAN+STRAW) 50ML عرض', 
    'ليفز مزيل عرق رول أون مجموعة فانيليا مخملية + فراولة 50 مل', 
    260.00, 260.00, 'COSMO-MI', 'سكن تون',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Multi-product promotional bundle set containing deodorant roll-on variants.', 
    TRUE
),
(
    136217, 
    'LEAVES ROLL-ON (1+1)(VELVET VAN+WARM CHOCO) 50ML عرض', 
    'ليفز مزيل عرق رول أون مجموعة فانيليا مخملية + شوكولاتة دافئة 50 مل', 
    260.00, 260.00, 'COSMO-MI', 'سكن تون',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Multi-product promotional bundle set containing deodorant roll-on variants.', 
    TRUE
),
(
    136214, 
    'LEAVES ROLL-ON (1+1)(WARM CHOCO+STRAW) 50ML عرض', 
    'ليفز مزيل عرق رول أون مجموعة شوكولاتة دافئة + فراولة 50 مل', 
    260.00, 260.00, 'COSMO-MI', 'سكن تون',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Multi-product promotional bundle set containing deodorant roll-on variants.', 
    TRUE
),
(
    143279, 
    'LEAVES SERUM VITAMIN C 30ML', 
    'ليفز سيروم فيتامين سي المضيء والمفتح للبشرة 30 مل', 
    364.00, 364.00, 'COSMO-MI', 'سكن تون',
    'Anti_Aging_Skin_Rejuvenation', 
    'antioxidant_radiance_serum', 
    'Vitamin C illuminating facial serum for antioxidant defense and skin radiance.', 
    FALSE
),
(
    116807, 
    'LEAVES SHAM&COND INTENSIV HAIR LOSS 200ML', 
    'ليفز شامبو وبلسم مكثف ومعالج لتساقط الشعر 200 مل', 
    324.00, 324.00, 'COSMO-MI', 'سكن تون',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Multi-product promotional set combining shampoo and conditioner.', 
    TRUE
),
(
    113781, 
    'LEAVES SPRAY ANTI HAIR LOSS 100ML', 
    'ليفز بخاخ معالج ومضاد لتساقط الشعر 100 مل', 
    660.00, 660.00, 'COSMO-MI', 'سكن تون',
    'Hair_Scalp_Care', 
    'scalp_treatment_leave_in', 
    'Anti-hair loss scalp spray treatment designed to strengthen hair roots.', 
    FALSE
),
(
    136208, 
    'LEAVES SUN SPF50 HYDRATING LOTION 100ML', 
    'ليفز لوشن مرطب واقي شمس SPF50 بحجم 100 مل', 
    520.00, 520.00, 'COSMO-MI', 'سكن تون',
    'Sun_Protection', 
    'body_sunscreen_lotion', 
    'Hydrating protective sunscreen lotion with SPF50 for body sun defense.', 
    FALSE
),
(
    136212, 
    'LEAVES SUN SPF50 TINTED FLUID(MED) 50ML', 
    'ليفز فلويد ملون واقي شمس درجة متوسطة SPF50 بحجم 50 مل', 
    410.00, 410.00, 'COSMO-MI', 'سكن تون',
    'Sun_Protection', 
    'tinted_facial_sunscreen', 
    'Medium shade tinted facial sunscreen fluid offering high SPF50 protection.', 
    FALSE
),
(
    136213, 
    'LEAVES SUN SPF50 ULTRA LIGHT FLUID 50ML', 
    'ليفز فلويد خفيف جداً واقي شمس SPF50 بحجم 50 مل', 
    420.00, 420.00, 'COSMO-MI', 'سكن تون',
    'Sun_Protection', 
    'facial_sunscreen_fluid', 
    'Ultra-light fluid facial sunscreen providing high broad-spectrum SPF50 defense.', 
    FALSE
),
(
    144677, 
    'LEAVES SUN SPF50+ HYDRO GEL 50ML', 
    'ليفز جل مائي واقي شمس SPF50+ بحجم 50 مل', 
    390.00, 390.00, 'COSMO-MI', 'سكن تون',
    'Sun_Protection', 
    'facial_sunscreen_fluid', 
    'Aqueous texture hydro-gel facial sunscreen with very high SPF50+ protection.', 
    FALSE
),
(
    136201, 
    'LEAVES WHITE MIC WATER NORM&OILY 200ML', 
    'ليفز وايت ماء ميسيلار منظف للبشرة العادية والدهنية 200 مل', 
    229.00, 229.00, 'COSMO-MI', 'سكن تون',
    'Skin_Cleansing', 
    'micellar_cleansing_water', 
    'Purifying micellar cleansing water formulated for normal to oily skin.', 
    FALSE
),
(
    136202, 
    'LEAVES WHITE MICELLAR WATER DRY&SENS 200ML', 
    'ليفز وايت ماء ميسيلار منظف للبشرة الجافة والحساسة 200 مل', 
    229.00, 229.00, 'COSMO-MI', 'سكن تون',
    'Skin_Cleansing', 
    'micellar_cleansing_water', 
    'Gentle micellar cleansing water formulated for dry and sensitive skin.', 
    FALSE
),
(
    136881, 
    'LUNA SHOWER GEL TWIST BERRIES 500ML', 
    'لونا شاور جل غسول للجسم بتويست بيري 500 مل', 
    95.00, 95.00, 'Gel Topica', 'ودا مستحضرات التجميل',
    'Skin_Cleansing', 
    'lipid_replenishing_cleanser', 
    'Fragrant body shower gel formulated for daily body cleansing.', 
    FALSE
),
(
    139846, 
    'LUNA SHOWER GEL TWIST BERRY2(LIT)%20خصم', 
    'لونا شاور جل غسول للجسم تويست بيري عبوة لترين', 
    136.00, 136.00, 'Gel Topica', 'ودا مستحضرات التجميل',
    'Skin_Cleansing', 
    'lipid_replenishing_cleanser', 
    'Large family-size body shower gel in twist berry fragrance.', 
    FALSE
),
(
    143266, 
    'LUNA SHOWER GEL OLIVE 2(LIT)%20خصم', 
    'لونا شاور جل غسول للجسم بالزيتون عبوة لترين', 
    136.00, 136.00, 'Gel Topica', 'ودا مستحضرات التجميل',
    'Skin_Cleansing', 
    'lipid_replenishing_cleanser', 
    'Large family-size body shower gel formulated with olive oil.', 
    FALSE
),
(
    143267, 
    'LUNA SHOWER GEL باغبTWIST BERRY2(LIT)%20خصم', 
    'لونا شاور جل غسول للجسم تويست بيري عبوة لترين', 
    136.00, 136.00, 'Gel Topica', 'ودا مستحضرات التجميل',
    'Skin_Cleansing', 
    'lipid_replenishing_cleanser', 
    'Large family-size body shower gel in twist berry variant.', 
    FALSE
),
(
    117624, 
    'LUNA SOAP ANTI GLYCERIN&OLIVE 100GM', 
    'لونا صابونة جلسرين وزيت الزيتون المرطبة 100 جرام', 
    55.00, 55.00, 'Soap0', 'ودا مستحضرات التجميل',
    'Skin_Cleansing', 
    'lipid_replenishing_cleanser', 
    'Moisturizing glycerin and olive oil cleansing bar soap.', 
    FALSE
),
(
    117625, 
    'LUNA SOAP GLYCERIN&COTTON FLOWERS 100GM', 
    'لونا صابونة جلسرين بزهور القطن المنعشة 100 جرام', 
    55.00, 55.00, 'Soap0', 'ودا مستحضرات التجميل',
    'Skin_Cleansing', 
    'lipid_replenishing_cleanser', 
    'Glycerin cleansing bar soap infused with cotton flower scent.', 
    FALSE
),
(
    117626, 
    'LUNA SOAP GLYCERIN&ROSE& MILK 100GM', 
    'لونا صابونة جلسرين بالورد والحليب 100 جرام', 
    55.00, 55.00, 'Soap0', 'ودا مستحضرات التجميل',
    'Skin_Cleansing', 
    'lipid_replenishing_cleanser', 
    'Glycerin cleansing bar soap enriched with rose and milk.', 
    FALSE
),
(
    117628, 
    'LUNA SOAP GLYCERIN&SHEA BUTTER 100GM', 
    'لونا صابونة جلسرين بزبدة الشيا المغذية 100 جرام', 
    55.00, 55.00, 'Soap0', 'ودا مستحضرات التجميل',
    'Skin_Cleansing', 
    'lipid_replenishing_cleanser', 
    'Nourishing glycerin cleansing bar soap enriched with shea butter.', 
    FALSE
),
(
    117627, 
    'LUNA SOAP GLYCERIN&TWIST BERRIES 100GM', 
    'لونا صابونة جلسرين بتويست بيري 100 جرام', 
    55.00, 55.00, 'Soap0', 'ودا مستحضرات التجميل',
    'Skin_Cleansing', 
    'lipid_replenishing_cleanser', 
    'Glycerin cleansing bar soap scented with twist berries.', 
    FALSE
),
(
    146193, 
    'LUNA SOAP SULPHUR 65G ص كبريت', 
    'لونا صابونة الكبريت الطبية المعالجة 65 جرام', 
    35.00, 35.00, 'Soap0', 'ودا مستحضرات التجميل',
    'Acne_Oil_Control', 
    'acne_cleansing_gel', 
    'Medical sulphur cleansing bar soap formulated for acne and oily skin care.', 
    FALSE
),
(
    138750, 
    'LUNA SPONGE NAIL POLISH REMOV 30ML اسفنجة مزيل طلاء', 
    'لونا اسفنجة مزيل طلاء الأظافر السحرية 30 مل', 
    100.00, 100.00, 'Nail Care P', 'ودا مستحضرات التجميل',
    'Specialized_Care', 
    'nail_strengthening_cream', 
    'Convenient sponge nail polish remover for quick cleaning.', 
    FALSE
),
(
    12832, 
    'LUNA MEDICINAL SOAP SALICYLIC 55G ص سنسيليك #C#', 
    'لونا صابونة حمض الساليسيليك الطبية المقشرة 55 جرام', 
    28.00, 28.00, 'Soap0', 'ودا مستحضرات التجميل',
    'Acne_Oil_Control', 
    'acne_cleansing_gel', 
    'Medical salicylic acid exfoliating cleansing bar soap for blemish-prone skin.', 
    FALSE
),
(
    48964, 
    'LUNA MEDICINAL SOAP SULPHUR 55G كبريت', 
    'لونا صابونة الكبريت الطبية 55 جرام', 
    28.00, 28.00, 'Soap0', 'ودا مستحضرات التجميل',
    'Acne_Oil_Control', 
    'acne_cleansing_gel', 
    'Medical sulphur cleansing bar soap for managing oily, blemish-prone skin.', 
    FALSE
),
(
    133239, 
    'LUNA MEN LIPBALM PANTH&VITAMIN E 3.5Gمرطب شفاة رجالي حصر', 
    'لونا مرطب شفاه رجالي بالبانثينول وفيتامين إي 3.5 جرام', 
    36.00, 36.00, 'Skin Care i', 'ودا مستحضرات التجميل',
    'Lip_Care', 
    'lip_repair_balm', 
    'Men protective lip balm formulated with panthenol and vitamin E.', 
    FALSE
),
(
    100662, 
    'LUNA OXY 10 VOL 80 ML(3%) ماء اكسجين', 
    'لونا أكسجين تركيز 10 - 3% لتفتيح وصبغ الشعر 80 مل', 
    17.00, 17.00, 'Bleacher0', 'ودا مستحضرات التجميل',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Hair bleaching/developer chemical product outside core cosmeceutical skincare scope.', 
    TRUE
),
(
    100663, 
    'LUNA OXY 20 VOL 80 ML(6%) ماء اكسجين', 
    'لونا أكسجين تركيز 20 - 6% لتفتيح وصبغ الشعر 80 مل', 
    18.00, 18.00, 'Bleacher0', 'ودا مستحضرات التجميل',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Hair bleaching/developer chemical product outside core cosmeceutical skincare scope.', 
    TRUE
),
(
    100664, 
    'LUNA OXY 30 VOL 80 ML (9%) ماء اكسجين', 
    'لونا أكسجين تركيز 30 - 9% لتفتيح وصبغ الشعر 80 مل', 
    20.00, 20.00, 'Bleacher0', 'ودا مستحضرات التجميل',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Hair bleaching/developer chemical product outside core cosmeceutical skincare scope.', 
    TRUE
),
(
    98039, 
    'LUNA OXY CREAM 20 VOL 75ML للشعر فقط', 
    'لونا أكسجين كريمي تركيز 20 للشعر فقط 75 مل', 
    30.00, 30.00, 'Bleacher0', 'ودا مستحضرات التجميل',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Hair bleaching/developer chemical product outside core cosmeceutical skincare scope.', 
    TRUE
),
(
    94849, 
    'LUNA OXY CREAM 30 VOL 75ML للشعر فقط', 
    'لونا أكسجين كريمي تركيز 30 للشعر فقط 75 مل', 
    32.00, 32.00, 'Bleacher0', 'ودا مستحضرات التجميل',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Hair bleaching/developer chemical product outside core cosmeceutical skincare scope.', 
    TRUE
),
(
    108376, 
    'LUNA PANTHENOL HAIR SHAMP NEEM OIL 200MLزيت النيم', 
    'لونا بانثينول شامبو للشعر بزيت النيم المغذي 200 مل', 
    70.00, 70.00, 'Hair Shamp', 'ودا مستحضرات التجميل',
    'Hair_Scalp_Care', 
    'nourishing_hair_shampoo', 
    'Nourishing panthenol hair shampoo enriched with neem oil for scalp and hair care.', 
    FALSE
),
(
    45144, 
    'LUNA POWDER TALC 200G بودرة تلك بدون رائحة', 
    'لونا بودرة تلك معطرة للجسم بدون رائحة 200 جرام', 
    90.00, 90.00, 'dosage', 'ودا مستحضرات التجميل',
    'Specialized_Body_Care', 
    'body_moisturizing_lotion', 
    'Unscented body talcum powder for skin comfort and moisture absorption.', 
    FALSE
),
(
    86560, 
    'LUNA ROSE WATER FACIAL TONER 100ML ماء ورد', 
    'لونا ماء ورد تونر منظف ومضفي للنضارة للوجه 100 مل', 
    35.00, 35.00, 'dosage', 'ودا مستحضرات التجميل',
    'Specialized_Care', 
    'soothing_thermal_water', 
    'Refreshing natural rose water facial toner for skin radiance and calming.', 
    FALSE
),
(
    140384, 
    'LUNA SHOWER GEL COCONUT MILK 500ML', 
    'لونا شاور جل غسول للجسم بحليب جوز الهند 500 مل', 
    95.00, 95.00, 'Get Topica', 'ودا مستحضرات التجميل',
    'Skin_Cleansing', 
    'lipid_replenishing_cleanser', 
    'Nourishing body shower gel formulated with coconut milk extract.', 
    FALSE
),
(
    115616, 
    'LUNA SHOWER GEL COTTON FLOWERS 500ML', 
    'لونا شاور جل غسول للجسم بزهور القطن 500 مل', 
    95.00, 95.00, 'Get Topica', 'ودا مستحضرات التجميل',
    'Skin_Cleansing', 
    'lipid_replenishing_cleanser', 
    'Soothing body shower gel scented with cotton flowers.', 
    FALSE
),
(
    139845, 
    'LUNA SHOWER GEL GLYC&OLIVE2(LIT)%20خصم', 
    'لونا شاور جل غسول للجسم بالجلسرين والزيتون عبوة لترين', 
    136.00, 136.00, 'Get Topica', 'ودا مستحضرات التجميل',
    'Skin_Cleansing', 
    'lipid_replenishing_cleanser', 
    'Large family-size body shower gel formulated with glycerin and olive oil.', 
    FALSE
),
(
    115615, 
    'LUNA SHOWER GEL GLYCERIN OLIVE 500ML', 
    'لونا شاور جل غسول للجسم بالجلسرين وزيت الزيتون 500 مل', 
    95.00, 95.00, 'Get Topica', 'ودا مستحضرات التجميل',
    'Skin_Cleansing', 
    'lipid_replenishing_cleanser', 
    'Hydrating body shower gel with glycerin and olive oil.', 
    FALSE
),
(
    115618, 
    'LUNA SHOWER GEL ROSE MILK 500ML', 
    'لونا شاور جل غسول للجسم بالورد والحليب 500 مل', 
    95.00, 95.00, 'Get Topica', 'ودا مستحضرات التجميل',
    'Skin_Cleansing', 
    'lipid_replenishing_cleanser', 
    'Softening body shower gel formulated with rose and milk.', 
    FALSE
),
(
    139847, 
    'LUNA SHOWER GEL ROSE&MILK2(LIT)%20خصم', 
    'لونا شاور جل غسول للجسم بالورد والحليب عبوة لترين', 
    136.00, 136.00, 'Get Topica', 'ودا مستحضرات التجميل',
    'Skin_Cleansing', 
    'lipid_replenishing_cleanser', 
    'Large family-size softening body wash with rose and milk.', 
    FALSE
),
(
    115617, 
    'LUNA SHOWER GEL SHEA BUTTER 500ML', 
    'لونا شاور جل غسول للجسم بزبدة الشيا 500 مل', 
    95.00, 95.00, 'Get Topica', 'ودا مستحضرات التجميل',
    'Skin_Cleansing', 
    'lipid_replenishing_cleanser', 
    'Nourishing body shower gel enriched with shea butter.', 
    FALSE
),
(
    88469, 
    'LUNA EMOLIENT LIP THERAY SHEA BUTTER 10G مرطب شفاة', 
    'لونا مرطب شفاه إيمولينت بزبدة الشيا 10 جرام', 
    70.00, 70.00, 'Cream Top', 'ودا مستحضرات التجميل',
    'Lip_Care', 
    'lip_repair_balm', 
    'Emollient lip therapy balm formulated with shea butter for dry lips.', 
    FALSE
),
(
    132634, 
    'LUNA EMOLLENT CREAM SHEA BUTTER 160GM', 
    'لونا كريم مرطب إيمولينت بزبدة الشيا 160 جرام', 
    130.00, 130.00, 'Cream Top', 'IMPORTED',
    'Skin_Moisturization_Barrier', 
    'barrier_repair_hydrator', 
    'Deeply nourishing emollient cream enriched with shea butter for dry skin.', 
    FALSE
),
(
    87767, 
    'LUNA EMOLLENT CREAM SHEA BUTTER 50ML', 
    'لونا كريم مرطب إيمولينت بزبدة الشيا 50 مل', 
    65.00, 65.00, 'Cream Top', 'IMPORTED',
    'Skin_Moisturization_Barrier', 
    'barrier_repair_hydrator', 
    'Nourishing emollient cream with shea butter for skin barrier care.', 
    FALSE
),
(
    52124, 
    'LUNA EMOLLENT CREAM COCOA HAND&BODY 300ML', 
    'لونا كريم مرطب إيمولينت لليدين والجسم بالكاكاو 300 مل', 
    200.00, 200.00, 'Skin Care f', 'ودا مستحضرات التجميل',
    'Specialized_Body_Care', 
    'body_moisturizing_lotion', 
    'Nourishing hand and body emollient cream infused with cocoa butter.', 
    FALSE
),
(
    87766, 
    'LUNA EMOLLENT CREAM HAND&BODYCOCOA 75ML', 
    'لونا كريم مرطب إيمولينت لليدين والجسم بالكاكاو 75 مل', 
    65.00, 65.00, 'Body Fac', 'ودا مستحضرات التجميل',
    'Specialized_Body_Care', 
    'body_moisturizing_lotion', 
    'Compact size hand and body cocoa emollient cream.', 
    FALSE
),
(
    46944, 
    'LUNA EMOLLENT HAND&HEEL CREAM 40GM تشققات جلسرين', 
    'لونا كريم مرطب إيمولينت لعلاج تشققات اليدين والكعبين بالجلسرين 40 جرام', 
    55.00, 55.00, 'Cream Top', 'ودا مستحضرات التجميل',
    'Specialized_Body_Care', 
    'hand_repair_cream', 
    'Intensive emollient cream formulated with glycerin to heal cracked hands and heels.', 
    FALSE
),
(
    34844, 
    'LUNA EMOLLENT HAND&HEEL CREAM 20GMتشققات جلسرين', 
    'لونا كريم مرطب إيمولينت لعلاج تشققات اليدين والكعبين بالجلسرين 20 جرام', 
    35.00, 35.00, 'Cream Top', 'ودا مستحضرات التجميل',
    'Specialized_Body_Care', 
    'hand_repair_cream', 
    'Compact emollient cream for cracked hands and heels care.', 
    FALSE
),
(
    45138, 
    'LUNA FOOT POWDER 75G بودرة قدم', 
    'لونا بودرة معطرة ومزيلة لرائحة القدمين 75 جرام', 
    50.00, 50.00, 'dosage', 'ودا مستحضرات التجميل',
    'Specialized_Body_Care', 
    'antiperspirant_deodorant', 
    'Deodorizing and refreshing foot powder to absorb moisture and odor.', 
    FALSE
),
(
    45803, 
    'LUNA الاستنشاق بالمنتول', 
    'لونا قلم استنشاق الأنف بالمنتول المنعش', 
    20.00, 20.00, 'dosage', 'ودا مستحضرات التجميل',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Respiratory inhaler product outside core cosmeceutical skincare scope.', 
    TRUE
),
(
    90079, 
    'LUNA KIDS SUN SCR SPF50 DELICATE ALL SKIN 130ML', 
    'لونا واقي شمس مخصص للأطفال لطيف على جميع أنواع البشرة SPF50 بحجم 130 مل', 
    275.00, 275.00, 'Sun produ', 'ودا مستحضرات التجميل',
    'Sun_Protection', 
    'kids_sunscreen_spray', 
    'Delicate high-protection sunscreen lotion formulated for children skin.', 
    FALSE
),
(
    44924, 
    'LUNA LIP NATURAL MOIST COCONUT BEEWAX 36PCS شكل جديد', 
    'لونا مرطب شفاه طبيعي بشمع العسل وجوز الهند 36 قطعة', 
    30.00, 1080.00, 'Lip Gloss', 'ودا مستحضرات التجميل',
    'Lip_Care', 
    'lip_repair_balm', 
    'Natural beeswax and coconut lip moisturizer stick.', 
    FALSE
),
(
    73290, 
    'LUNA LIP NATURAL MOIST STRAWBERY BEEWAX 36PC ل خدي', 
    'لونا مرطب شفاه طبيعي بشمع العسل والفراولة 36 قطعة', 
    30.00, 1080.00, 'Lip Gloss', 'ودا مستحضرات التجميل',
    'Lip_Care', 
    'lip_repair_balm', 
    'Natural beeswax and strawberry flavored lip moisturizer stick.', 
    FALSE
),
(
    125000, 
    'LUNA LIP SUN CARE (SPF30) 3.5GM 20% خصم', 
    'لونا مرطب شفاه واقي شمس SPF30 بحجم 3.5 جرام', 
    40.00, 40.00, 'dosage', 'ودا مستحضرات التجميل',
    'Lip_Care', 
    'lip_repair_balm', 
    'Protective lip balm formulated with SPF30 to shield lips from sun damage.', 
    FALSE
),
(
    133238, 
    'LUNA LIP THERAPY SHEA&ROSE&ALMOND 10G مرطب شفاة', 
    'لونا مرطب شفاه علاجية بالشيا والورد واللوز 10 جرام', 
    70.00, 70.00, 'Skin Care f', 'ودا مستحضرات التجميل',
    'Lip_Care', 
    'lip_repair_balm', 
    'Therapeutic lip balm enriched with shea butter, rose, and almond oils.', 
    FALSE
),
(
    146195, 
    'LUNA LIQUID HAND SOAP ROSE&MILK 500ML ورد وحليب', 
    'لونا صابون سائل لليدين بالورد والحليب 500 مل', 
    75.00, 75.00, 'Hand Gel0', 'EGYPT',
    'Skin_Cleansing', 
    'lipid_replenishing_cleanser', 
    'Fragrant liquid hand soap formulated with rose and milk extracts.', 
    FALSE
),
(
    146194, 
    'LUNA LIQUID HAND SOAP SHEA BUTTER 500ML زبدة شيا', 
    'لونا صابون سائل لليدين بزبدة الشيا 500 مل', 
    75.00, 75.00, 'Hand Gel0', 'EGYPT',
    'Skin_Cleansing', 
    'lipid_replenishing_cleanser', 
    'Nourishing liquid hand soap enriched with shea butter.', 
    FALSE
),
(
    146196, 
    'LUNA LIQUID HAND SOAP TWIST BERRIES 500ML تويست بيري', 
    'لونا صابون سائل لليدين بتويست بيري 500 مل', 
    75.00, 75.00, 'Hand Gel0', 'EGYPT',
    'Skin_Cleansing', 
    'lipid_replenishing_cleanser', 
    'Cleansing liquid hand soap scented with twist berries.', 
    FALSE
),
(
    138749, 
    'LUNA MAKE UP REMOVE(2IN1) 130GMمزيل مكياج لجميع انو', 
    'لونا مزيل مكياج 2 في 1 لجميع أنواع البشرة 130 جرام', 
    75.00, 75.00, 'Facial Sup', 'ودا مستحضرات التجميل',
    'Skin_Cleansing', 
    'micellar_cleansing_water', 
    '2-in-1 facial makeup remover and cleansing cream for all skin types.', 
    FALSE
),
INSERT INTO cosmeceutical_product_classification_full (
    code, name_en, name_ar, price_1, price_2, category, supplier,
    domain, subcategory, reason, review_required
) VALUES
(
    144690, 
    'LUNA AFTER SUN GEL ALOE VERA 210GM', 
    'لونا جل صبار مهدئ بعد التعرض للشمس 210 جرام', 
    185.00, 185.00, 'dosage', 'ودا مستحضرات التجميل',
    'Specialized_Care', 
    'after_sun_soothing_lotion', 
    'Soothing and cooling post-sun gel enriched with Aloe Vera for skin hydration.', 
    FALSE
),
(
    90076, 
    'LUNA AFTER SUN LOTION MOIST EXTRA COOL 130ML', 
    'لونا لوشن مرطب ومبرد بعد التعرض للشمس 130 مل', 
    150.00, 150.00, 'Sun produ', 'ودا مستحضرات التجميل',
    'Specialized_Care', 
    'after_sun_soothing_lotion', 
    'Cooling and moisturizing lotion for post-sun exposure skin soothing.', 
    FALSE
),
(
    87581, 
    'LUNA GLYCERIN SOAP TRANSPARENT 115GM صابون شفاف', 
    'لونا صابونة جلسرين شفافة مرطبة 115 جرام', 
    55.00, 55.00, 'Soap0', 'ودا مستحضرات التجميل',
    'Skin_Cleansing', 
    'lipid_replenishing_cleanser', 
    'Transparent hydrating glycerin soap bar for daily skin cleansing.', 
    FALSE
),
(
    44628, 
    'LUNA GLYCERIN SOAP TRANSPARENT 72GM صابون شفاف #', 
    'لونا صابونة جلسرين شفافة مرطبة 72 جرام', 
    30.00, 30.00, 'Soap0', 'ودا مستحضرات التجميل',
    'Skin_Cleansing', 
    'lipid_replenishing_cleanser', 
    'Transparent moisturizing glycerin cleansing soap bar.', 
    FALSE
),
(
    137872, 
    'LUNA GLYCERIN SOAP(1+1)OLIVE+FRAGRANCE 72GM30م', 
    'لونا مجموعة صابون جلسرين زيتون + معطر 72 جرام', 
    60.00, 60.00, 'Soap0', 'ودا مستحضرات التجميل',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Promotional bundle containing multiple soap variants across options.', 
    TRUE
),
(
    137873, 
    'LUNA GLYCERIN SOAP(1+1)ROSE+FRAGRANCE 72GM30م', 
    'لونا مجموعة صابون جلسرين ورد + معطر 72 جرام', 
    51.00, 51.00, 'Soap0', 'ودا مستحضرات التجميل',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Promotional bundle containing multiple soap variants across options.', 
    TRUE
),
(
    137871, 
    'LUNA GLYCERIN SOAP(1+1)TWIST+FRAGRANCE 72GM30م', 
    'لونا مجموعة صابون جلسرين تويست بيري + معطر 72 جرام', 
    58.10, 58.10, 'Soap0', 'ودا مستحضرات التجميل',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Promotional bundle containing multiple soap variants across options.', 
    TRUE
),
(
    24580, 
    'LUNA SPRAY SUN KIDS SPF36 ALL SKIN 165ML', 
    'لونا بخاخ واقي شمس للأطفال لجميع أنواع البشرة SPF36 بحجم 165 مل', 
    200.00, 200.00, 'Skin Care i', 'ودا مستحضرات التجميل',
    'Sun_Protection', 
    'kids_sunscreen_spray', 
    'Child-friendly broad-spectrum sunscreen spray with SPF36 for sensitive skin.', 
    FALSE
),
(
    26851, 
    'LUNA SUN INTENSE TAN GEL ALL SKIN 130ML لون برونزي', 
    'لونا جل تسمير لإعطاء لون برونزي لجميع أنواع البشرة 130 مل', 
    300.00, 300.00, 'Sun produ', 'ودا مستحضرات التجميل',
    'Sun_Protection', 
    'body_sunscreen_water', 
    'Tanning gel formulation to accentuate bronze tan across all skin types.', 
    FALSE
),
(
    88976, 
    'LUNA BODY SPLASH COLOGNE COTTON FLOWERS 250M', 
    'لونا بودي سبلاش كولونيا معطرة بزهور القطن 250 مل', 
    100.00, 100.00, 'PERFUMES', 'ودا مستحضرات التجميل',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Body splash fragrance product outside core cosmeceutical skincare scope.', 
    TRUE
),
(
    88977, 
    'LUNA BODY SPLASH COLOGNE ROSE DESIRE 250ML', 
    'لونا بودي سبلاش كولونيا معطرة بالورد 250 مل', 
    100.00, 100.00, 'PERFUMES', 'ودا مستحضرات التجميل',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Body splash fragrance product outside core cosmeceutical skincare scope.', 
    TRUE
),
(
    88979, 
    'LUNA BODY SPLASH COLOGNE TWIST BERRIES 250ML', 
    'لونا بودي سبلاش كولونيا معطرة بتويست بيري 250 مل', 
    100.00, 100.00, 'PERFUMES', 'ودا مستحضرات التجميل',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Body splash fragrance product outside core cosmeceutical skincare scope.', 
    TRUE
),
(
    114103, 
    'LUNA CREAM EMOLLIENTCOLLAGEN&VITAMIN E 160GM', 
    'لونا كريم مرطب إيمولينت بالكولاجين وفيتامين إي 160 جرام', 
    95.00, 95.00, 'Cream Top', 'ودا مستحضرات التجميل',
    'Skin_Moisturization_Barrier', 
    'barrier_repair_hydrator', 
    'Emollient moisturizing cream enriched with Collagen and Vitamin E for skin elasticity.', 
    FALSE
),
(
    114102, 
    'LUNA CREAM EMOLLIENTCOLLAGEN&VITAMIN E 50GM', 
    'لونا كريم مرطب إيمولينت بالكولاجين وفيتامين إي 50 جرام', 
    40.00, 40.00, 'Cream Top', 'ودا مستحضرات التجميل',
    'Skin_Moisturization_Barrier', 
    'barrier_repair_hydrator', 
    'Compact collagen and vitamin E emollient moisturizing cream.', 
    FALSE
),
(
    114101, 
    'LUNA CREAM EMOLLIENTGLYCERIN&JOJOBA 160GM', 
    'لونا كريم مرطب إيمولينت بالجلسرين وزيت الجوجوبا 160 جرام', 
    95.00, 95.00, 'Cream Top', 'ودا مستحضرات التجميل',
    'Skin_Moisturization_Barrier', 
    'barrier_repair_hydrator', 
    'Emollient moisturizing cream with Glycerin and Jojoba oil for barrier repair.', 
    FALSE
),
(
    114100, 
    'LUNA CREAM EMOLLIENTGLYCERIN&JOJOBA 50GM', 
    'لونا كريم مرطب إيمولينت بالجلسرين وزيت الجوجوبا 50 جرام', 
    40.00, 40.00, 'Cream Top', 'ودا مستحضرات التجميل',
    'Skin_Moisturization_Barrier', 
    'barrier_repair_hydrator', 
    'Compact glycerin and jojoba emollient cream for daily hydration.', 
    FALSE
),
(
    133240, 
    'LUNA DEEP LIP BALM HYALU&ESSEN 3.5G 20 مرطب شفاة حصر', 
    'لونا مرطب شفاه بلس بالهيالورونيك 3.5 جرام', 
    40.00, 40.00, 'Skin Care f', 'ودا مستحضرات التجميل',
    'Lip_Care', 
    'lip_repair_balm', 
    'Deeply hydrating lip balm formulated with Hyaluronic Acid for plump lips.', 
    FALSE
),
(
    128092, 
    'BOBANA MASK WHITE FIRM COLLAGEN 250GM ماسك التفتيح', 
    'بوبانا قناع الكولاجين للتفتيح وشد البشرة 250 جرام', 
    65.00, 65.00, 'Skin Care f', 'جن لمستحضرات التجميل',
    'Anti_Aging_Skin_Rejuvenation', 
    'firming_radiance_gel', 
    'Firming and brightening facial collagen mask for skin whitening and elasticity.', 
    FALSE
),
(
    80568, 
    'BOBANA MOROCCAN SOAP ARGAN 500GM صابون مغربي ارجان', 
    'بوبانا صابون مغربي بزيت الأرجان 500 جرام', 
    75.00, 75.00, 'Soap0', 'جن لمستحضرات التجميل',
    'Skin_Cleansing', 
    'lipid_replenishing_cleanser', 
    'Traditional Moroccan black soap enriched with Argan oil for body cleansing.', 
    FALSE
),
(
    80569, 
    'BOBANA MOROCCAN SOAP OLIVE 500GM صابون مغربي زيتون', 
    'بوبانا صابون مغربي بزيت الزيتون 500 جرام', 
    75.00, 75.00, 'Soap0', 'جن لمستحضرات التجميل',
    'Skin_Cleansing', 
    'lipid_replenishing_cleanser', 
    'Traditional Moroccan black soap with Olive oil for deep body cleansing.', 
    FALSE
),
(
    83243, 
    'BOBANA MUD MASK DEAD SEA 400GMقناع طمي بحر ميت', 
    'بوبانا قناع طمي البحر الميت 400 جرام', 
    75.00, 75.00, 'Body Make', 'جن لمستحضرات التجميل',
    'Skin_Cleansing', 
    'purifying_cleansing_gel', 
    'Mineral-rich Dead Sea mud mask for skin purifying and detoxifying.', 
    FALSE
),
(
    49683, 
    'BOBANA NATURAL MUD MASK 400GM قناع طمي طبيعي', 
    'بوبانا قناع الطمي الطبيعي 400 جرام', 
    75.00, 75.00, 'Facial Sup', 'جن لمستحضرات التجميل',
    'Skin_Cleansing', 
    'purifying_cleansing_gel', 
    'Natural purifying mud mask for absorbing excess oil and pore cleansing.', 
    FALSE
),
(
    80564, 
    'BOBANA PEEL OFF MASK HYALURONIC 120GM قناع هيالورونيك', 
    'بوبانا قناع مقشر بالهيالورونيك أسيد 120 جرام', 
    75.00, 75.00, 'Facial Sup', 'جن لمستحضرات التجميل',
    'Skin_Moisturization_Barrier', 
    'hydrating_sheet_mask', 
    'Hydrating peel-off face mask with Hyaluronic Acid for skin renewal.', 
    FALSE
),
(
    80565, 
    'BOBANA PEEL OFF MASK VITAMIN C 120GM قناع فيتامين سي', 
    'بوبانا قناع مقشر بفيتامين سي 120 جرام', 
    75.00, 75.00, 'Facial Sup', 'جن لمستحضرات التجميل',
    'Pigmentation_Skin_Tone', 
    'anti_pigmentation_serum', 
    'Brightening peel-off mask enriched with Vitamin C for radiant complexion.', 
    FALSE
),
(
    104757, 
    'BOBANA PEEL-OFF FACE MASK CHARCOAL 120G قناع بالفحم', 
    'بوبانا قناع مقشر للوجه بالفحم المنشط 120 جرام', 
    75.00, 75.00, 'Body Face', 'IMPORTED',
    'Acne_Oil_Control', 
    'salicylic_acid_exfoliator', 
    'Purifying charcoal peel-off mask designed to clear blackheads and excess sebum.', 
    FALSE
),
(
    115952, 
    'BOBANA ROLL-ON VITAMIN C 80ML #C# فيتامين سي', 
    'بوبانا مزيل عرق رول أون بمستخلص فيتامين سي 80 مل', 
    66.00, 66.00, 'Deoderant', 'جن لمستحضرات التجميل',
    'Specialized_Body_Care', 
    'antiperspirant_deodorant', 
    'Brightening roll-on deodorant infused with Vitamin C.', 
    FALSE
),
(
    32135, 
    'BOBANA ROLL-ON WHITE CLEAN48H50ML #C# تفتيح امن', 
    'بوبانا مزيل عرق رول أون للتفتيح وحماية 48 ساعة 50 مل', 
    65.00, 65.00, 'Deoderant', 'جن لمستحضرات التجميل',
    'Specialized_Body_Care', 
    'antiperspirant_deodorant', 
    '48-hour protective roll-on deodorant formulated for underarm skin whitening.', 
    FALSE
),
(
    83153, 
    'BOBANA SCRUB GEL CHARCOAL 150ML جل صنفرة بالفحم', 
    'بوبانا جل صنفرة ومقشر بالفحم 150 مل', 
    100.00, 100.00, 'Facial Sup', 'جن لمستحضرات التجميل',
    'Acne_Oil_Control', 
    'salicylic_acid_exfoliator', 
    'Exfoliating charcoal scrub gel formulated to unclog pores.', 
    FALSE
),
(
    83154, 
    'BOBANA SCRUB GEL POMEGRANATE 150ML جل صنفرة بالرمان', 
    'بوبانا جل صنفرة ومقشر بالرمان 150 مل', 
    100.00, 100.00, 'Facial Sup', 'جن لمستحضرات التجميل',
    'Skin_Cleansing', 
    'purifying_cleansing_gel', 
    'Gentle pomegranate scrub gel for smoothing skin texture.', 
    FALSE
),
(
    78377, 
    'BOBANA SCRUB HONEY&COLAGEN 300ML صنفرة عسل وكولاجين', 
    'بوبانا كريم صنفرة بالعسل والكولاجين 300 مل', 
    68.00, 68.00, 'Body Scru', 'جن لمستحضرات التجميل',
    'Skin_Cleansing', 
    'purifying_cleansing_gel', 
    'Nourishing body scrub cream with Honey and Collagen for gentle exfoliation.', 
    FALSE
),
(
    135411, 
    'BOBANA SERUM SPF30 COCONUT OIL 100ML', 
    'بوبانا سيروم لحماية الشعر واقي شمس SPF30 بزيت جوز الهند 100 مل', 
    190.00, 190.00, 'Skin Care f', 'جن لمستحضرات التجميل',
    'Hair_Scalp_Care', 
    'nourishing_hair_serum', 
    'Protective hair serum with Coconut oil and SPF30 sun defense.', 
    FALSE
),
(
    115145, 
    'BOBANA SERUM SPF30 JOJOBA OIL 100ML', 
    'بوبانا سيروم لحماية الشعر واقي شمس SPF30 بزيت الجوجوبا 100 مل', 
    190.00, 190.00, 'Other Body', 'جن لمستحضرات التجميل',
    'Hair_Scalp_Care', 
    'nourishing_hair_serum', 
    'Hair protective serum with Jojoba oil and SPF30 sun filters.', 
    FALSE
),
(
    83149, 
    'BOBANA SHAMP HAIR BLACK GARLIC 400M شامبو ثوم اسود', 
    'بوبانا شامبو معالج ومقوي بالشعر بالثوم الأسود 400 مل', 
    160.00, 160.00, 'Hair Shamp', 'جن لمستحضرات التجميل',
    'Hair_Scalp_Care', 
    'anti_hair_loss_shampoo', 
    'Strengthening black garlic shampoo designed to reinforce weak hair roots.', 
    FALSE
),
(
    122084, 
    'BOBANA SHAP HAIR GEL ALOE VERA OIL 150M', 
    'بوبانا جل مصفف للشعر بزيت الصبار 150 مل', 
    110.00, 110.00, 'Hair Gel M', 'جن لمستحضرات التجميل',
    'Hair_Scalp_Care', 
    'scalp_treatment_leave_in', 
    'Styling hair gel enriched with Aloe Vera oil for moisture and hold.', 
    FALSE
),
(
    82718, 
    'BOBANA SHEET MASK CHARCOAL&VITAMIN E قناع فحم وفيتامين اي', 
    'بوبانا قناع ورقي بالفحم وفيتامين إي', 
    40.00, 40.00, 'Facial Sup', 'جن لمستحضرات التجميل',
    'Skin_Cleansing', 
    'hydrating_sheet_mask', 
    'Purifying charcoal sheet mask enriched with Vitamin E.', 
    FALSE
),
(
    84294, 
    'BOBANA SHEET MASK COLLAGEN&VITAMIN Cقناع كولاجين وفيتا س', 
    'بوبانا قناع ورقي بالكولاجين وفيتامين سي', 
    40.00, 40.00, 'Facial Sup', 'جن لمستحضرات التجميل',
    'Anti_Aging_Skin_Rejuvenation', 
    'hydrating_sheet_mask', 
    'Rejuvenating sheet mask with Collagen and Vitamin C for skin firming.', 
    FALSE
),
(
    84293, 
    'BOBANA SHEET MASK POMEGR&HYALU قناع رمان وحمض هيال', 
    'بوبانا قناع ورقي بالرمان والهيالورونيك', 
    40.00, 40.00, 'Facial Sup', 'جن لمستحضرات التجميل',
    'Skin_Moisturization_Barrier', 
    'hydrating_sheet_mask', 
    'Hydrating sheet mask with Pomegranate extract and Hyaluronic Acid.', 
    FALSE
),
(
    42282, 
    'BOBANA SKIN LIGHT CREAM FACE&BODY60G #C# كريم تفتيح', 
    'بوبانا كريم تفتيح للوجه والجسم 60 جرام', 
    50.00, 50.00, 'Body Fac', 'جن لمستحضرات التجميل',
    'Pigmentation_Skin_Tone', 
    'pigmentation_day_cream', 
    'Skin lightening cream for evening complexion tone on face and body.', 
    FALSE
),
(
    107889, 
    'BOBANA SOOTHING GEL AFTER SUN SPF30 150Mجل مهدئ', 
    'بوبانا جل مهدئ ومرطب بعد التعرض للشمس SPF30 بحجم 150 مل', 
    90.00, 90.00, 'Get Topica', 'جن لمستحضرات التجميل',
    'Specialized_Care', 
    'after_sun_soothing_lotion', 
    'Soothing and hydrating post-sun gel with protective SPF30.', 
    FALSE
),
INSERT INTO cosmeceutical_product_classification_full (
    code, name_en, name_ar, price_1, price_2, category, supplier,
    domain, subcategory, reason, review_required
) VALUES
(
    104763, 
    'BOBANA SPA LEMON SALT SMOOTH 300G #C#بالليمون', 
    'بوبانا ملح سبا مقشر بالليمون 300 جرام', 
    44.00, 44.00, 'Body Face', 'جن لمستحضرات التجميل',
    'Skin_Cleansing', 
    'purifying_cleansing_gel', 
    'Exfoliating spa salt body scrub infused with lemon extract to smooth skin texture.', 
    FALSE
),
(
    104762, 
    'BOBANA SPA MILK SALT WHITENING 300G #C# بالحليب', 
    'بوبانا ملح سبا مقشر ومفتح بالحليب 300 جرام', 
    44.00, 44.00, 'Body Face', 'جن لمستحضرات التجميل',
    'Pigmentation_Skin_Tone', 
    'pigmentation_day_cream', 
    'Body exfoliating milk spa salt formulated for skin brightening and softening.', 
    FALSE
),
(
    124168, 
    'BOBANA SUN SCREEN SPF50 GEL 150ML(1+1)', 
    'بوبانا جل واقي شمس عرض قطعتين SPF50 بحجم 150 مل', 
    350.00, 350.00, 'Get Topica', 'جن لمستحضرات التجميل',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Promotional double bundle set (1+1) containing sunscreen gel items.', 
    TRUE
),
(
    114180, 
    'BOBANA SUN SPF50 LOTION TINTED 60ML #C#', 
    'بوبانا لوشن واقي شمس ملون SPF50 بحجم 60 مل', 
    90.00, 90.00, 'Sun produ', 'جن لمستحضرات التجميل',
    'Sun_Protection', 
    'tinted_facial_sunscreen', 
    'Tinted sunscreen lotion offering high SPF50 protection and complexion coverage.', 
    FALSE
),
(
    83152, 
    'BOBANA SUNSCREEN SPF50 LOTION 150MLلاودن واقي الشمس', 
    'بوبانا لوشن واقي شمس SPF50 بحجم 150 مل', 
    125.00, 125.00, 'Sun produ', 'جن لمستحضرات التجميل',
    'Sun_Protection', 
    'body_sunscreen_lotion', 
    'Broad-spectrum body sunscreen lotion providing high SPF50 protection.', 
    FALSE
),
(
    128093, 
    'BOBANA WHIT CREAM FACE BODY 50ML تفتيح الوجه والجسم', 
    'بوبانا كريم تفتيح للوجه والجسم 50 مل', 
    58.00, 58.00, 'Cream Top', 'جن لمستحضرات التجميل',
    'Pigmentation_Skin_Tone', 
    'pigmentation_day_cream', 
    'Skin brightening cream for evening complexion tone across face and body.', 
    FALSE
),
(
    128094, 
    'BOBANA WHIT CREAM SENSITIVE 50ML تفتيح المناطق الح', 
    'بوبانا كريم تفتيح للمناطق الحساسة 50 مل', 
    58.00, 58.00, 'Cream Top', 'جن لمستحضرات التجميل',
    'Pigmentation_Skin_Tone', 
    'pigmentation_day_cream', 
    'Targeted skin lightening cream formulated for sensitive areas.', 
    FALSE
),
(
    127336, 
    'BOBANA WHITE HERE ROLL-ON (FLORAL) 50ML #C# ورود موف', 
    'بوبانا مزيل عرق رول أون برائحة الزهور 50 مل', 
    65.00, 65.00, 'Deoderant', 'جن لمستحضرات التجميل',
    'Specialized_Body_Care', 
    'antiperspirant_deodorant', 
    'Roll-on antiperspirant deodorant with floral scent formulated for skin whitening.', 
    FALSE
),
(
    127337, 
    'BOBANA WHITE HERE ROLL-ON (COCONUT) 50ML #C# جوز هند بني', 
    'بوبانا مزيل عرق رول أون برائحة جوز الهند 50 مل', 
    65.00, 65.00, 'Deoderant', 'جن لمستحضرات التجميل',
    'Specialized_Body_Care', 
    'antiperspirant_deodorant', 
    'Brightening roll-on antiperspirant deodorant scented with coconut.', 
    FALSE
),
(
    134105, 
    'BOBANA WHITE HERE ROLL-ON (UNSCENTED) 50ML بدون رائحة', 
    'بوبانا مزيل عرق رول أون بدون رائحة 50 مل', 
    65.00, 65.00, 'Deoderant', 'جن لمستحضرات التجميل',
    'Specialized_Body_Care', 
    'antiperspirant_deodorant', 
    'Unscented brightening roll-on antiperspirant deodorant for sensitive underarms.', 
    FALSE
),
(
    131322, 
    'BOBANA DRY OIL 100MLزيت بوبانا الجاف', 
    'بوبانا زيت جاف مغذي للبشرة والشعر 100 مل', 
    280.00, 280.00, 'Deoderant', 'جن لمستحضرات التجميل',
    'Specialized_Body_Care', 
    'body_moisturizing_lotion', 
    'Nourishing dry oil spray formulated for body skin and hair softness.', 
    FALSE
),
(
    131321, 
    'BOBANA DRY OIL SHIMMER 100MLزيت بوبانا الجاف البر', 
    'بوبانا زيت جاف مع لمعة وشيمر للبشرة والشعر 100 مل', 
    280.00, 280.00, 'Deoderant', 'جن لمستحضرات التجميل',
    'Specialized_Body_Care', 
    'body_moisturizing_lotion', 
    'Illuminating dry oil spray with shimmer particles for body and hair enhancement.', 
    FALSE
),
(
    141309, 
    'BOBANA FACE WASH CHARCOAL(150M+50M) FREEل وجه ف', 
    'بوبانا جل غسول للوجه بالفحم مجموعة 150 مل + 50 مل مجاناً', 
    85.00, 85.00, 'Other Body', 'جن لمستحضرات التجميل',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Promotional bundle set featuring facial cleansing gel with extra travel-size free unit.', 
    TRUE
),
(
    29691, 
    'BOBANA FACE WASH VITAMIN C 150ML غسول وجه فيتامين', 
    'بوبانا جل غسول للوجه بفيتامين سي 150 مل', 
    85.00, 85.00, 'Other Body', 'جن لمستحضرات التجميل',
    'Skin_Cleansing', 
    'brightening_cleansing_gel', 
    'Brightening facial cleansing gel enriched with Vitamin C.', 
    FALSE
),
(
    80571, 
    'BOBANA GEL COLLAGEN HYALURONIC 250MLجل هيالورونيك', 
    'بوبانا جل الكولاجين والهيالورونيك مرطب للوجه والجسم 250 مل', 
    175.00, 175.00, 'Get Topica', 'جن لمستحضرات التجميل',
    'Skin_Moisturization_Barrier', 
    'barrier_repair_hydrator', 
    'Hydrating facial and body gel formulated with Collagen and Hyaluronic Acid.', 
    FALSE
),
(
    115386, 
    'BOBANA GEL COLLAGEN RETINOL 250ML جل الريتينول', 
    'بوبانا جل الكولاجين والريتينول مجدد للبشرة 250 مل', 
    175.00, 175.00, 'Get Topica', 'جن لمستحضرات التجميل',
    'Anti_Aging_Skin_Rejuvenation', 
    'retinol_anti_aging_serum', 
    'Rejuvenating gel formula containing Collagen and Retinol to promote skin renewal.', 
    FALSE
),
(
    80570, 
    'BOBANA GEL COLLAGEN VITAMIN C 250MLجل فيتامين سي', 
    'بوبانا جل الكولاجين وفيتامين سي مضيء للبشرة 250 مل', 
    175.00, 175.00, 'General Pe', 'جن لمستحضرات التجميل',
    'Anti_Aging_Skin_Rejuvenation', 
    'antioxidant_radiance_serum', 
    'Illuminating multi-use gel formulated with Collagen and Vitamin C.', 
    FALSE
),
(
    107884, 
    'BOBANA HAIR COND BLACK GARLIC OIL 400MLبلسم ثوم اسود', 
    'بوبانا بلسم معالج ومقوي بزيت الثوم الأسود 400 مل', 
    140.00, 140.00, 'Hair Condit', 'جن لمستحضرات التجميل',
    'Hair_Scalp_Care', 
    'hair_conditioner_balm', 
    'Strengthening hair conditioner formulated with Black Garlic oil for fragile hair.', 
    FALSE
),
(
    107890, 
    'BOBANA HAIR MASK BLACKGARLIC 500G ماسك شعر ثوم اسود', 
    'بوبانا قناع شعر معالج بزيت الثوم الأسود 500 جرام', 
    200.00, 200.00, 'Hair Cream', 'جن لمستحضرات التجميل',
    'Hair_Scalp_Care', 
    'repairing_hair_mask', 
    'Intensive repairing hair mask treatment with Black Garlic oil.', 
    FALSE
),
(
    122086, 
    'BOBANA HAND CREAM TROPICA FRUITS 50ML', 
    'بوبانا كريم مرطب لليدين بالفواكه الاستوائية 50 مل', 
    60.00, 60.00, 'Hand Crea', 'جن لمستحضرات التجميل',
    'Specialized_Body_Care', 
    'hand_repair_cream', 
    'Hydrating hand cream scented with tropical fruits for hand softness.', 
    FALSE
),
(
    122085, 
    'BOBANA HAND CREAM WILD ROSES 50ML', 
    'بوبانا كريم مرطب لليدين بالورود البرية 50 مل', 
    60.00, 60.00, 'Hand Crea', 'جن لمستحضرات التجميل',
    'Specialized_Body_Care', 
    'hand_repair_cream', 
    'Nourishing hand cream scented with wild roses for daily moisture.', 
    FALSE
),
(
    134107, 
    'BOBANA LEAVE-IN COND ARGAN OIL 240MLبديل زيت ارجان', 
    'بوبانا بلسم يترك على الشعر بديل الزيت بالأرجان 240 مل', 
    145.00, 145.00, 'Hair Cream', 'جن لمستحضرات التجميل',
    'Hair_Scalp_Care', 
    'hair_oil_replacement', 
    'Leave-in oil replacement conditioner enriched with Argan oil.', 
    FALSE
),
(
    115383, 
    'BOBANA LEAVE-IN CREAM ARGAN 200Mكريم ارجان', 
    'بوبانا كريم يترك على الشعر بزيت الأرجان 200 مل', 
    145.00, 145.00, 'Hair Cream', 'جن لمستحضرات التجميل',
    'Hair_Scalp_Care', 
    'hair_conditioner_balm', 
    'Nourishing leave-in hair cream enriched with Argan oil.', 
    FALSE
),
(
    115384, 
    'BOBANA LEAVE-IN CREAM BLACK GARLIC 200Mكريم الثوم', 
    'بوبانا كريم يترك على الشعر بالثوم الأسود 200 مل', 
    145.00, 145.00, 'Hair Cream', 'جن لمستحضرات التجميل',
    'Hair_Scalp_Care', 
    'hair_conditioner_balm', 
    'Strengthening leave-in hair cream with Black Garlic oil.', 
    FALSE
),
(
    135252, 
    'BOBANA LEMON SPA SALT SCRUB 300G ملح صنفرة ليمون ب', 
    'بوبانا ملح سبا مقشر بالليمون 300 جرام', 
    45.00, 45.00, 'Body Fac', 'جن لمستحضرات التجميل',
    'Skin_Cleansing', 
    'purifying_cleansing_gel', 
    'Exfoliating spa salt scrub with lemon extract for skin smoothing.', 
    FALSE
),
(
    42133, 
    'BOBANA LIGHT CREAM SENSITIVE AREAS 60G #C# مناطق حس', 
    'بوبانا كريم تفتيح للمناطق الحساسة 60 جرام', 
    50.00, 50.00, 'Cream Top', 'جن لمستحضرات التجميل',
    'Pigmentation_Skin_Tone', 
    'pigmentation_day_cream', 
    'Gentle skin lightening cream formulated for sensitive body areas.', 
    FALSE
),
(
    112483, 
    'BOBANA LIP BALM COCO 5.5ML مرطب شفاة كاكاو', 
    'بوبانا مرطب شفاه بنكهة الكاكاو 5.5 مل', 
    60.00, 60.00, 'Lip Stick0', 'EGYPT',
    'Lip_Care', 
    'lip_repair_balm', 
    'Moisturizing lip balm stick with cocoa butter flavor.', 
    FALSE
),
(
    112479, 
    'BOBANA LIP BALM VITAMIN C KIWI 5.5ML مرطب شفاة كيوي', 
    'بوبانا مرطب شفاه بفيتامين سي والكيوي 5.5 مل', 
    60.00, 60.00, 'Lip Stick0', 'EGYPT',
    'Lip_Care', 
    'lip_repair_balm', 
    'Nourishing lip balm stick enriched with Vitamin C and Kiwi extract.', 
    FALSE
),
(
    77534, 
    'BOBANA SCRUB APRICOT 300GM صنفرة الوجه مشمش', 
    'بوبانا كريم صنفرة ومقشر بالمشمش 300 جرام', 
    68.00, 68.00, 'Body Scru', 'جن لمستحضرات التجميل',
    'Skin_Cleansing', 
    'purifying_cleansing_gel', 
    'Apricot face and body scrub cream for dead skin exfoliation.', 
    FALSE
),
(
    94477, 
    'BOBANA SCRUB CHARCOAL 300GM صنفرة بالفحم', 
    'بوبانا كريم صنفرة ومقشر بالفحم 300 جرام', 
    68.00, 68.00, 'Body Make', 'جن لمستحضرات التجميل',
    'Acne_Oil_Control', 
    'salicylic_acid_exfoliator', 
    'Purifying charcoal exfoliating scrub cream for deep pore cleansing.', 
    FALSE
),
(
    104752, 
    'BOBANA SCRUB COFFEE 300G صنفرة قهوة', 
    'بوبانا كريم صنفرة ومقشر بالقهوة 300 جرام', 
    68.00, 68.00, 'Body Face', 'جن لمستحضرات التجميل',
    'Skin_Cleansing', 
    'purifying_cleansing_gel', 
    'Coffee exfoliating scrub cream designed to revitalize skin texture.', 
    FALSE
),
(
    84295, 
    'BOBANA SCRUB GEL VITAMIN C 150M جل صنفرة فيتامين س', 
    'بوبانا جل صنفرة ومقشر بفيتامين سي 150 مل', 
    100.00, 100.00, 'Facial Sup', 'جن لمستحضرات التجميل',
    'Skin_Cleansing', 
    'brightening_cleansing_gel', 
    'Exfoliating scrub gel enriched with Vitamin C for skin radiance.', 
    FALSE
),
(
    94476, 
    'BOBANA SCRUB GOLD 300GM صنفرة بالذهب', 
    'بوبانا كريم صنفرة ومقشر بالذهب 300 جرام', 
    68.00, 68.00, 'Body Make', 'جن لمستحضرات التجميل',
    'Anti_Aging_Skin_Rejuvenation', 
    'firming_radiance_gel', 
    'Rejuvenating gold particle exfoliating scrub cream for skin glow.', 
    FALSE
),
(
    83147, 
    'BOBANA SHAMP HAIR ARGAN OIL,400ML شامبو زيت ارجان', 
    'بوبانا شامبو مغذي بزيت الأرجان 400 مل', 
    175.00, 175.00, 'Hair Sham', 'جن لمستحضرات التجميل',
    'Hair_Scalp_Care', 
    'nourishing_hair_shampoo', 
    'Nourishing shampoo enriched with Argan oil for dry hair hydration.', 
    FALSE
),
(
    83148, 
    'BOBANA SHAMP HAIR COCONUT OIL,400ML شامبو زيت جوزهند', 
    'بوبانا شامبو مرطب بزيت جوز الهند 400 مل', 
    160.00, 160.00, 'Hair Sham', 'جن لمستحضرات التجميل',
    'Hair_Scalp_Care', 
    'moisturizing_hair_shampoo', 
    'Hydrating hair shampoo infused with Coconut oil.', 
    FALSE
),
(
    138676, 
    'BOBANA SHEET MASK AVOCADO&RETINOL قناع الأفوكادورؤرى', 
    'بوبانا قناع ورقي بالأفوكادو والريتينول', 
    40.00, 40.00, 'Facial Sup', 'جن لمستحضرات التجميل',
    'Anti_Aging_Skin_Rejuvenation', 
    'hydrating_sheet_mask', 
    'Rejuvenating sheet mask with Avocado oil and Retinol for skin smooth renewal.', 
    FALSE
),
(
    104765, 
    'BOBANA SPA YOGURT SALT MOIST 300G 135537 شكل جديد', 
    'بوبانا ملح سبا مقشر بالزبادي 300 جرام', 
    44.00, 44.00, 'Body Face', 'IMPORTED',
    'Skin_Cleansing', 
    'purifying_cleansing_gel', 
    'Moisturizing yogurt spa salt body scrub for gentle exfoliation.', 
    FALSE
),
(
    124169, 
    'BOBANA SUNSCREEN SPF50 LOTION 150M (1+1)', 
    'بوبانا لوشن واقي شمس عرض قطعتين SPF50 بحجم 150 مل', 
    320.00, 320.00, 'Sun produ', 'جن لمستحضرات التجميل',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Promotional double bundle set (1+1) containing sunscreen lotion items.', 
    TRUE
),
(
    127335, 
    'BOBANA WHITE HERE ROLL (CANDY) 50ML كاندي احمر', 
    'بوبانا مزيل عرق رول أون برائحة الحلوى الكاندي 50 مل', 
    65.00, 65.00, 'Deoderant', 'جن لمستحضرات التجميل',
    'Specialized_Body_Care', 
    'antiperspirant_deodorant', 
    'Whitening roll-on antiperspirant deodorant with candy scent.', 
    FALSE
),
(
    135537, 
    'BOBANA YOGURT SPA SALT SCRUB 300GM ملح صنفرة زباد', 
    'بوبانا ملح سبا مقشر بالزبادي 300 جرام', 
    45.00, 45.00, 'Body Fac', 'جن لمستحضرات التجميل',
    'Skin_Cleansing', 
    'purifying_cleansing_gel', 
    'Yogurt-enriched body exfoliation spa salt scrub.', 
    FALSE
),
(
    135250, 
    'BOBANA BERRIES SPA SALT SCRUB 300GM ملح صنفرة توت ب', 
    'بوبانا ملح سبا مقشر بالتوت 300 جرام', 
    45.00, 45.00, 'Body Fac', 'جن لمستحضرات التجميل',
    'Skin_Cleansing', 
    'purifying_cleansing_gel', 
    'Berry-flavored body exfoliation spa salt scrub.', 
    FALSE
),
(
    122089, 
    'BOBANA BODY LOTION WILD ROSES 240ML', 
    'بوبانا لوشن مرطب للجسم بالورود البرية 240 مل', 
    155.00, 155.00, 'Lotion0', 'جن لمستحضرات التجميل',
    'Specialized_Body_Care', 
    'body_moisturizing_lotion', 
    'Hydrating body lotion scented with wild roses.', 
    FALSE
),
(
    142449, 
    'BOBANA BODY WASH TROPICAL FRUITS 240ML فواكه استواي', 
    'بوبانا غسول استحمام بالفواكه الاستوائية 240 مل', 
    115.00, 115.00, 'Body Face', 'جن لمستحضرات التجميل',
    'Skin_Cleansing', 
    'lipid_replenishing_cleanser', 
    'Fragrant body wash for daily shower and cleansing.', 
    FALSE
),
(
    142447, 
    'BOBANA BODY WASH WILD ROSES 240ML ورود برية انبوية', 
    'بوبانا غسول استحمام بالورود البرية 240 مل', 
    115.00, 115.00, 'Body Face', 'جن لمستحضرات التجميل',
    'Skin_Cleansing', 
    'lipid_replenishing_cleanser', 
    'Nourishing wild rose scented body wash for daily hygiene.', 
    FALSE
),
(
    121530, 
    'BOBANA CLAY MASK CHARCOAL CLEAN&DETOX #C# 150GM', 
    'بوبانا قناع الطمي المنقي بالفحم 150 جرام', 
    95.00, 95.00, 'Other Body', 'جن لمستحضرات التجميل',
    'Acne_Oil_Control', 
    'salicylic_acid_exfoliator', 
    'Purifying charcoal clay mask formulated for skin detoxifying and pore cleaning.', 
    FALSE
),
(
    121531, 
    'BOBANA CLAY MASK RED ALGAE MOIST&DETOX 150GM', 
    'بوبانا قناع الطمي بالمرطب بالطحالب الحمراء 150 جرام', 
    95.00, 95.00, 'Other Body', 'جن لمستحضرات التجميل',
    'Skin_Moisturization_Barrier', 
    'hydrating_sheet_mask', 
    'Hydrating and detoxifying red algae clay face mask.', 
    FALSE
),
(
    135410, 
    'BOBANA SERUM SPF30 ARGAN OIL 100ML', 
    'بوبانا سيروم واقي شمس للشعر بزيت الأرجان SPF30 بحجم 100 مل', 
    190.00, 190.00, 'Skin Care f', 'جن لمستحضرات التجميل',
    'Hair_Scalp_Care', 
    'nourishing_hair_serum', 
    'Argan oil hair serum infused with SPF30 for sun protection.', 
    FALSE
),
(
    124170, 
    'BOBANA (1+1) SUN SPF50 LOTION TINTED 60ML', 
    'بوبانا لوشن واقي شمس ملون عرض قطعتين SPF50 بحجم 60 مل', 
    230.00, 230.00, 'Sun produ', 'جن لمستحضرات التجميل',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Promotional double bundle set (1+1) containing tinted sunscreen lotion items.', 
    TRUE
),
(
    126545, 
    'BOBANA AFTER SUN SOOTH GEL SPF30(1+1) 150ML', 
    'بوبانا جل مهدئ بعد التعرض للشمس عرض قطعتين SPF30 بحجم 150 مل', 
    240.00, 240.00, 'Get Topica', 'جن لمستحضرات التجميل',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Promotional double bundle set (1+1) containing after-sun gel items.', 
    TRUE
),
(
    122088, 
    'BOBANA BODY LOTION COCONUT MILK 240ML', 
    'بوبانا لوشن مرطب للجسم بحليب جوز الهند 240 مل', 
    155.00, 155.00, 'Lotion0', 'جن لمستحضرات التجميل',
    'Specialized_Body_Care', 
    'body_moisturizing_lotion', 
    'Nourishing body lotion enriched with coconut milk.', 
    FALSE
),
(
    122090, 
    'BOBANA BODY LOTION TROPICAL FRUITS 240ML', 
    'بوبانا لوشن مرطب للجسم بالفواكه الاستوائية 240 مل', 
    165.00, 165.00, 'Lotion0', 'جن لمستحضرات التجميل',
    'Specialized_Body_Care', 
    'body_moisturizing_lotion', 
    'Moisturizing tropical fruit scented body lotion.', 
    FALSE
),
(
    127338, 
    'BOBANA BODY SPLASH (GOLDEN HOUR) 250ML ذهبي', 
    'بوبانا بودي سبلاش معطر للجسم جولدن أور 250 مل', 
    190.00, 190.00, 'General Pe', 'جن لمستحضرات التجميل',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Fragrance body splash product outside core cosmeceutical skincare scope.', 
    TRUE
),
(
    127339, 
    'BOBANA BODY SPLASH (GREEN NOISE) 250ML اخضر', 
    'بوبانا بودي سبلاش معطر للجسم جرين نويز 250 مل', 
    190.00, 190.00, 'General Pe', 'جن لمستحضرات التجميل',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Fragrance body splash product outside core cosmeceutical skincare scope.', 
    TRUE
),
(
    127340, 
    'BOBANA BODY SPLASH (OUT OF THE BLUE) 250ML لبني', 
    'بوبانا بودي سبلاش معطر للجسم أوت أوف ذا بلو 250 مل', 
    190.00, 190.00, 'General Pe', 'جن لمستحضرات التجميل',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Fragrance body splash product outside core cosmeceutical skincare scope.', 
    TRUE
),
(
    130812, 
    'BOBANA BODY SPLASH (PINK AT HEART) 250ML', 
    'بوبانا بودي سبلاش معطر للجسم بينك أت هارت 250 مل', 
    190.00, 190.00, 'General Pe', 'جن لمستحضرات التجميل',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Fragrance body splash product outside core cosmeceutical skincare scope.', 
    TRUE
),
(
    127341, 
    'BOBANA BODY SPLASH (PURPLE AROMA) 250ML بنفسج', 
    'بوبانا بودي سبلاش معطر للجسم بيربل أروما 250 مل', 
    190.00, 190.00, 'General Pe', 'جن لمستحضرات التجميل',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Fragrance body splash product outside core cosmeceutical skincare scope.', 
    TRUE
),
(
    121529, 
    'BOBANA CLAY MASK BENTON NOURISH&DETOX 150GM #C#', 
    'بوبانا قناع طمي البنتونيت المغذي والمنقي 150 جرام', 
    107.00, 107.00, 'Other Body', 'جن لمستحضرات التجميل',
    'Skin_Cleansing', 
    'purifying_cleansing_gel', 
    'Detoxifying bentonite clay mask for deep pore purification.', 
    FALSE
),
INSERT INTO cosmeceutical_product_classification_full (
    code, name_en, name_ar, price_1, price_2, category, supplier,
    domain, subcategory, reason, review_required
) VALUES
(
    28739, 
    'BOBANA FACE WASH CHARCOAL 150ML غسول وجه فحم', 
    'بوبانا جل غسول للوجه بالفحم المنشط 150 مل', 
    85.00, 85.00, 'Other Body', 'جن لمستحضرات التجميل',
    'Acne_Oil_Control', 
    'salicylic_acid_exfoliator', 
    'Purifying activated charcoal facial cleansing gel for deep pore cleansing and oil control.', 
    FALSE
),
(
    8544, 
    'BOBANA FACE WASH CHARCOAL 50ML غسول وجه الفحم', 
    'بوبانا جل غسول للوجه بالفحم المنشط 50 مل', 
    35.00, 35.00, 'Facial Sup', 'جن لمستحضرات التجميل',
    'Acne_Oil_Control', 
    'salicylic_acid_exfoliator', 
    'Compact purifying activated charcoal facial cleansing gel.', 
    FALSE
),
(
    24055, 
    'BOBANA FACE WASH HYALURO 150ML غسول وجه هيالورونيك', 
    'بوبانا جل غسول للوجه بالهيالورونيك 150 مل', 
    85.00, 85.00, 'Other Body', 'جن لمستحضرات التجميل',
    'Skin_Cleansing', 
    'soothing_cleansing_gel', 
    'Hydrating facial cleansing gel enriched with Hyaluronic Acid for moisture retention.', 
    FALSE
),
(
    8596, 
    'BOBANA FACE WASH HYALURONIC 50GM غسول وجه هيالوروني', 
    'بوبانا جل غسول للوجه بالهيالورونيك 50 جرام', 
    35.00, 35.00, 'Facial Sup', 'جن لمستحضرات التجميل',
    'Skin_Cleansing', 
    'soothing_cleansing_gel', 
    'Compact hydrating facial cleansing gel with Hyaluronic Acid.', 
    FALSE
),
(
    115385, 
    'BOBANA FACE WASH RETINOL 150ML غسول وجه بالريتينول', 
    'بوبانا جل غسول للوجه بالريتينول 150 مل', 
    85.00, 85.00, 'Other Body', 'جن لمستحضرات التجميل',
    'Anti_Aging_Skin_Rejuvenation', 
    'retinol_anti_aging_serum', 
    'Rejuvenating facial cleansing gel formulated with Retinol to support skin renewal.', 
    FALSE
),
(
    115953, 
    'BOBANA FACE WASH RETINOL 50ML غسول وجه بالريتينول', 
    'بوبانا جل غسول للوجه بالريتينول 50 مل', 
    35.00, 35.00, 'Other Body', 'جن لمستحضرات التجميل',
    'Anti_Aging_Skin_Rejuvenation', 
    'retinol_anti_aging_serum', 
    'Compact anti-aging facial cleansing gel with Retinol.', 
    FALSE
),
(
    8570, 
    'BOBANA FACE WASH VITAMIN C 50ML غسول وجه فيتامين سي', 
    'بوبانا جل غسول للوجه بفيتامين سي 50 مل', 
    35.00, 35.00, 'Facial Sup', 'جن لمستحضرات التجميل',
    'Skin_Cleansing', 
    'brightening_cleansing_gel', 
    'Compact brightening facial cleansing gel enriched with Vitamin C.', 
    FALSE
),
(
    107881, 
    'BOBANA HAIR COND ARGAN OIL 400ML بلسم زيت ارجان', 
    'بوبانا بلسم معالج بزيت الأرجان 400 مل', 
    140.00, 140.00, 'Hair Condit', 'جن لمستحضرات التجميل',
    'Hair_Scalp_Care', 
    'hair_conditioner_balm', 
    'Nourishing and restorative hair conditioner enriched with Argan oil.', 
    FALSE
),
(
    107882, 
    'BOBANA HAIR COND COCONUT OIL 400ML بلسم زيت جوزهند', 
    'بوبانا بلسم مرطب بزيت جوز الهند 400 مل', 
    140.00, 140.00, 'Hair Condit', 'جن لمستحضرات التجميل',
    'Hair_Scalp_Care', 
    'hair_conditioner_balm', 
    'Hydrating hair conditioner infused with Coconut oil.', 
    FALSE
),
(
    107885, 
    'BOBANA HAIR MASK ARGAN OIL 500GM ماسك شعر زيت ارجان', 
    'بوبانا قناع شعر معالج بزيت الأرجان 500 جرام', 
    200.00, 200.00, 'Hair Cream', 'جن لمستحضرات التجميل',
    'Hair_Scalp_Care', 
    'repairing_hair_mask', 
    'Intensive restorative hair mask treatment enriched with Argan oil.', 
    FALSE
),
(
    107887, 
    'BOBANA HAIR MASK COCONUT OIL 500GM ماسك شعر جوز هند', 
    'بوبانا قناع شعر مرطب بزيت جوز الهند 500 جرام', 
    200.00, 200.00, 'Hair Cream', 'جن لمستحضرات التجميل',
    'Hair_Scalp_Care', 
    'nourishing_hair_mask', 
    'Deeply moisturizing hair mask treatment infused with Coconut oil.', 
    FALSE
),
(
    122087, 
    'BOBANA HAND CREAM COCONUT MILK 50ML', 
    'بوبانا كريم مرطب لليدين بحليب جوز الهند 50 مل', 
    60.00, 60.00, 'Hand Crea', 'جن لمستحضرات التجميل',
    'Specialized_Body_Care', 
    'hand_repair_cream', 
    'Nourishing hand cream enriched with coconut milk extract for hand softness.', 
    FALSE
),
(
    134109, 
    'BOBANA LEAVE-IN COND BLACK GARLC 240Mبديل زيت ثوم', 
    'بوبانا بلسم يترك على الشعر بديل الزيت بالثوم الأسود 240 مل', 
    145.00, 145.00, 'Hair Cream', 'جن لمستحضرات التجميل',
    'Hair_Scalp_Care', 
    'hair_oil_replacement', 
    'Leave-in oil replacement conditioner formulated with Black Garlic oil.', 
    FALSE
),
(
    134108, 
    'BOBANA LEAVE-IN COND COCONUT 240Mبديل زيت جوز هند', 
    'بوبانا بلسم يترك على الشعر بديل الزيت بجوز الهند 240 مل', 
    145.00, 145.00, 'Hair Cream', 'جن لمستحضرات التجميل',
    'Hair_Scalp_Care', 
    'hair_oil_replacement', 
    'Leave-in oil replacement conditioner formulated with Coconut oil.', 
    FALSE
),
(
    83150, 
    'BOBANA LEAVE-IN CREAMCOCONUT 200Mكريم جوز الهند', 
    'بوبانا كريم يترك على الشعر بزيت جوز الهند 200 مل', 
    145.00, 145.00, 'Hair Cream', 'جن لمستحضرات التجميل',
    'Hair_Scalp_Care', 
    'hair_conditioner_balm', 
    'Nourishing leave-in hair cream enriched with Coconut oil.', 
    FALSE
),
(
    112482, 
    'BOBANA LIP BALM CHERRY 5.5ML مرطب شفاة كرز', 
    'بوبانا مرطب شفاه بنكهة الكرز 5.5 مل', 
    60.00, 60.00, 'Lip Stick0', 'EGYPT',
    'Lip_Care', 
    'lip_repair_balm', 
    'Moisturizing lip balm stick with cherry flavor.', 
    FALSE
),
(
    112481, 
    'BOBANA LIP BALM HYALURONIC 5.5ML مرطب شفاة', 
    'بوبانا مرطب شفاه بالهيالورونيك 5.5 مل', 
    60.00, 60.00, 'Lip Stick0', 'EGYPT',
    'Lip_Care', 
    'lip_repair_balm', 
    'Hydrating lip balm stick formulated with Hyaluronic Acid.', 
    FALSE
),
(
    50099, 
    'BOBANA MILK MASK MENTHOL 250GMماسك تفتيح وتنظيف', 
    'بوبانا قناع الحليب للتفتيح والتنظيف بالمنتول 250 جرام', 
    65.00, 65.00, 'Skin Care f', 'جن لمستحضرات التجميل',
    'Pigmentation_Skin_Tone', 
    'pigmentation_day_cream', 
    'Refreshing and purifying milk face mask with menthol for skin brightening.', 
    FALSE
),
(
    122082, 
    'BOBANA MILK MASK VITAMIN C 250MLماسك تفتيح وتوحيد', 
    'بوبانا قناع الحليب للتفتيح وتوحيد اللون بفيتامين سي 250 مل', 
    65.00, 65.00, 'Skin Care f', 'جن لمستحضرات التجميل',
    'Pigmentation_Skin_Tone', 
    'anti_pigmentation_serum', 
    'Brightening and tone-evening milk face mask enriched with Vitamin C.', 
    FALSE
),
(
    50102, 
    'BOBANA MILK MASK VITAMIN E 250ML ماسك تفتيح وترطيب', 
    'بوبانا قناع الحليب للتفتيح والترطيب بفيتامين إي 250 مل', 
    65.00, 65.00, 'Skin Care f', 'جن لمستحضرات التجميل',
    'Skin_Moisturization_Barrier', 
    'barrier_repair_hydrator', 
    'Moisturizing and brightening milk face mask enriched with Vitamin E.', 
    FALSE
),
(
    135251, 
    'BOBANA MILK SPA SALT SCRUB 300GM ملح صنفرة حليب بر', 
    'بوبانا ملح سبا مقشر بالحليب 300 جرام', 
    45.00, 45.00, 'Body Fac', 'جن لمستحضرات التجميل',
    'Skin_Cleansing', 
    'purifying_cleansing_gel', 
    'Exfoliating milk spa salt body scrub for skin smoothing.', 
    FALSE
),
(
    83244, 
    'BOBANA MUD MASK SHEA BUTTER 400GM قناع طمي شيا', 
    'بوبانا قناع طمي بزبدة الشيا 400 جرام', 
    75.00, 75.00, 'Body Make', 'جن لمستحضرات التجميل',
    'Skin_Moisturization_Barrier', 
    'hydrating_sheet_mask', 
    'Nourishing and purifying mud mask enriched with shea butter.', 
    FALSE
),
(
    104756, 
    'BOBANA PEEL-OFF FACE MASK GOLD 120GM قناع بالذهب', 
    'بوبانا قناع مقشر للوجه بالذهب 120 جرام', 
    75.00, 75.00, 'Body Face', 'جن لمستحضرات التجميل',
    'Anti_Aging_Skin_Rejuvenation', 
    'firming_radiance_gel', 
    'Illuminating and rejuvenating gold peel-off face mask for radiant glow.', 
    FALSE
),
(
    6139, 
    'BOBANA ROLL-ON DRY FRESH 50ML انتعاش جاف', 
    'بوبانا مزيل عرق رول أون للانتعاش الجاف 50 مل', 
    65.00, 65.00, 'Deoderant', 'جن لمستحضرات التجميل',
    'Specialized_Body_Care', 
    'antiperspirant_deodorant', 
    'Dry-fresh antiperspirant roll-on deodorant for long-lasting odor protection.', 
    FALSE
),
(
    23043, 
    'BOBANA ROLL-ON SOFT GENTLE 50ML نعومه فائقه', 
    'بوبانا مزيل عرق رول أون بنعومة فائقة 50 مل', 
    65.00, 65.00, 'Deoderant', 'جن لمستحضرات التجميل',
    'Specialized_Body_Care', 
    'antiperspirant_deodorant', 
    'Soft and gentle antiperspirant roll-on deodorant for underarm skin care.', 
    FALSE
),
INSERT INTO cosmeceutical_product_classification_full (
    code, name_en, name_ar, price_1, price_2, category, supplier,
    domain, subcategory, reason, review_required
) VALUES
(
    75988, 
    'ALOEKITA CAFFEINE SHAMPOO 200ML', 
    'ألوكيتا كافيين شامبو مقوي للشعر 200 مل', 
    219.00, 219.00, 'COSMO-MI', 'COSMETICS',
    'Hair_Scalp_Care', 
    'anti_hair_loss_shampoo', 
    'Caffeine-infused strengthening hair shampoo designed to stimulate roots and combat hair thinning.', 
    FALSE
),
(
    24822, 
    'ALOEKITA COND HAIR NOURISHING 200MLبلسم مغذي للشعر', 
    'ألوكيتا بلسم مغذي للشعر 200 مل', 
    275.00, 275.00, 'COSMO-MI', 'COSMETICS',
    'Hair_Scalp_Care', 
    'hair_conditioner_balm', 
    'Nourishing hair conditioner formulated to restore moisture and softness.', 
    FALSE
),
(
    93015, 
    'ALOEKITA D - S SHAMPOO 250ML', 
    'ألوكيتا دي إس شامبو معالج لفروة الرأس 250 مل', 
    259.00, 259.00, 'COSMO-MI', 'COSMETICS',
    'Hair_Scalp_Care', 
    'anti_dandruff_shampoo', 
    'Dermatological scalp treatment shampoo formulated to soothe irritation and flakes.', 
    FALSE
),
(
    32422, 
    'ALOEKITA HAIR MASK OMEGA(3.6.9) 200GMماسك ترطيب شع', 
    'ألوكيتا ماسك ترطيب وتغذية الشعر أوميغا (3.6.9) 200 جرام', 
    275.00, 275.00, 'COSMO-MI', 'COSMETICS',
    'Hair_Scalp_Care', 
    'nourishing_hair_mask', 
    'Intensive hair mask treatment enriched with Omega 3, 6, and 9 for deep hydration.', 
    FALSE
),
(
    33831, 
    'ALOEKITA HAIR SPRAY GROWTH 200MLسبراي لنمو الشعر', 
    'ألوكيتا سبراي محفز لنمو الشعر 200 مل', 
    399.00, 399.00, 'COSMO-MI', 'COSMETICS',
    'Hair_Scalp_Care', 
    'scalp_treatment_leave_in', 
    'Hair growth stimulating scalp spray formulated to anchor roots and support density.', 
    FALSE
),
(
    22695, 
    'ALOEKITA SHAMP ANTI-DANDRUFF 200Mشامبو ضد القشرة', 
    'ألوكيتا شامبو ضد القشرة 200 مل', 
    199.00, 199.00, 'COSMO-MI', 'COSMETICS',
    'Hair_Scalp_Care', 
    'anti_dandruff_shampoo', 
    'Anti-dandruff cleansing shampoo formulated to eliminate flakes and purify scalp.', 
    FALSE
),
(
    133824, 
    'ALOEKITA LEAVE IN CREAM 120G كريم للشعر', 
    'ألوكيتا كريم يترك على الشعر 120 جرام', 
    199.00, 199.00, 'COSMO-MI', 'COSMETICS',
    'Hair_Scalp_Care', 
    'hair_conditioner_balm', 
    'Leave-in hair conditioning cream designed for daily styling and moisture protection.', 
    FALSE
),
(
    139752, 
    'ISIS SECALIA BODY LOTION DRY&V.DRY 200ML', 
    'إيسيس فارما سيكاليا لوشن مرطب للجسم للبشرة الجافة وشديدة الجفاف 200 مل', 
    819.00, 819.00, 'COSMO-MI', 'اي تو فارما',
    'Specialized_Body_Care', 
    'body_moisturizing_lotion', 
    'Ultra-rich body moisturizing lotion formulated for dry and very dry skin barrier repair.', 
    FALSE
),
(
    139751, 
    'ISIS SECALIA FACE CREAM 40ML', 
    'إيسيس فارما سيكاليا كريم مرطب للوجه 40 مل', 
    699.00, 699.00, 'COSMO-MI', 'اي تو فارما',
    'Skin_Moisturization_Barrier', 
    'barrier_repair_hydrator', 
    'Nourishing facial moisturizing cream formulated to comfort dry skin barrier.', 
    FALSE
),
(
    139750, 
    'ISIS TEEN DERM A.Z ACNE PRONE 30ML #B#', 
    'إيسيس فارما تين ديرم إيه زي كريم معالج للبشرة المعرضة للحبوب 30 مل', 
    799.00, 799.00, 'COSMO-MI', 'اي تو فارما',
    'Acne_Oil_Control', 
    'acne_spot_treatment', 
    'Targeted corrective cream with Azelaic acid for blemish-prone and acne-prone skin.', 
    FALSE
),
(
    43775, 
    'ISIS TEEN DERM EXFOLIATING CLEANSIG GEL 150ML', 
    'إيسيس فارما تين ديرم جل غسول ومقشر منظف 150 مل', 
    599.00, 599.00, 'COSMO-MI', 'اي تو فارما',
    'Acne_Oil_Control', 
    'salicylic_acid_exfoliator', 
    'Exfoliating and purifying cleansing gel formulated for oily and blemish-prone skin.', 
    FALSE
),
(
    103088, 
    'ISIS TEEN DERM GEL SENSITIV PURIFY OILY 250M', 
    'إيسيس فارما تين ديرم جل منظف ومطهر للبشرة الدهنية والحساسة 250 مل', 
    675.00, 675.00, 'COSMO-MI', 'اي تو فارما',
    'Acne_Oil_Control', 
    'acne_cleansing_gel', 
    'Purifying and cleansing gel tailored for sensitive oily skin.', 
    FALSE
),
(
    27759, 
    'ISIS TEEN DERM GEL SENSITIVE PURIFYING 400M', 
    'إيسيس فارما تين ديرم جل منظف ومطهر للبشرة الحساسة 400 مل', 
    975.00, 975.00, 'COSMO-MI', 'اي تو فارما',
    'Acne_Oil_Control', 
    'acne_cleansing_gel', 
    'Large-size purifying cleansing gel for sensitive blemish-prone skin.', 
    FALSE
),
(
    106604, 
    'ISIS TEEN DERM HYDRA SOOTHING MOIST 40ML', 
    'إيسيس فارما تين ديرم هيدرا كريم مرطب ومهدئ للبشرة 40 مل', 
    715.00, 715.00, 'COSMO-MI', 'اي تو فارما',
    'Skin_Moisturization_Barrier', 
    'lightweight_barrier_moisturizer', 
    'Soothing and moisturizing cream formulated to comfort acne-prone skin undergoing drying treatments.', 
    FALSE
),
(
    101352, 
    'ISIS TEEN DERM K CONCENTRATE GELCREAM 30ML', 
    'إيسيس فارما تين ديرم كي جل كريم مركز لعلاج الشوائب 30 مل', 
    699.00, 699.00, 'COSMO-MI', 'اي تو فارما',
    'Acne_Oil_Control', 
    'acne_spot_treatment', 
    'Concentrated gel-cream for targeting imperfections and blemishes on acne-prone skin.', 
    FALSE
),
(
    38679, 
    'ISIS TILIA 20 BAGS~ تليوز ع', 
    'إيزيس أعشاب تليَّة استرخاء 20 كيس', 
    35.00, 35.00, 'Herbal Tea', 'توس اعشاب',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Herbal tea relaxation infusion outside core cosmeceutical skincare scope.', 
    TRUE
),
(
    2772, 
    'ISIS TILIA 12 BAGS~ تليوز ع', 
    'إيزيس أعشاب تليَّة استرخاء 12 كيس', 
    18.50, 18.50, 'Herbal Tea', 'توس اعشاب',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Herbal tea relaxation infusion outside core cosmeceutical skincare scope.', 
    TRUE
),
(
    92088, 
    'ISIS URELIA 10 CREAM BODY MOISTUR 150ML', 
    'إيسيس فارما أوريليا 10 كريم مرطب للجسم 150 مل', 
    1255.00, 1255.00, 'COSMO-MI', 'اي تو فارما',
    'Specialized_Body_Care', 
    'body_moisturizing_lotion', 
    'Keratolytic body moisturizing cream with 10% urea for dry and scaly skin.', 
    FALSE
),
(
    21660, 
    'ISIS UVEBLOCK SPF 50 DRY TOUCH FLUIDE 40ML', 
    'إيسيس فارما أوفيبلوك فلويد واقي شمس ملمس جاف SPF50 بحجم 40 مل', 
    1025.00, 1025.00, 'COSMO-MI', 'اي تو فارما',
    'Sun_Protection', 
    'mattifying_facial_sunscreen', 
    'Dry-touch facial fluid sunscreen with broad-spectrum SPF50 for combination to oily skin.', 
    FALSE
),
(
    21133, 
    'ISIS UVEBLOCK SPF50 DRY TOUCH LIGHT TINTED FLU 40ML', 
    'إيسيس فارما أوفيبلوك فلويد واقي شمس ملون فاتح ملمس جاف SPF50 بحجم 40 مل', 
    1025.00, 1025.00, 'COSMO-MI', 'اي تو فارما',
    'Sun_Protection', 
    'tinted_facial_sunscreen', 
    'Light-tinted dry-touch facial sunscreen fluid with SPF50.', 
    FALSE
),
(
    49778, 
    'ISIS UVEBLOCK SPF50+ FLUID SNSTV SKN 40ML', 
    'إيسيس فارما أوفيبلوك فلويد واقي شمس للبشرة الحساسة SPF50+ بحجم 40 مل', 
    975.00, 975.00, 'COSMO-MI', 'اي تو فارما',
    'Sun_Protection', 
    'facial_sunscreen_fluid', 
    'Facial fluid sunscreen formulated specifically for sensitive skin with very high SPF50+.', 
    FALSE
),
(
    49777, 
    'ISIS UVEBLOCK SPF50+(M)TINT FLUID SNSTV 40ML', 
    'إيسيس فارما أوفيبلوك فلويد واقي شمس ملون للبشرة الحساسة SPF50+ بحجم 40 مل', 
    975.00, 975.00, 'COSMO-MI', 'اي تو فارما',
    'Sun_Protection', 
    'tinted_facial_sunscreen', 
    'Tinted facial fluid sunscreen for sensitive skin with very high SPF50+ protection.', 
    FALSE
),
(
    49787, 
    'ISIS UVEBLOCK SPRAY KIDS SPF50 SENS SKIN 200M', 
    'إيسيس فارما أوفيبلوك بخاخ واقي شمس للأطفال للبشرة الحساسة SPF50 بحجم 200 مل', 
    1439.00, 1439.00, 'COSMO-MI', 'اي تو فارما',
    'Sun_Protection', 
    'kids_sunscreen_spray', 
    'High-protection sunscreen spray formulated for sensitive children skin.', 
    FALSE
),
(
    25038, 
    'ISIS UVEBLOCK SPRAY SPF50 SENSITIVE SKIN 200M', 
    'إيسيس فارما أوفيبلوك بخاخ واقي شمس للبشرة الحساسة SPF50 بحجم 200 مل', 
    1439.00, 1439.00, 'COSMO-MI', 'اي تو فارما',
    'Sun_Protection', 
    'sunscreen_spray_mist', 
    'Broad-spectrum sunscreen spray formulated for sensitive skin types.', 
    FALSE
),
(
    94193, 
    'ISIS UVEBLOCKSPF50+LOTION SENSITIVE SKIN 100ML', 
    'إيسيس فارما أوفيبلوك لوشن واقي شمس للبشرة الحساسة SPF50+ بحجم 100 مل', 
    1185.00, 1185.00, 'COSMO-MI', 'اي تو فارما',
    'Sun_Protection', 
    'body_sunscreen_lotion', 
    'Sensitive skin protective sunscreen lotion with very high SPF50+ defense.', 
    FALSE
),
(
    115252, 
    'ISIS REGIME TEA LEMON 50BAGS 20% خصم شاي بالليمون', 
    'إيزيس شاي رجيم بالليمون 50 كيس', 
    30.00, 30.00, 'Herbal Tea', 'توس اعشاب',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Dietary herbal tea infusion outside core cosmeceutical skincare scope.', 
    TRUE
),
(
    21485, 
    'ISIS REGIME TEA MINT 50 BAGS شاي رجيم نعناع', 
    'إيزيس شاي رجيم بالنعناع 50 كيس', 
    58.00, 58.00, 'Herbal Tea', 'توس اعشاب',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Dietary herbal tea infusion outside core cosmeceutical skincare scope.', 
    TRUE
),
(
    146630, 
    'ISIS REGIME TEA MINT 50 BAGS شاي رجيم نعناع +ممع هد', 
    'إيزيس شاي رجيم بالنعناع + عرض هدية 50 كيس', 
    52.50, 52.50, 'Herbal Tea', 'توس اعشاب',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Promotional dietary herbal tea bundle outside core cosmeceutical skincare scope.', 
    TRUE
),
(
    24763, 
    'ISIS RUBORIL(SPF50)TINT CREAM EXPERT 40ML ANTI-REDNE', 
    'إيسيس فارما روبوريل كريم إكسبيرت ملون مضاد للاحمرار واقي شمس SPF50 بحجم 40 مل', 
    999.00, 999.00, 'COSMO-MI', 'اي تو فارما',
    'Specialized_Care', 
    'after_sun_soothing_lotion', 
    'Tinted anti-redness expert cream with SPF50 formulated for sensitive rosacea-prone skin.', 
    FALSE
),
(
    72598, 
    'ISIS SECALIA AHA BODY EMOLLIENT SCALYSKIN 200ML', 
    'إيسيس فارما سيكاليا إيه إتش إيه لوشن مرطب ومقشر للجسم للبشرة الجافة 200 مل', 
    1219.00, 1219.00, 'COSMO-MI', 'اي تو فارما',
    'Specialized_Body_Care', 
    'body_moisturizing_lotion', 
    'Exfoliating and moisturizing AHA body emollient for dry and scaly skin.', 
    FALSE
),
(
    133133, 
    'ISIS HIBISCUS-CINNAMON 20 BAGS اورقة كركدية', 
    'إيزيس أعشاب كركدية وقرفة 20 كيس', 
    33.75, 33.75, 'Herbal Tea', 'توس اعشاب',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Herbal tea infusion outside core cosmeceutical skincare scope.', 
    TRUE
),
(
    107166, 
    'ISIS IMMUNE - ENHANCING 20 BAGS~ شاي المناعة', 
    'إيزيس شاي لتعزيز المناعة 20 كيس', 
    35.00, 35.00, 'Herbal Tea', 'توس اعشاب',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Immune-enhancing herbal tea infusion outside core cosmeceutical skincare scope.', 
    TRUE
),
(
    35818, 
    'ISIS LEMON&GINGER 20 SACHET~ليمون وزنجبيل ع', 
    'إيزيس أعشاب ليمون وزنجبيل 20 كيس', 
    35.00, 35.00, 'Herbal Tea', 'توس اعشاب',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Herbal tea infusion outside core cosmeceutical skincare scope.', 
    TRUE
),
(
    90162, 
    'ISIS LEMON&GINGER 12 SACHET~ليمون وزنجبيل ع', 
    'إيزيس أعشاب ليمون وزنجبيل 12 كيس', 
    20.00, 20.00, 'Herbal Tea', 'توس اعشاب',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Herbal tea infusion outside core cosmeceutical skincare scope.', 
    TRUE
),
INSERT INTO cosmeceutical_product_classification_full (
    code, name_en, name_ar, price_1, price_2, category, supplier,
    domain, subcategory, reason, review_required
) VALUES
(
    107023, 
    'ISIS NEOTONE BODY LOTION INTENSIVE BROWNSPOT 100ML', 
    'إيسيس فارما نيوتون لوشن مكثف للجسم لعلاج البقع الداكنة 100 مل', 
    1645.00, 1645.00, 'COSMO-MI', 'اي تو فارما',
    'Pigmentation_Skin_Tone', 
    'anti_pigmentation_serum', 
    'Intensive body lotion formulated with depigmenting actives to treat dark spots and uneven skin tone.', 
    FALSE
),
(
    106867, 
    'ISIS NEOTONE EYE LIGHT CONTOUR 15ML ROLL-ON', 
    'إيسيس فارما نيوتون كريم ومصحح للهالات السوداء للعين رول أون 15 مل', 
    819.00, 819.00, 'COSMO-MI', 'اي تو فارما',
    'Specialized_Care', 
    'eye_contour_care', 
    'Roll-on eye contour corrector designed to reduce dark circles and brighten the eye area.', 
    FALSE
),
(
    107159, 
    'ISIS NEOTONE GEL EXFOLIATING CLEANSING GEL 150ML', 
    'إيسيس فارما نيوتون جل غسول ومقشر منظف ومفتح للبشرة 150 مل', 
    719.00, 719.00, 'COSMO-MI', 'اي تو فارما',
    'Pigmentation_Skin_Tone', 
    'brightening_cleansing_gel', 
    'Exfoliating and brightening cleansing gel formulated to target hyperpigmentation.', 
    FALSE
),
(
    77484, 
    'ISIS NEOTONE RADIANCE SPF50 INTENSIVE FLUIDE 30M', 
    'إيسيس فارما نيوتون راديانس فلويد مكثف ومفتح واقي شمس SPF50 بحجم 30 مل', 
    1285.00, 1285.00, 'COSMO-MI', 'اي تو فارما',
    'Pigmentation_Skin_Tone', 
    'pigmentation_day_cream', 
    'Intensive anti-pigmentation daily fluid with broad-spectrum SPF50 defense.', 
    FALSE
),
(
    117897, 
    'ISIS NEOTONE SENSITIVE INTENSIVE BALM 30ML', 
    'إيسيس فارما نيوتون سنسيتيف بلسم مكثف ومصحح للبشرة الحساسة 30 مل', 
    1025.00, 1025.00, 'COSMO-MI', 'اي تو فارما',
    'Pigmentation_Skin_Tone', 
    'anti_pigmentation_serum', 
    'Intensive spot-correcting balm formulated for sensitive skin prone to hyperpigmentation.', 
    FALSE
),
(
    31610, 
    'ISIS NEOTONE SERUM BROWN SPOTS 30ML', 
    'إيسيس فارما نيوتون سيروم معالج ومزيل للبقع الداكنة 30 مل', 
    1179.00, 1179.00, 'COSMO-MI', 'اي تو فارما',
    'Pigmentation_Skin_Tone', 
    'anti_pigmentation_serum', 
    'Intensive corrective serum designed to eliminate stubborn brown spots and even complexion.', 
    FALSE
),
(
    140311, 
    'ISIS PARSLEY & CELERY 12 BAGS~ كرفس وبقدونس ع', 
    'إيزيس أعشاب كرفس وبقدونس 12 كيس', 
    18.50, 18.50, 'Herbal Tea', 'توس اعشاب',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Herbal tea infusion outside core cosmeceutical skincare scope.', 
    TRUE
),
(
    144631, 
    'ISIS PARSLEY & CELERY 20 BAG~ ع البقدونس والكرف', 
    'إيزيس أعشاب بقدونس وكرفس 20 كيس', 
    40.00, 40.00, 'Herbal Tea', 'توس اعشاب',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Herbal tea infusion outside core cosmeceutical skincare scope.', 
    TRUE
),
(
    113588, 
    'ISIS PARSLEY & CELERY 20 BAG~ ع بجمع علي مخزن رى', 
    'إيزيس أعشاب بقدونس وكرفس 20 كيس', 
    35.00, 35.00, 'Herbal Tea', 'توس اعشاب',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Herbal tea infusion outside core cosmeceutical skincare scope.', 
    TRUE
),
(
    2777, 
    'ISIS PEPPERMINT 12 BAGS~ نعناع', 
    'إيزيس أعشاب نعناع 12 كيس', 
    20.00, 20.00, 'Herbal Tea', 'توس اعشاب',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Herbal tea infusion outside core cosmeceutical skincare scope.', 
    TRUE
),
(
    2779, 
    'ISIS PEPPERMINT 20 BAGS ~ نعناع', 
    'إيزيس أعشاب نعناع 20 كيس', 
    35.00, 35.00, 'Herbal Tea', 'توس اعشاب',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Herbal tea infusion outside core cosmeceutical skincare scope.', 
    TRUE
),
(
    81907, 
    'ISIS PHARMA TEEN DERM AQUA 250ML', 
    'إيسيس فارما تين ديرم أكوا ماء ميسيلار منظف 250 مل', 
    339.00, 339.00, 'COSMO-MI', 'اي تو فارما',
    'Skin_Cleansing', 
    'micellar_cleansing_water', 
    'Purifying micellar cleansing water formulated for oily and blemish-prone skin.', 
    FALSE
),
(
    30252, 
    'ISIS REGIME TEA CINNAMON 50 BAGS شاي رجيم بالقرفة', 
    'إيزيس شاي رجيم بالقرفة 50 كيس', 
    60.00, 60.00, 'Herbal Tea', 'توس اعشاب',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Dietary herbal tea infusion outside core cosmeceutical skincare scope.', 
    TRUE
),
(
    31919, 
    'ISIS REGIME TEA LEMON 50 BAGS شاي بالليمون', 
    'إيزيس شاي رجيم بالليمون 50 كيس', 
    58.00, 58.00, 'Herbal Tea', 'توس اعشاب',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Dietary herbal tea infusion outside core cosmeceutical skincare scope.', 
    TRUE
),
(
    8416, 
    'ISIS FENUGREEK 20 SACHETS~ حلبة ع', 
    'إيزيس أعشاب حلبة 20 كيس', 
    35.00, 35.00, 'Powder0', 'توس اعشاب',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Herbal tea infusion outside core cosmeceutical skincare scope.', 
    TRUE
),
(
    136977, 
    'ISIS GINGER 20 SACHET~ زنجبيل ع', 
    'إيزيس أعشاب زنجبيل 20 كيس', 
    35.00, 35.00, 'Herbal Tea', 'توس اعشاب',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Herbal tea infusion outside core cosmeceutical skincare scope.', 
    TRUE
),
(
    75517, 
    'ISIS GINGER&CINNAMON 12 SACHET~ قرفة بالزنجبيل ع', 
    'إيزيس أعشاب قرفة بالزنجبيل 12 كيس', 
    20.00, 20.00, 'Herbal Tea', 'توس اعشاب',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Herbal tea infusion outside core cosmeceutical skincare scope.', 
    TRUE
),
(
    76299, 
    'ISIS GINGER&CINNAMON 20 SACHET~ قرفة بالزنجبيل ع', 
    'إيزيس أعشاب قرفة بالزنجبيل 20 كيس', 
    35.00, 35.00, 'Herbal Tea', 'توس اعشاب',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Herbal tea infusion outside core cosmeceutical skincare scope.', 
    TRUE
),
(
    108539, 
    'ISIS GLYCO-A MEDIUM PEELING(10%) 30ML', 
    'إيسيس فارما جلايكو إيه كريم مقشر متوسط التركيز (10%) 30 مل', 
    925.00, 925.00, 'COSMO-MI', 'اي تو فارما',
    'Anti_Aging_Skin_Rejuvenation', 
    'retinol_anti_aging_serum', 
    'Medium concentration 10% glycolic acid exfoliating peeling night cream for skin resurfacing.', 
    FALSE
),
(
    139748, 
    'ISIS GLYCO-A BODY PEELING(10%) 200ML', 
    'إيسيس فارما جلايكو إيه لوشن مقشر للجسم (10%) 200 مل', 
    1175.00, 1175.00, 'COSMO-MI', 'اي تو فارما',
    'Specialized_Body_Care', 
    'body_moisturizing_lotion', 
    '10% Glycolic acid body peeling lotion designed to smooth rough texture and renew skin.', 
    FALSE
),
(
    139749, 
    'ISIS GLYCO-A POST PEELING 40ML', 
    'إيسيس فارما جلايكو إيه كريم مهدئ ومرمم بعد التقشير 40 مل', 
    635.00, 635.00, 'COSMO-MI', 'اي تو فارما',
    'Skin_Moisturization_Barrier', 
    'lightweight_barrier_moisturizer', 
    'Soothing and repairing post-peeling cream formulated to comfort skin after chemical exfoliation.', 
    FALSE
),
(
    33388, 
    'ISIS GREEN COFFEE 20 SACHETS قهوة خضراء', 
    'إيزيس قهوة خضراء 20 كيس', 
    93.75, 93.75, 'Powder0', 'توس اعشاب',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Dietary supplement green coffee beverage outside core cosmeceutical skincare scope.', 
    TRUE
),
(
    124668, 
    'ISIS GREEN COFFEE PLUS 100GM بنكه الهيل برطمان', 
    'إيزيس قهوة خضراء ببرطمان بنكهة الهيل 100 جرام', 
    131.25, 131.25, 'GRANULE', 'توس اعشاب',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Dietary supplement green coffee jar outside core cosmeceutical skincare scope.', 
    TRUE
),
(
    124667, 
    'ISIS GREEN COFFEE PLUS 20 SACHETS قهوة خضراء بنكهة', 
    'إيزيس قهوة خضراء بنكهة 20 كيس', 
    121.25, 121.25, 'GRANULE', 'توس اعشاب',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Dietary supplement green coffee sachets outside core cosmeceutical skincare scope.', 
    TRUE
),
(
    41904, 
    'ISIS GREEN TEA WITH MINT 12 BAGS شاي اخضر بالنعناع', 
    'إيزيس شاي أخضر بالنعناع 12 كيس', 
    20.00, 20.00, 'Herbal Tea', 'توس اعشاب',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Herbal tea infusion outside core cosmeceutical skincare scope.', 
    TRUE
),
(
    44122, 
    'ISIS GREEN TEA 12 SACHETS~ شاي اخضر ع', 
    'إيزيس شاي أخضر 12 كيس', 
    23.25, 23.25, 'Herbal Tea', 'توس اعشاب',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Herbal tea infusion outside core cosmeceutical skincare scope.', 
    TRUE
),
(
    75516, 
    'ISIS GREEN TEA 20 BAGS~ شاي اخضر ع', 
    'إيزيس شاي أخضر 20 كيس', 
    36.25, 36.25, 'Herbal Tea', 'توس اعشاب',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Herbal tea infusion outside core cosmeceutical skincare scope.', 
    TRUE
),
(
    73999, 
    'ISIS GREEN TEA WITH MINT 20 BAG~ شاي اخضر بالنعناع', 
    'إيزيس شاي أخضر بالنعناع 20 كيس', 
    35.00, 35.00, 'Herbal Tea', 'توس اعشاب',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Herbal tea infusion outside core cosmeceutical skincare scope.', 
    TRUE
),
(
    112306, 
    'ISIS GUAVA 20 PAGS~ اوراق الجوافة', 
    'إيزيس أعشاب أوراق الجوافة 20 كيس', 
    35.00, 35.00, 'Herbal Tea', 'توس اعشاب',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Herbal tea infusion outside core cosmeceutical skincare scope.', 
    TRUE
),
(
    38232, 
    'ISIS HIBISCUS 20 BAGS~ كركدية ع', 
    'إيزيس أعشاب كركدية 20 كيس', 
    35.00, 35.00, 'Herbal Tea', 'توس اعشاب',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Herbal tea infusion outside core cosmeceutical skincare scope.', 
    TRUE
),
(
    86227, 
    'ISIS HIBISCUS 50 BAGS كركدية', 
    'إيزيس أعشاب كركدية 50 كيس', 
    60.00, 60.00, 'Herbal Tea', 'توس اعشاب',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Herbal tea infusion outside core cosmeceutical skincare scope.', 
    TRUE
),
(
    2776, 
    'ISIS HIBISCUS 12 BAGS~ ع الكركدية', 
    'إيزيس أعشاب كركدية 12 كيس', 
    18.50, 18.50, 'Herbal Tea', 'توس اعشاب',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Herbal tea infusion outside core cosmeceutical skincare scope.', 
    TRUE
),
(
    113587, 
    'ISIS CUMIN LEMON 20 PAC كمون وليمون', 
    'إيزيس أعشاب كمون وليمون 20 كيس', 
    52.50, 52.50, 'Herbal Tea', 'توس اعشاب',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Herbal tea infusion outside core cosmeceutical skincare scope.', 
    TRUE
),
(
    38233, 
    'ISIS ANISE 20 BAGS يانسون ع', 
    'إيزيس أعشاب يانسون 20 كيس', 
    35.00, 35.00, 'Herbal Tea', 'توس اعشاب',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Herbal tea infusion outside core cosmeceutical skincare scope.', 
    TRUE
),
(
    48398, 
    'ISIS ANISE LEMON 12 BAGS ليمون و يانسون', 
    'إيزيس أعشاب ليمون و يانسون 12 كيس', 
    18.15, 18.15, 'Herbal Tea', 'توس اعشاب',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Herbal tea infusion outside core cosmeceutical skincare scope.', 
    TRUE
),
(
    122582, 
    'ISIS ANISE LEMON 20 BAGS ليمون و يانسون', 
    'إيزيس أعشاب ليمون و يانسون 20 كيس', 
    35.00, 35.00, 'Herbal Tea', 'توس اعشاب',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Herbal tea infusion outside core cosmeceutical skincare scope.', 
    TRUE
),
(
    34703, 
    'ISIS ANISE 12 BAGS يانسون ع', 
    'إيزيس أعشاب يانسون 12 كيس', 
    20.00, 20.00, 'Herbal Tea', 'توس اعشاب',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Herbal tea infusion outside core cosmeceutical skincare scope.', 
    TRUE
),
(
    82651, 
    'ISIS ANISE 50 BAGS يانسون ع', 
    'إيزيس أعشاب يانسون 50 كيس', 
    74.25, 74.25, 'Herbal Tea', 'توس اعشاب',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Herbal tea infusion outside core cosmeceutical skincare scope.', 
    TRUE
),
(
    107165, 
    'ISIS ANISE 50 BAGS+IMMUNE - ENHANCING20B #B#', 
    'إيزيس مجموعة أعشاب يانسون 50 كيس + شاي مناعة 20 كيس', 
    36.25, 36.25, 'Herbal Tea', 'توس اعشاب',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Promotional herbal tea bundle outside core cosmeceutical skincare scope.', 
    TRUE
),
(
    133529, 
    'ISIS BARLEY 25 SACHET', 
    'إيزيس أعشاب شعير 25 كيس', 
    70.00, 70.00, 'NA', 'توس اعشاب',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Herbal tea infusion outside core cosmeceutical skincare scope.', 
    TRUE
),
(
    142753, 
    'ISIS BARLEY MIX 12 SACHET', 
    'إيزيس أعشاب شعير مكس 12 كيس', 
    72.50, 72.50, 'NA', 'توس اعشاب',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Herbal tea infusion outside core cosmeceutical skincare scope.', 
    TRUE
),
(
    2758, 
    'ISIS CARAWAY 12 PAGS  كراوية ع', 
    'إيزيس أعشاب كراوية 12 كيس', 
    20.00, 20.00, 'Herbal Tea', 'توس اعشاب',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Herbal tea infusion outside core cosmeceutical skincare scope.', 
    TRUE
),
(
    38234, 
    'ISIS CARAWAY 20 BAGS كراوية ع', 
    'إيزيس أعشاب كراوية 20 كيس', 
    35.00, 35.00, 'Herbal Tea', 'توس اعشاب',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Herbal tea infusion outside core cosmeceutical skincare scope.', 
    TRUE
),
(
    50544, 
    'ISIS CHAMOMILE 12 BAGS كاموميل ع', 
    'إيزيس أعشاب كاموميل بابونج 12 كيس', 
    20.00, 20.00, 'Herbal Tea', 'توس اعشاب',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Herbal tea infusion outside core cosmeceutical skincare scope.', 
    TRUE
),
(
    73124, 
    'ISIS CHAMOMILE 20 BAGS كاموميل ع', 
    'إيزيس أعشاب كاموميل بابونج 20 كيس', 
    35.00, 35.00, 'Herbal Tea', 'توس اعشاب',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Herbal tea infusion outside core cosmeceutical skincare scope.', 
    TRUE
),
(
    2761, 
    'ISIS CINNAMON 12 PAGS قرفة ع', 
    'إيزيس أعشاب قرفة 12 كيس', 
    18.50, 18.50, 'Herbal Tea', 'توس اعشاب',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Herbal tea infusion outside core cosmeceutical skincare scope.', 
    TRUE
),
(
    48746, 
    'ISIS CINNAMON 20 PAGS قرفة ع', 
    'إيزيس أعشاب قرفة 20 كيس', 
    35.00, 35.00, 'Herbal Tea', 'توس اعشاب',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Herbal tea infusion outside core cosmeceutical skincare scope.', 
    TRUE
),
(
    136254, 
    'ISIS CINNAMON APPLE 20 SACHET~ تفاح بالقرفة', 
    'إيزيس أعشاب تفاح بالقرفة 20 كيس', 
    65.00, 65.00, 'Herbal Tea', 'توس اعشاب',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Herbal tea infusion outside core cosmeceutical skincare scope.', 
    TRUE
),
(
    108857, 
    'ISIS DETOX 20 BAGS للدايت', 
    'إيزيس أعشاب ديت็อก للتخلص من السموم 20 كيس', 
    35.00, 35.00, 'Herbal Tea', 'توس اعشاب',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Herbal tea infusion outside core cosmeceutical skincare scope.', 
    TRUE
),
(
    33272, 
    'ISIS FENNEL 20 SACHETS شمر', 
    'إيزيس أعشاب شمر 20 كيس', 
    35.00, 35.00, 'Powder0', 'توس اعشاب',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Herbal tea infusion outside core cosmeceutical skincare scope.', 
    TRUE
),
INSERT INTO cosmeceutical_product_classification_full (
    code, name_en, name_ar, price_1, price_2, category, supplier,
    domain, subcategory, reason, review_required
) VALUES
(
    141943, 
    'MOIST-1 HYDRA BOOST ROUTINE(CLEANSER 200ML+H.A SERUM 30ML+CREAM 100ML)', 
    'مويست-1 روتين هيدرا بوست للترطيب (غسول 200 مل + سيروم هيالورونيك 30 مل + كريم 100 مل)', 
    525.00, 525.00, 'COSMO-MI', 'بيوريكس للأدوية',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Multi-product promotional routine set containing items across different functional domains.', 
    TRUE
),
(
    141945, 
    'MOIST-1 REPAIR&MOIST ROUTINE(MOIST CREAM 100GM+CICA CREAM 50ML)', 
    'مويست-1 روتين الإصلاح والترطيب (كريم مرطب 100 جرام + كريم سيكا 50 مل)', 
    285.00, 285.00, 'COSMO-MI', 'بيوريكس للأدوية',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Multi-product routine bundle containing distinct moisturizing and barrier repair creams.', 
    TRUE
),
(
    138235, 
    'MOIST-1 GEL#ع# ACNE PRONE SKIN 60GM جيل لحب الب', 
    'مويست-1 جل معالج للبشرة المعرضة للحبوب 60 جرام', 
    150.00, 150.00, 'COSMO-MI', 'بيوريكس للأدوية',
    'Acne_Oil_Control', 
    'acne_spot_treatment', 
    'Targeted treatment gel formulated to reduce blemishes on acne-prone skin.', 
    FALSE
),
(
    141944, 
    'MOIST-1 DRY ROUTINE(CLEANSER 200ML+TONER 200ML+CREAM 100ML)', 
    'مويست-1 روتين البشرة الجافة (غسول 200 مل + تونر 200 مل + كريم 100 مل)', 
    490.00, 490.00, 'COSMO-MI', 'بيوريكس للأدوية',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Multi-product dry skin routine kit containing cleanser, toner, and moisturizing cream.', 
    TRUE
),
(
    144450, 
    'MOIST-1 SPRAY SUN LOTION(1+1)FREE 200ML SPF50+', 
    'مويست-1 بخاخ لوشن واقي شمس عرض قطعتين SPF50+ بحجم 200 مل', 
    450.00, 450.00, 'COSMO-MI', 'بيوريكس للأدوية',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Promotional double bundle set (1+1) containing spray sunscreen lotion units.', 
    TRUE
),
(
    135718, 
    'MOIST-1 HYDRAT #ع#FOAM CLEANSER OILY 150ML', 
    'مويست-1 جل غسول رغوي مرطب للبشرة الدهنية 150 مل', 
    225.00, 225.00, 'COSMO-MI', 'بيوريكس للأدوية',
    'Acne_Oil_Control', 
    'acne_cleansing_gel', 
    'Hydrating foaming cleansing gel tailored for oily skin control and cleansing.', 
    FALSE
),
(
    138233, 
    'MOIST-1 CREAM #ع#GEL OILY&COMB SKIN 100GMجيل', 
    'مويست-1 جل كريم مرطب للبشرة الدهنية والمختلطة 100 جرام', 
    220.00, 220.00, 'COSMO-MI', 'بيوريكس للأدوية',
    'Skin_Moisturization_Barrier', 
    'lightweight_barrier_moisturizer', 
    'Lightweight hydrating gel-cream formulated for oily and combination skin.', 
    FALSE
),
(
    122458, 
    'MOIST-1 #ع#TONER 200ML', 
    'مويست-1 لوشن تونر منظف ومرطب للبشرة 200 مل', 
    200.00, 200.00, 'COSMO-MI', 'بيوريكس للأدوية',
    'Skin_Cleansing', 
    'soothing_cleansing_gel', 
    'Cleansing and hydrating facial toner lotion to clarify and prepare skin.', 
    FALSE
),
(
    138236, 
    'MOIST-1 HAND#ع# CREAM DRY&ROUGH 60GM كريم لليد', 
    'مويست-1 كريم مرطب لليدين الجافة والخشنة 60 جرام', 
    120.00, 120.00, 'COSMO-MI', 'بيوريكس للأدوية',
    'Specialized_Body_Care', 
    'hand_repair_cream', 
    'Intensive moisturizing hand cream for dry and rough hand skin repair.', 
    FALSE
),
(
    140800, 
    'MOIST-1 LIP#ع#MOISTURIZER DRY LIPS 15GM', 
    'مويست-1 مرطب شفاه للشفاه الجافة 15 جرام', 
    85.00, 85.00, 'COSMO-MI', 'بيوريكس للأدوية',
    'Lip_Care', 
    'lip_repair_balm', 
    'Nourishing lip moisturizer balm formulated to soothe and repair dry lips.', 
    FALSE
),
(
    116230, 
    'MOIST-1 BABY#ع# NAPPY CREAM 150GM', 
    'مويست-1 كريم مرطب ومحمي للاطفال للحفاظ على الجلد 150 جرام', 
    175.00, 175.00, 'COSMO-MI', 'بيوريكس للأدوية',
    'Specialized_Care', 
    'calming_relief_cream', 
    'Protective baby nappy cream formulated to guard against skin irritation and redness.', 
    FALSE
),
(
    135717, 
    'MOIST-1 CENTELLA #ع#SERUM FACE&NECK 30ML', 
    'مويست-1 سيروم سنتيلا مهدئ ومرمم للوجه والرقبة 30 مل', 
    250.00, 250.00, 'COSMO-MI', 'بيوريكس للأدوية',
    'Skin_Moisturization_Barrier', 
    'barrier_repair_hydrator', 
    'Soothing and repairing Centella Asiatica serum for facial and neck skin barrier recovery.', 
    FALSE
),
(
    121655, 
    'MOIST-1 MILKY#ع# CLEANSER 200GM البشرة العادية', 
    'مويست-1 غسول حليبي منظف وممرطب للبشرة العادية 200 جرام', 
    210.00, 210.00, 'COSMO-MI', 'بيوريكس للأدوية',
    'Skin_Cleansing', 
    'lipid_replenishing_cleanser', 
    'Gentle milky cleansing lotion for normal skin cleansing and hydration.', 
    FALSE
),
(
    135716, 
    'MOIST-1 CICA #ع#CREAM REPAIR 50GM', 
    'مويست-1 كريم سيكا مرمم ومهدئ للبشرة 50 جرام', 
    165.00, 165.00, 'COSMO-MI', 'بيوريكس للأدوية',
    'Skin_Moisturization_Barrier', 
    'barrier_repair_hydrator', 
    'Soothing and repairing Cica cream formulated for compromised skin barrier recovery.', 
    FALSE
),
(
    135719, 
    'MOIST-1 HYALU#ع# ACID SERum FACE&NECK 30ML', 
    'مويست-1 سيروم حمض الهيالورونيك مرطب للوجه والرقبة 30 مل', 
    250.00, 250.00, 'COSMO-MI', 'بيوريكس للأدوية',
    'Skin_Moisturization_Barrier', 
    'barrier_repair_hydrator', 
    'Deeply hydrating Hyaluronic Acid serum for facial and neck moisture replenishment.', 
    FALSE
),
(
    121846, 
    'MOIST-1 BODY#ع# MILK 300ML', 
    'مويست-1 حليب مرطب للجسم 300 مل', 
    300.00, 300.00, 'COSMO-MI', 'بيوريكس للأدوية',
    'Specialized_Body_Care', 
    'body_moisturizing_lotion', 
    'Nourishing body moisturizing milk formulated for soft and hydrated body skin.', 
    FALSE
),
(
    116229, 
    'MOIST-1 WITH #ع#UREA CREAM 100GM برطمان', 
    'مويست-1 كريم مرطب باليوريا ببرطمان 100 جرام', 
    170.00, 170.00, 'COSMO-MI', 'بيوريكس للأدوية',
    'Skin_Moisturization_Barrier', 
    'barrier_repair_hydrator', 
    'Keratolytic and deeply moisturizing urea cream for rough and dry skin care.', 
    FALSE
),
(
    122457, 
    'MOIST-1 #ع#CREAM 100GM كريم مرطب عالي التترك', 
    'مويست-1 كريم مرطب عالي التركيز 100 جرام', 
    180.00, 180.00, 'COSMO-MI', 'بيوريكس للأدوية',
    'Skin_Moisturization_Barrier', 
    'barrier_repair_hydrator', 
    'High-concentration rich moisturizing cream for intense barrier replenishment.', 
    FALSE
),
(
    136630, 
    'MOIST-1 #ع#SPRAY SUN LOTION SPF50+ 200ML', 
    'مويست-1 بخاخ لوشن واقي شمس SPF50+ بحجم 200 مل', 
    450.00, 450.00, 'COSMO-MI', 'بيوريكس للأدوية',
    'Sun_Protection', 
    'sunscreen_spray_mist', 
    'Broad-spectrum spray sunscreen lotion with very high SPF50+ protection.', 
    FALSE
),
(
    120950, 
    'MOIST CODE H.A HYALURONIC ACID 0.01 MOUTH SPRAY 60', 
    'مويست كود بخاخ فموي بحمض الهيالورونيك 0.01 بحجم 60 مل', 
    60.00, 60.00, 'TOPICAL', 'PURITY PHARMA',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Oral mouth spray product outside core cosmeceutical skincare scope.', 
    TRUE
),
INSERT INTO cosmeceutical_product_classification_full (
    code, name_en, name_ar, price_1, price_2, category, supplier,
    domain, subcategory, reason, review_required
) VALUES
(
    45426, 
    'PANTENE COND HAIR FALL 180ML ضد التساقط', 
    'بانتين بلسم معالج ومضاد لتساقط الشعر 180 مل', 
    162.07, 162.07, 'Hair Shamp', 'P&G COSMETICS',
    'Hair_Scalp_Care', 
    'hair_conditioner_balm', 
    'Anti-hair fall conditioning balm formulated to strengthen hair strands.', 
    FALSE
),
(
    140441, 
    'PANTENE COND MILKY 180ML ميلكي عناية بالشعر التالف', 
    'بانتين بلسم ميلكي معالج للشعر التالف 180 مل', 
    161.71, 161.71, 'Hair Condit', 'P&G COSMETICS',
    'Hair_Scalp_Care', 
    'hair_conditioner_balm', 
    'Milky repairing conditioner for damaged hair care.', 
    FALSE
),
(
    140440, 
    'PANTENE COND MOIST RENEWAL 360ML عناية مرطبة', 
    'بانتين بلسم عناية مرطبة ومجددة للشعر 360 مل', 
    218.48, 218.48, 'Hair Condit', 'P&G COSMETICS',
    'Hair_Scalp_Care', 
    'hair_conditioner_balm', 
    'Moisture renewal hair conditioning balm for dry hair hydration.', 
    FALSE
),
(
    50270, 
    'PANTENE COND SMOOTH &SILKY 180ML انسيابي وحريري', 
    'بانتين بلسم لمنح الشعر مظهر انسيابي وحريري 180 مل', 
    162.07, 162.07, 'Hair Shamp', 'P&G COSMETICS',
    'Hair_Scalp_Care', 
    'hair_conditioner_balm', 
    'Smoothing and silky hair conditioner for frizz control.', 
    FALSE
),
(
    138545, 
    'PANTENE HAIR OIL GOOD BYE FRIZZ 275ML للتحكم في تظا', 
    'بانتين بديل الزيت ومضاد لتطاير الشعر 275 مل', 
    210.00, 210.00, 'Hair Oil0', 'P&G COSMETICS',
    'Hair_Scalp_Care', 
    'hair_oil_replacement', 
    'Frizz-control leave-in oil replacement cream for smooth hair.', 
    FALSE
),
(
    138544, 
    'PANTENE HAIR OIL MILKY 180ML ميلكي', 
    'بانتين بديل الزيت ميلكي لتغذية الشعر 180 مل', 
    163.00, 163.00, 'Hair Oil0', 'P&G COSMETICS',
    'Hair_Scalp_Care', 
    'hair_oil_replacement', 
    'Milky nourishing leave-in oil replacement treatment.', 
    FALSE
),
(
    109192, 
    'PANTENE HAIR OIL MOISTURE RENEWAL 275ML عناية مرطبة', 
    'بانتين بديل الزيت عناية مرطبة ومجددة للشعر 275 مل', 
    210.00, 210.00, 'Hair Oil0', 'P&G COSMETICS',
    'Hair_Scalp_Care', 
    'hair_oil_replacement', 
    'Moisture renewal leave-in oil replacement cream.', 
    FALSE
),
(
    75744, 
    'PANTENE HAIR OIL REPLACEMENT HAIR FALL 180ML تساقط', 
    'بانتين بديل الزيت معالج ومضاد لتساقط الشعر 180 مل', 
    163.00, 163.00, 'Body Shan', 'P&G COSMETICS',
    'Hair_Scalp_Care', 
    'hair_oil_replacement', 
    'Anti-hair fall strengthening leave-in oil replacement cream.', 
    FALSE
),
(
    127689, 
    'PANTENE SHAMPOO SMOOTH SILKY 600ML', 
    'بانتين شامبو لمنح الشعر مظهر انسيابي وحريري 600 مل', 
    282.20, 282.20, 'Hair Shamp', 'P&G COSMETICS',
    'Hair_Scalp_Care', 
    'smoothing_hair_shampoo', 
    'Large-size smoothing and silky cleansing hair shampoo.', 
    FALSE
),
(
    108680, 
    'PANTENE HAIR OIL REPLACEMENT DAILY CARE 275ML صحي وتنظيف', 
    'بانتين بديل الزيت للعناية التنظيفية اليومية 275 مل', 
    218.48, 218.48, 'Hair Oil0', 'P&G COSMETICS',
    'Hair_Scalp_Care', 
    'hair_oil_replacement', 
    'Daily care nourishing leave-in oil replacement treatment.', 
    FALSE
),
(
    108681, 
    'PANTENE HAIR OIL REPLACEMENT HAIR FALL 275ML تساقط', 
    'بانتين بديل الزيت معالج ومضاد لتساقط الشعر 275 مل', 
    218.48, 218.48, 'Hair Oil0', 'P&G COSMETICS',
    'Hair_Scalp_Care', 
    'hair_oil_replacement', 
    'Medium-size anti-hair fall leave-in oil replacement cream.', 
    FALSE
),
(
    53246, 
    'PANTENE OIL REPLACMENT SMOOTH SILKY 180M بديل زيت', 
    'بانتين بديل الزيت لمنح الشعر مظهر انسيابي وحريري 180 مل', 
    168.16, 168.16, 'Hair Oil0', 'P&G COSMETICS',
    'Hair_Scalp_Care', 
    'hair_oil_replacement', 
    'Smoothing leave-in oil replacement cream for frizz control.', 
    FALSE
),
(
    88998, 
    'PANTENE SHAMPOO ANTI- HAIR FALL 1000ML تساقط', 
    'بانتين شامبو معالج ومضاد لتساقط الشعر 1000 مل', 
    477.45, 477.45, 'Hair Shamp', 'P&G COSMETICS',
    'Hair_Scalp_Care', 
    'anti_hair_loss_shampoo', 
    'Large family-size anti-hair fall reinforcing shampoo.', 
    FALSE
),
(
    140438, 
    'PANTENE SHAMPOO COLOR HAIR REPAIR 400ML عناية بالشعر', 
    'بانتين شامبو معالج ومحافظ على الشعر المصبوغ 400 مل', 
    218.48, 218.48, 'Hair Shamp', 'P&G COSMETICS',
    'Hair_Scalp_Care', 
    'repairing_hair_shampoo', 
    'Color-protecting and repairing hair shampoo.', 
    FALSE
),
(
    48678, 
    'PANTENE SHAMPOO SMOOTH SILKY 1000ML حريري', 
    'بانتين شامبو لمنح الشعر مظهر انسيابي وحريري 1000 مل', 
    477.45, 477.45, 'Hair Shamp', 'P&G COSMETICS',
    'Hair_Scalp_Care', 
    'smoothing_hair_shampoo', 
    'Large family-size smoothing anti-frizz hair shampoo.', 
    FALSE
),
(
    48887, 
    'PANTENE SHAMPOO&CON DAILY CARE 1000ML صحي وتنظيف', 
    'بانتين شامبو وبلسم للعناية التنظيفية اليومية 1000 مل', 
    477.45, 477.45, 'Hair Shamp', 'P&G COSMETICS',
    'Hair_Scalp_Care', 
    'nourishing_hair_shampoo', 
    'Large family-size daily care shampoo and conditioner formula.', 
    FALSE
),
(
    48102, 
    'PANTENE SHAMPOO+COND DAILYCARE 200ML وتنظيف', 
    'بانتين شامبو وبلسم للعناية التنظيفية اليومية 200 مل', 
    114.33, 114.33, 'Hair Shamp', 'P&G COSMETICS',
    'Hair_Scalp_Care', 
    'nourishing_hair_shampoo', 
    'Daily care cleansing shampoo and conditioner.', 
    FALSE
),
(
    137065, 
    'PANTENE COND HAIR FALL 360ML تساقط', 
    'بانتين بلسم معالج ومضاد لتساقط الشعر 360 مل', 
    218.48, 218.48, 'Hair Condit', 'P&G COSMETICS',
    'Hair_Scalp_Care', 
    'hair_conditioner_balm', 
    'Medium-size anti-hair fall strengthening conditioner.', 
    FALSE
),
(
    119463, 
    'CLARY BOOSTER SHOT PROCAPIL 5% 30ML', 
    'كلاري بوستر شوت سيروم مركز معالج لتساقط الشعر 5% بروكابيل بحجم 30 مل', 
    500.00, 500.00, 'COSMO-MI', 'PARKVILLE PHARM',
    'Hair_Scalp_Care', 
    'scalp_treatment_leave_in', 
    'Concentrated booster shot serum with 5% Procapil to combat hair loss and stimulate growth.', 
    FALSE
),
(
    25414, 
    'CLARY CONDITIONER HAIR DRY&DAMAGED 300ML', 
    'كلاري بلسم مغذي ومعالج للشعر الجاف والتالف 300 مل', 
    345.00, 345.00, 'COSMO-MI', 'PARKVILLE PHARM',
    'Hair_Scalp_Care', 
    'hair_conditioner_balm', 
    'Nourishing and repairing hair conditioner for dry and damaged strands.', 
    FALSE
),
(
    112223, 
    'CLARY FRESH SCALP PROCAPIL SCRUB 300ML', 
    'كلاري فرش اسكالب مقشر ومعالج لفروة الرأس 300 مل', 
    390.00, 390.00, 'COSMO-MI', 'PARKVILLE PHARM',
    'Hair_Scalp_Care', 
    'scalp_treatment_leave_in', 
    'Scalp exfoliating treatment scrub with Procapil for follicle purification.', 
    FALSE
),
(
    1524, 
    'CLARY HAIR MASK DRY&DAMAGE HAIR 300ML', 
    'كلاري قناع معالج ومغذي للشعر الجاف والتالف 300 مل', 
    380.00, 380.00, 'COSMO-MI', 'PARKVILLE PHARM',
    'Hair_Scalp_Care', 
    'repairing_hair_mask', 
    'Intensive repairing hair mask treatment for dry and damaged hair fiber.', 
    FALSE
),
(
    82043, 
    'CLARY HAIR MIST HYDRATING 200ML', 
    'كلاري معطر وبخاخ مرطب للشعر 200 مل', 
    200.00, 200.00, 'COSMO-MI', 'PARKVILLE PHARM',
    'Hair_Scalp_Care', 
    'scalp_treatment_leave_in', 
    'Hydrating hair mist spray for moisture replenishment and freshness.', 
    FALSE
),
(
    25552, 
    'CLARY HAIR SERUM INTENSIVE REPAIR 100M سيروم للشعر', 
    'كلاري سيروم مكثف ومصلح للشعر 100 مل', 
    375.00, 375.00, 'COSMO-MI', 'PARKVILLE PHARM',
    'Hair_Scalp_Care', 
    'nourishing_hair_serum', 
    'Intensive repair hair serum for split ends and strand smoothing.', 
    FALSE
),
(
    40582, 
    'CLARY HAIR WATER KERATIN SMOOTH 200ML', 
    'كلاري ماء معالج ومثبت للشعر بالكيراتين 200 مل', 
    300.00, 300.00, 'COSMO-MI', 'PARKVILLE PHARM',
    'Hair_Scalp_Care', 
    'scalp_treatment_leave_in', 
    'Keratin-infused smoothing hair treatment water.', 
    FALSE
),
(
    127709, 
    'CLARY LEAVE-IN CREAM 300GM +HAIR WATER 200MLعرض', 
    'كلاري مجموعة كريم يترك على الشعر 300 جرام + ماء شعر 200 مل', 
    517.50, 517.50, 'COSMO-MI', 'PARKVILLE PHARM',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Promotional combo bundle set combining leave-in cream and hair treatment water.', 
    TRUE
),
(
    120733, 
    'CLARY LEAVE-IN CREAM WITH PROCAPIL 300GM', 
    'كلاري كريم يترك على الشعر بالبروكابيل 300 جرام', 
    340.00, 340.00, 'COSMO-MI', 'PARKVILLE PHARM',
    'Hair_Scalp_Care', 
    'hair_conditioner_balm', 
    'Leave-in conditioning cream formulated with Procapil for root reinforcement.', 
    FALSE
),
(
    127706, 
    'CLARY SHAMPO DRY 300ML +HAIR WATER 200ML عرض', 
    'كلاري مجموعة شامبو للشعر الجاف 300 مل + ماء شعر 200 مل', 
    450.00, 450.00, 'COSMO-MI', 'PARKVILLE PHARM',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Promotional combo bundle set combining shampoo and hair water.', 
    TRUE
),
(
    127711, 
    'CLARY SHAMPOO DRY 300ML +HAIR MIST 200MLعرض', 
    'كلاري مجموعة شامبو للشعر الجاف 300 مل + معطر شعر 200 مل', 
    397.50, 397.50, 'COSMO-MI', 'PARKVILLE PHARM',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Promotional combo bundle set combining shampoo and hair mist.', 
    TRUE
),
(
    36137, 
    'CLARY SHAMPOO HAIR FALL CONTROL DRY& DAMAGED 300ML', 
    'كلاري شامبو متحكم بالتساقط للشعر الجاف والتالف 300 مل', 
    330.00, 330.00, 'COSMO-MI', 'PARKVILLE PHARM',
    'Hair_Scalp_Care', 
    'anti_hair_loss_shampoo', 
    'Anti-hair fall control cleansing shampoo tailored for dry and damaged hair.', 
    FALSE
),
(
    138481, 
    'CLARY SPRAY FRESH SCALP 120ML', 
    'كلاري فرش اسكالب بخاخ مهدئ ومنعش لفروة الرأس 120 مل', 
    320.00, 320.00, 'COSMO-MI', 'PARKVILLE PHARM',
    'Hair_Scalp_Care', 
    'scalp_treatment_leave_in', 
    'Soothing and refreshing scalp spray treatment for irritation relief.', 
    FALSE
),
(
    135049, 
    'CLARY SPRAY HAIR FALL CONTROL 200ML', 
    'كلاري بخاخ معالج ومقاوم لتساقط الشعر 200 مل', 
    450.00, 450.00, 'COSMO-MI', 'PARKVILLE PHARM',
    'Hair_Scalp_Care', 
    'scalp_treatment_leave_in', 
    'Anti-hair fall treatment spray designed to strengthen hair roots.', 
    FALSE
),
(
    110097, 
    'CLARY SPRAY HAIR MIST SPF50+ 120ML', 
    'كلاري بخاخ ومعطر حماية للشعر SPF50+ بحجم 120 مل', 
    320.00, 320.00, 'COSMO-MI', 'PARKVILLE PHARM',
    'Hair_Scalp_Care', 
    'scalp_treatment_leave_in', 
    'Protective hair mist spray with SPF50+ sun defense for hair fibers.', 
    FALSE
),
(
    144432, 
    'CLARY (ANTI-DAND SHAMP 300ML +FRESH SCALP SCRUB 300ML) ضد القشرة', 
    'كلاري مجموعة شامبو ضد القشرة 300 مل + مقشر فروة الرأس 300 مل', 
    520.00, 520.00, 'COSMO-MI', 'PARKVILLE PHARM',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Promotional combo bundle set combining anti-dandruff shampoo and scalp scrub.', 
    TRUE
),
(
    131281, 
    'CLARY (HAIR MIST 200ML + SERUM 100ML)  عرض', 
    'كلاري مجموعة معطر شعر 200 مل + سيروم 100 مل', 
    413.00, 413.00, 'COSMO-MI', 'PARKVILLE PHARM',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Promotional combo bundle set combining hair mist and serum.', 
    TRUE
),
(
    131275, 
    'CLARY (SHAMPOO 300ML +HAIR MASK 300ML)', 
    'كلاري مجموعة شامبو 300 مل + ماسك شعر 300 مل', 
    532.51, 532.51, 'COSMO-MI', 'PARKVILLE PHARM',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Promotional combo bundle set combining shampoo and hair mask.', 
    TRUE
),
(
    72572, 
    'PANTENE COND MILKY 360ML ميلكي', 
    'بانتين بلسم ميلكي معالج للشعر 360 مل', 
    218.48, 218.48, 'Hair Condit', 'P&G COSMETICS',
    'Hair_Scalp_Care', 
    'hair_conditioner_balm', 
    'Medium-size milky nourishing hair conditioner.', 
    FALSE
),
(
    140439, 
    'PANTENE COND SMOOTH&SILKY 360ML انسيابي وحريري', 
    'بانتين بلسم لمنح الشعر مظهر انسيابي وحريري 360 مل', 
    218.48, 218.48, 'Hair Condit', 'P&G COSMETICS',
    'Hair_Scalp_Care', 
    'hair_conditioner_balm', 
    'Medium-size smoothing anti-frizz hair conditioner.', 
    FALSE
),
(
    107676, 
    'PANTENE HAIR OIL REPLACEMENT MILKY 275ML ميلكي', 
    'بانتين بديل الزيت ميلكي لتغذية الشعر 275 مل', 
    218.48, 218.48, 'Hair Oil0', 'P&G COSMETICS',
    'Hair_Scalp_Care', 
    'hair_oil_replacement', 
    'Milky nourishing leave-in oil replacement cream.', 
    FALSE
),
(
    47772, 
    'PANTENE SHAMPOO MILKY 200ML ميلكي', 
    'بانتين شامبو ميلكي للشعر التالف 200 مل', 
    114.33, 114.33, 'Hair Shamp', 'P&G COSMETICS',
    'Hair_Scalp_Care', 
    'repairing_hair_shampoo', 
    'Milky repairing cleansing shampoo for damaged hair.', 
    FALSE
),
(
    127686, 
    'PANTENE SHAMPOO MILKY 600ML ميلكي', 
    'بانتين شامبو ميلكي للشعر التالف 600 مل', 
    282.20, 282.20, 'Hair Shamp', 'P&G COSMETICS',
    'Hair_Scalp_Care', 
    'repairing_hair_shampoo', 
    'Large-size milky repairing cleansing hair shampoo.', 
    FALSE
),
(
    88573, 
    'PANTENE SHAMPOO SMOOTH&SILKY 400ML انسيابي وحريري', 
    'بانتين شامبو لمنح الشعر مظهر انسيابي وحريري 400 مل', 
    216.30, 216.30, 'Hair Shamp', 'P&G COSMETICS',
    'Hair_Scalp_Care', 
    'smoothing_hair_shampoo', 
    'Smoothing and silky cleansing hair shampoo.', 
    FALSE
),
(
    85017, 
    'PANTENE SHAMPOO&COND DAILY CARE 400ML صحي وتنظيف', 
    'بانتين شامبو وبلسم للعناية التنظيفية اليومية 400 مل', 
    216.30, 216.30, 'Hair Shamp', 'P&G COSMETICS',
    'Hair_Scalp_Care', 
    'nourishing_hair_shampoo', 
    'Daily care 2-in-1 cleansing shampoo and conditioner formula.', 
    FALSE
),
(
    48101, 
    'PANTENE SHAMPOO MILKY 400ML ميلكي', 
    'بانتين شامبو ميلكي للشعر التالف 400 مل', 
    216.30, 216.30, 'Hair Shamp', 'P&G COSMETICS',
    'Hair_Scalp_Care', 
    'repairing_hair_shampoo', 
    'Milky repairing hair shampoo for damaged strands.', 
    FALSE
),
(
    6066, 
    'PANTENE SHAMPOO SMOOTH&SILKY 200ML انسيابي حريري', 
    'بانتين شامبو لمنح الشعر مظهر انسيابي وحريري 200 مل', 
    114.33, 114.33, 'Hair Shamp', 'P&G COSMETICS',
    'Hair_Scalp_Care', 
    'smoothing_hair_shampoo', 
    'Smoothing anti-frizz daily cleansing shampoo.', 
    FALSE
),
(
    107673, 
    'PANTENE HAIR OIL REPLACEMENT SMOOTH 275ML انسيابي وحريري', 
    'بانتين بديل الزيت لمنح الشعر مظهر انسيابي وحريري 275 مل', 
    218.48, 218.48, 'Hair Oil0', 'P&G COSMETICS',
    'Hair_Scalp_Care', 
    'hair_oil_replacement', 
    'Smoothing leave-in oil replacement cream for frizz control.', 
    FALSE
),
INSERT INTO cosmeceutical_product_classification_full (
    code, name_en, name_ar, price_1, price_2, category, supplier,
    domain, subcategory, reason, review_required
) VALUES
(
    133522, 
    'CLARY ANTI-DANDRUFF HAIR SHAMPO 300ML ضد القشر', 
    'كلاري شامبو ضد القشرة ومعالج لفروة الرأس 300 مل', 
    350.00, 350.00, 'COSMO-MI', 'PARKVILLE PHARM',
    'Hair_Scalp_Care', 
    'anti_dandruff_shampoo', 
    'Anti-dandruff scalp treatment shampoo formulated to control flakes and clarify the scalp.', 
    FALSE
),
(
    131279, 
    'CLARY ( HAIR MASK 300ML + HAIR WATER 200ML) عرض', 
    'كلاري مجموعة ماسك شعر 300 مل + ماء شعر 200 مل', 
    533.00, 533.00, 'COSMO-MI', 'PARKVILLE PHARM',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Promotional combo kit combining hair mask and hair water treatments.', 
    TRUE
),
(
    131280, 
    'CLARY ( SHAMPO 300ML + SERUM 100ML) خصم 25%', 
    'كلاري مجموعة شامبو 300 مل + سيروم 100 مل', 
    529.01, 529.01, 'COSMO-MI', 'PARKVILLE PHARM',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Promotional combo kit combining shampoo and hair serum.', 
    TRUE
),
(
    131278, 
    'CLARY (COND 300ML + HAIR MASK 300ML) ', 
    'كلاري مجموعة بلسم 300 مل + ماسك شعر 300 مل', 
    544.00, 544.00, 'COSMO-MI', 'PARKVILLE PHARM',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Promotional combo kit combining conditioner and hair mask.', 
    TRUE
),
(
    131708, 
    'CLARY (HAIR MIST SPF50 120ML +SERUM 100ML) عرض', 
    'كلاري مجموعة بخاخ حماية شعر 120 مل + سيروم 100 مل', 
    521.00, 521.00, 'COSMO-MI', 'PARKVILLE PHARM',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Promotional combo kit combining protective hair mist and hair serum.', 
    TRUE
),
(
    131282, 
    'CLARY (LEAVE IN CREAM 300ML +HAIR MIST 200ML ) عرض', 
    'كلاري مجموعة كريم يترك على الشعر 300 مل + معطر شعر 200 مل', 
    405.00, 405.00, 'COSMO-MI', 'PARKVILLE PHARM',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Promotional combo kit combining leave-in cream and hair mist.', 
    TRUE
),
(
    127705, 
    'CLARY (SHAMPO 300ML +COND 300ML +MASK DRY 300ML ) عرض', 
    'كلاري مجموعة شامبو 300 مل + بلسم 300 مل + ماسك للشعر الجاف 300 مل', 
    791.00, 791.00, 'COSMO-MI', 'PARKVILLE PHARM',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Promotional 3-step routine bundle containing shampoo, conditioner, and dry hair mask.', 
    TRUE
),
(
    131274, 
    'CLARY (SHAMPOO 300ML +COND 300ML  ) DRY&DAMAGE HAIR', 
    'كلاري مجموعة شامبو 300 مل + بلسم 300 مل للشعر الجاف والتالف', 
    506.00, 506.00, 'COSMO-MI', 'PARKVILLE PHARM',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Promotional combo bundle set combining shampoo and conditioner.', 
    TRUE
),
(
    44593, 
    'VEET FACE WAX STRIP SENSITIVE SKIN(RB) 20PCS وجه', 
    'فيت شرائح شمعية لإزالة شعر الوجه للبشرة الحساسة 20 قطعة', 
    107.80, 107.80, 'Depilation', 'RICKETTS COSMET',
    'Specialized_Care', 
    'hair_removal_strips', 
    'Facial wax strips designed for delicate and sensitive skin hair removal.', 
    FALSE
),
(
    125644, 
    'VEET NORMAL SKIN CREAM HAIR REMOVE 100ML (1+1)%15 خصم', 
    'فيت كريم لإزالة الشعر للبشرة العادية عرض قطعتين 100 مل', 
    130.00, 130.00, 'Skin Scrub', 'RICKETTS COSMET',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Promotional double bundle set (1+1) containing hair removal creams.', 
    TRUE
),
(
    79250, 
    'VEET NORMAL SKIN CREAM HAIR REMOVAL 100ML(RB)', 
    'فيت كريم إزالة الشعر للبشرة العادية 100 مل', 
    91.43, 91.43, 'Skin Scrub', 'RICKETTS COSMET',
    'Specialized_Care', 
    'depilatory_cream', 
    'Depilatory hair removal cream formulated for normal skin types.', 
    FALSE
),
(
    51109, 
    'VEET WAX STRIPS BIKINI&UNDER ARM(RB) 16PCS بيكيني', 
    'فيت شرائح شمعية لمنطقة البيكيني وتحت الإبط 16 قطعة', 
    98.00, 98.00, 'Depilation', 'RICKETTS COSMET',
    'Specialized_Care', 
    'hair_removal_strips', 
    'Targeted wax strips designed for sensitive bikini and underarm hair removal.', 
    FALSE
),
(
    79806, 
    'VEETA WAX WIPES FOR ALL WOMAN مناديل شمع', 
    'فيت مناديل منظفة بعد الشمع 30 قطعة', 
    30.00, 30.00, 'Depilation', 'RICKETTS COSMET',
    'Specialized_Care', 
    'post_depilatory_wipes', 
    'Post-depilatory finishing wipes designed to clean wax residue and soothe skin.', 
    FALSE
),
(
    79251, 
    'VEET CREAM SENSITIVE HAIR REMOVAL 100M(RB)', 
    'فيت كريم لإزالة الشعر للبشرة الحساسة 100 مل', 
    91.43, 91.43, 'Skin Scrub', 'RICKETTS COSMET',
    'Specialized_Care', 
    'depilatory_cream', 
    'Gentle depilatory hair removal cream formulated for sensitive skin.', 
    FALSE
),
(
    105925, 
    'VEET SENSITIVE SKIN WAX STRIP 12PCS بشرة حاسة جسم', 
    'فيت شرائح شمعية لإزالة شعر الجسم للبشرة الحساسة 12 قطعة', 
    113.19, 113.19, 'Depilation', 'RICKETTS COSMET',
    'Specialized_Care', 
    'hair_removal_strips', 
    'Body hair removal wax strips specially formulated for sensitive skin.', 
    FALSE
),
(
    87722, 
    'HERO BABY PRUNES PUREE 125G 6+MONTHS برقوق مهروس~', 
    'هيرو بيبي طعام أطفال برقوق مهروس 125 جرام', 
    45.00, 45.00, 'Ready Bab', 'هيرو',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Baby food puree product outside core cosmeceutical skincare scope.', 
    TRUE
),
(
    116842, 
    'HERO BABY RICE CEREAL 150G 6+MONTHS وجبة ح1 بدون حل', 
    'هيرو بيبي وجبة سيريال أرز للأطفال بدون حليب 150 جرام', 
    75.00, 75.00, 'Ready Bab', 'هيرو',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Baby cereal food product outside core cosmeceutical skincare scope.', 
    TRUE
),
(
    146429, 
    'HERO BABY RICE CEREAL 300G 6+MONTHS ح1 بدون حليب', 
    'هيرو بيبي وجبة سيريال أرز للأطفال بدون حليب 300 جرام', 
    130.00, 130.00, 'Ready Bab', 'هيرو',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Baby cereal food product outside core cosmeceutical skincare scope.', 
    TRUE
),
(
    125107, 
    'HERO BABY WHEAT FIRST SPOON 150G 6+MONTHS  مدعم بالحد', 
    'هيرو بيبي وجبة سيريال قمح للأطفال مدعم بالحديد 150 جرام', 
    75.00, 75.00, 'Powder0', 'هيرو',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Baby cereal food product outside core cosmeceutical skincare scope.', 
    TRUE
),
(
    73927, 
    'HERO BABY WHOLE MEAL RICE 120G 9+MONTHS ارز بالفراح', 
    'هيرو بيبي وجبة أرز بالدجاج للأطفال 120 جرام', 
    45.00, 45.00, 'Ready Bab', 'هيرو',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Baby food meal product outside core cosmeceutical skincare scope.', 
    TRUE
),
(
    79274, 
    'HERO BABY YOGHURT PEAR MEAL 120G 6+MONTHS كمثرى وزبادي', 
    'هيرو بيبي وجبة كمثرى وزبادي للأطفال 120 جرام', 
    45.00, 45.00, 'Ready Bab', 'هيرو',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Baby food meal product outside core cosmeceutical skincare scope.', 
    TRUE
),
(
    108310, 
    'HERO BABY APPLE BANANA PUREE 100G 6+MONTHS #B# تفاح وموز', 
    'هيرو بيبي طعام أطفال تفاح وموز مهروس 100 جرام', 
    49.00, 49.00, 'Ready Bab', 'هيرو',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Baby food puree product outside core cosmeceutical skincare scope.', 
    TRUE
),
(
    76208, 
    'HERO BABY 8CEREALS&FRUITS+MILK 150G 6+MONTHS صباح الخير 8حبوب وفواكة م', 
    'هيرو بيبي وجبة سيريال 8 حبوب وفواكه بالحليب 150 جرام', 
    110.00, 110.00, 'Powder Ba', 'هيرو',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Baby cereal food product outside core cosmeceutical skincare scope.', 
    TRUE
),
(
    29720, 
    'HERO BABY 8CEREALS&APPLE+MILK 150G 6+MONTHS مع حليب # تصبح علي خير 8حبوبوتفاح', 
    'هيرو بيبي وجبة سيريال 8 حبوب وتفاح بالحليب 150 جرام', 
    110.00, 110.00, 'Powder Ba', 'هيرو',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Baby cereal food product outside core cosmeceutical skincare scope.', 
    TRUE
),
(
    51115, 
    'HERO BABY WHEAT&OAT+MILK 150G 6+MONTHS تصبح ع خير قمح وشوفان سريال', 
    'هيرو بيبي وجبة سيريال قمح وشوفان بالحليب 150 جرام', 
    110.00, 110.00, 'Powder0', 'هيرو',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Baby cereal food product outside core cosmeceutical skincare scope.', 
    TRUE
),
(
    139824, 
    'HERO GROW 400G VANILLA فانيليا', 
    'هيرو جرو حليب أطفال مغذي بنكهة الفانيليا 400 جرام', 
    469.00, 469.00, 'Milk0', 'هيرو',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Infant nutritional milk formula outside core cosmeceutical skincare scope.', 
    TRUE
),
(
    133183, 
    'HERO ORS STRAWBERRY FLAVOR 1 POUCH 200ML محلول معالجة ج~', 
    'هيرو أورال محلول معالجة الجفاف بنكهة الفراولة 200 مل', 
    120.00, 120.00, 'SYRUP&SU', 'هيرو',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Oral rehydration solution product outside core cosmeceutical skincare scope.', 
    TRUE
),
(
    116942, 
    'HERO ORS STRAWBERRY FLAVOR 3 POUCH 200ML محلول معالجة جف', 
    'هيرو أورال محلول معالجة الجفاف بنكهة الفراولة 3 أكياس × 200 مل', 
    110.00, 330.00, 'SYRUP&SU', 'هيرو',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Oral rehydration solution product outside core cosmeceutical skincare scope.', 
    TRUE
),
(
    109499, 
    'HERO PLAST TOOTH BRUSH CASE حافظة فرواة اسنان', 
    'هيرو بلاست حافظة وحامية لفرشاة الأسنان', 
    32.50, 32.50, 'Other Dent', 'ست للصناعات البلاستكية',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Toothbrush accessory case outside core cosmeceutical skincare scope.', 
    TRUE
),
(
    124027, 
    'HERO PRO 7.5 PROBIOTICS ORAL DROPS', 
    'هيرو برو نقط بروبيوتيك معالجة للفم والفلورا 7.5 مل', 
    195.00, 195.00, 'DROPS&SP', 'هيرو',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Oral probiotic drops supplement outside core cosmeceutical skincare scope.', 
    TRUE
),
(
    129861, 
    'HERO VI D3 ORAL DROPS 15ML  مثيل', 
    'هيرو في نقط فيتامين د3 للفم 15 مل', 
    45.00, 45.00, 'DROPS&SP', 'هيرو',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Oral Vitamin D3 drops supplement outside core cosmeceutical skincare scope.', 
    TRUE
),
(
    129975, 
    'HERO VITAMIN D3+K2 ORAL DROPS 10ML~', 
    'هيرو نقط فيتامين د3 مع ك2 للفم 10 مل', 
    140.00, 140.00, 'DROPS&SP', 'هيرو',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Oral Vitamin D3+K2 drops supplement outside core cosmeceutical skincare scope.', 
    TRUE
),
INSERT INTO cosmeceutical_product_classification_full (
    code, name_en, name_ar, price_1, price_2, category, supplier,
    domain, subcategory, reason, review_required
) VALUES
(
    25606, 
    'HEROXACIN 500MG 10 TAB', 
    'هيروكساصين مضاد حيوي 500 مجم 10 أقراص', 
    69.00, 69.00, 'ORAL', 'SMS PHARMA',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Systemic antibiotic pharmaceutical product outside cosmeceutical skincare scope.', 
    TRUE
),
(
    76534, 
    'HERO BABY 8CEREAL WITH MILK 150G 6+MONTHS 8حبوب باللبن صباح', 
    'هيرو بيبي وجبة سيريال 8 حبوب بالحليب 150 جرام', 
    110.00, 110.00, 'Powder Ba', 'هيرو',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Infant cereal food product outside cosmeceutical skincare scope.', 
    TRUE
),
(
    51114, 
    'HERO BABY 8CEREALS&VEGETABLES+MILK 150G 6+MONTHSتصبح على خير 8حبوب+خضروات', 
    'هيرو بيبي وجبة سيريال 8 حبوب وخضروات بالحليب 150 جرام', 
    110.00, 110.00, 'Powder0', 'هيرو',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Infant cereal food product outside cosmeceutical skincare scope.', 
    TRUE
),
(
    16015, 
    'HERO BABY AR 400G MILK', 
    'هيرو بيبي إيه آر حليب مخصص لحالات الارتجاع 400 جرام', 
    429.00, 429.00, 'Milk0', 'هيرو',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Infant specialized formula milk outside cosmeceutical skincare scope.', 
    TRUE
),
(
    73157, 
    'HERO BABY FEH 400G MILK', 
    'هيرو بيبي إف إي إتش حليب مخصص لحالات الحساسية المفرطة 400 جرام', 
    699.00, 699.00, 'Milk0', 'هيرو',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Infant specialized formula milk outside cosmeceutical skincare scope.', 
    TRUE
),
(
    112183, 
    'HERO BABY HA 400G MILK', 
    'هيرو بيبي إتش إيه حليب للوقاية من الحساسية 400 جرام', 
    499.00, 499.00, 'Milk0', 'هيرو',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Infant specialized formula milk outside cosmeceutical skincare scope.', 
    TRUE
),
(
    94220, 
    'HERO BABY LF 400G MILK', 
    'هيرو بيبي إيل إف حليب خالي من اللاكتوز 400 جرام', 
    404.00, 404.00, 'Milk0', 'هيرو',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Infant specialized formula milk outside cosmeceutical skincare scope.', 
    TRUE
),
(
    79276, 
    'HERO BABY RICE&ZUCCHINI SOUP 6+MONTHS شوربة الأرزوالكوسه #B#', 
    'هيرو بيبي شوربة الأرز والكوسة للأطفال 120 جرام', 
    40.00, 40.00, 'Ready Bab', 'هيرو',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Baby food soup puree product outside cosmeceutical skincare scope.', 
    TRUE
),
(
    52447, 
    'HERO BABY 1 MILK 400 GM للرضع', 
    'هيرو بيبي 1 حليب للرضع مرحلة أولى 400 جرام', 
    281.00, 281.00, 'Milk0', 'هيرو',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Infant formula milk outside cosmeceutical skincare scope.', 
    TRUE
),
(
    71543, 
    'HERO BABY 2 MILK 400 GM', 
    'هيرو بيبي 2 حليب للأطفال مرحلة ثانية 400 جرام', 
    281.00, 281.00, 'Milk0', 'هيرو',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Infant follow-on formula milk outside cosmeceutical skincare scope.', 
    TRUE
),
(
    50719, 
    'HERO BABY 3 FRUITS PUREE 125G 6+MONTHS 3فواكة #B#', 
    'هيرو بيبي طعام أطفال 3 فواكه مهروسة 125 جرام', 
    40.00, 40.00, 'Ready Bab', 'هيرو',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Baby fruit puree product outside cosmeceutical skincare scope.', 
    TRUE
),
(
    112009, 
    'HERO BABY 8CEREALS&FENNEL+MILK 150G 6+MONTHS  تصبح ع خير شمر+ الحليب', 
    'هيرو بيبي وجبة سيريال 8 حبوب وشمر بالحليب 150 جرام', 
    110.00, 110.00, 'Ready Bab', 'هيرو',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Infant cereal meal outside cosmeceutical skincare scope.', 
    TRUE
),
(
    50725, 
    'HERO BABY APPLE COMPOTE 125G 6+MONTHS تفاح برطمان #C.C', 
    'هيرو بيبي طعام أطفال تفاح مهروس برطمان 125 جرام', 
    45.00, 45.00, 'Ready Bab', 'هيرو',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Baby fruit puree product outside cosmeceutical skincare scope.', 
    TRUE
),
(
    51121, 
    'HERO BABY BANANA MANDARIN PEAR 125G 6+MONTHS يوسفي+موز+كمثرى', 
    'هيرو بيبي طعام أطفال يوسفي وموز وكمثرى مهروسة 125 جرام', 
    45.00, 45.00, 'Ready Bab', 'هيرو',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Baby fruit puree product outside cosmeceutical skincare scope.', 
    TRUE
),
(
    137295, 
    'HERO BABY BANANA PUREE 125G 6+MONTHS موز مهروس #B#', 
    'هيرو بيبي طعام أطفال موز مهروس 125 جرام', 
    45.00, 45.00, 'Ready Bab', 'هيرو',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Baby fruit puree product outside cosmeceutical skincare scope.', 
    TRUE
),
(
    91415, 
    'HERO BABY BISCUITS 180G 6+MONTHS بسكويت ايطالي التسنين', 
    'هيرو بيبي بسكويت تسنين إيطالي للأطفال 180 جرام', 
    150.00, 150.00, 'Ready Bab', 'هيرو',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Teething biscuit food product outside cosmeceutical skincare scope.', 
    TRUE
),
(
    29642, 
    'HERO BABY BISCUITS 180G 6+MONTHS بسكويت بالموزلتسنين', 
    'هيرو بيبي بسكويت تسنين بالموز للأطفال 180 جرام', 
    150.00, 150.00, 'Ready Bab', 'هيرو',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Teething biscuit food product outside cosmeceutical skincare scope.', 
    TRUE
),
(
    52410, 
    'HERO BABY CEREAL RICE&CORN 150G 6+MONTHS تصبح ع خير ارز+ذرة', 
    'هيرو بيبي وجبة سيريال أرز وذرة للأطفال 150 جرام', 
    75.00, 75.00, 'Powder0', 'هيرو',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Infant cereal meal product outside cosmeceutical skincare scope.', 
    TRUE
),
(
    51118, 
    'HERO BABY CEREAL WHEAT WITH MILK 150G 6+MONTHS قمح باللبن', 
    'هيرو بيبي وجبة سيريال قمح بالحليب للأطفال 150 جرام', 
    105.00, 105.00, 'Powder0', 'هيرو',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Infant cereal meal product outside cosmeceutical skincare scope.', 
    TRUE
),
(
    23378, 
    'HERO BABY DIGEST 400G MILK', 
    'هيرو بيبي دايجست حليب مخصص لحالات الهضم والمغص 400 جرام', 
    414.00, 414.00, 'Milk0', 'هيرو',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Infant specialized formula milk outside cosmeceutical skincare scope.', 
    TRUE
),
(
    50728, 
    'HERO BABY MIXED FRUIT+CEREALS PUREE 125G 6+MONTHS فواكة مشكلة وحبوب وجبة #B#', 
    'هيرو بيبي طعام أطفال فواكه مشكلة وحبوب مهروسة 125 جرام', 
    40.00, 40.00, 'Ready Bab', 'هيرو',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Baby fruit and cereal puree product outside cosmeceutical skincare scope.', 
    TRUE
),
(
    141200, 
    'HERO BABY FRUITS WITH CARROTS&OATS PUREE 125G 6+MONTHS ف', 
    'هيرو بيبي طعام أطفال فواكه وجزر وشوفان مهروسة 125 جرام', 
    45.00, 45.00, 'Ready Bab', 'هيرو',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Baby fruit and vegetable puree product outside cosmeceutical skincare scope.', 
    TRUE
),
(
    29374, 
    'HERO BABY MIXED FRUITS PUREE 190G 6+MONTHS فواكة مشكلة مهروسة #B#', 
    'هيرو بيبي طعام أطفال فواكه مشكلة مهروسة 190 جرام', 
    65.00, 65.00, 'Ready Bab', 'هيرو',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Baby fruit puree product outside cosmeceutical skincare scope.', 
    TRUE
),
(
    37527, 
    'HERO BABY RICE AND CHICKEN PUREE 190G 6+MONTHS ارز ودجاج #B#', 
    'هيرو بيبي طعام أطفال أرز ودجاج مهروس 190 جرام', 
    65.00, 65.00, 'Ready Bab', 'هيرو',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Baby meal puree product outside cosmeceutical skincare scope.', 
    TRUE
),
(
    50733, 
    'HERO BABY MIXED FRUITS PUREE 125G 6+MONTHS فواكة مشكلة', 
    'هيرو بيبي طعام أطفال فواكه مشكلة مهروسة 125 جرام', 
    45.00, 45.00, 'Ready Bab', 'هيرو',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Baby fruit puree product outside cosmeceutical skincare scope.', 
    TRUE
),
(
    53329, 
    'HERO BABY MIXED VEGETABLE PUREE 125G 6+MONTHS خضروات', 
    'هيرو بيبي طعام أطفال خضروات مشكلة مهروسة 125 جرام', 
    45.00, 45.00, 'Ready Bab', 'هيرو',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Baby vegetable puree product outside cosmeceutical skincare scope.', 
    TRUE
),
(
    125105, 
    'HERO BABY 8CEREALS &FRUITS +MILK 300G 6+MONTHS', 
    'هيرو بيبي وجبة سيريال 8 حبوب وفواكه بالحليب 300 جرام', 
    190.00, 190.00, 'Powder Ba', 'هيرو',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Infant cereal meal product outside cosmeceutical skincare scope.', 
    TRUE
),
(
    125106, 
    'HERO BABY 8CEREALS WHEAT&OAT&MILK 300G 6+MONTHS', 
    'هيرو بيبي وجبة سيريال 8 حبوب قمح وشوفان بالحليب 300 جرام', 
    190.00, 190.00, 'Powder0', 'هيرو',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Infant cereal meal product outside cosmeceutical skincare scope.', 
    TRUE
),
(
    34116, 
    'HERO BABY NUTRA DEFENSE PLUS 1 400G', 
    'هيرو بيبي نوترا ديفنس بلس 1 حليب للرضع 400 جرام', 
    384.00, 384.00, 'Milk0', 'هيرو',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Infant formula milk outside cosmeceutical skincare scope.', 
    TRUE
),
(
    23939, 
    'HERO BABY NUTRA DEFENSE PLUS 2 400G', 
    'هيرو بيبي نوترا ديفنس بلس 2 حليب للأطفال 400 جرام', 
    384.00, 384.00, 'Milk0', 'هيرو',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Infant follow-on formula milk outside cosmeceutical skincare scope.', 
    TRUE
),
(
    109281, 
    'HERO BABY NUTRA DEFENSE PLUS 3 400G', 
    'هيرو بيبي نوترا ديفنس بلس 3 حليب نمو للأطفال 400 جرام', 
    384.00, 384.00, 'Milk0', 'هيرو',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Growing-up formula milk outside cosmeceutical skincare scope.', 
    TRUE
),
(
    27595, 
    'HERO BABY NUTRASENSE 1 400G مناعة وتطورادراكي', 
    'هيرو بيبي نوتراسنس 1 حليب نمو وتطور إدراكي 400 جرام', 
    420.00, 420.00, 'Milk0', 'هيرو',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Infant formula milk outside cosmeceutical skincare scope.', 
    TRUE
),
(
    31943, 
    'HERO BABY NUTRASENSE 2 400G مناعة وتطورادراكي', 
    'هيرو بيبي نوتراسنس 2 حليب نمو وتطور إدراكي 400 جرام', 
    420.00, 420.00, 'Milk0', 'هيرو',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Infant follow-on formula milk outside cosmeceutical skincare scope.', 
    TRUE
),
(
    25472, 
    'HERO BABY NUTRASENSE 3 400G مناعة وتطور ادراكي', 
    'هيرو بيبي نوتراسنس 3 حليب نمو وتطور إدراكي 400 جرام', 
    420.00, 420.00, 'Milk0', 'هيرو',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Growing-up formula milk outside cosmeceutical skincare scope.', 
    TRUE
),
(
    50732, 
    'HERO BABY PEACH BANANA PUREE 125G 6+MONTHS خوح و موز #B#', 
    'هيرو بيبي طعام أطفال خوخ وموز مهروس 125 جرام', 
    40.00, 40.00, 'Ready Bab', 'هيرو',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Baby fruit puree product outside cosmeceutical skincare scope.', 
    TRUE
),
(
    136926, 
    'HERO BABY PEACH BANANA PEAR PUREE 125G 6+MONTHS كمثرى وخوح', 
    'هيرو بيبي طعام أطفال كمثرى وخوخ وموز مهروس 125 جرام', 
    45.00, 45.00, 'Ready Bab', 'هيرو',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Baby fruit puree product outside cosmeceutical skincare scope.', 
    TRUE
),
(
    141619, 
    'HERO BABY POTATO PUREE 120G 6+MONTHSبطاطس مهروس', 
    'هيرو بيبي طعام أطفال بطاطس مهروسة 120 جرام', 
    45.00, 45.00, 'Ready Bab', 'هيرو',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Baby vegetable puree product outside cosmeceutical skincare scope.', 
    TRUE
),
INSERT INTO cosmeceutical_product_classification_full (
    code, name_en, name_ar, price_1, price_2, category, supplier,
    domain, subcategory, reason, review_required
) VALUES
(
    145305, 
    'CAPIXY #ع# ADVANCE REPAIR CONDITIONER 250ML', 
    'كابكسي بلسم مطور ومعالج للشعر التالف 250 مل', 
    350.00, 350.00, 'COSMO-MI', 'MAJESTIC BIO PHA',
    'Hair_Scalp_Care', 
    'hair_conditioner_balm', 
    'Advanced repair hair conditioner for damaged hair restoration and detangling.', 
    FALSE
),
(
    145307, 
    'CAPIXY #ع# ANTI-DANDRUFF CONDITIONER 250ML', 
    'كابكسي بلسم معالج ومضاد للقشرة 250 مل', 
    350.00, 350.00, 'COSMO-MI', 'MAJESTIC BIO PHA',
    'Hair_Scalp_Care', 
    'hair_conditioner_balm', 
    'Anti-dandruff conditioning balm formulated to soothe scalp and manage flakes.', 
    FALSE
),
(
    144977, 
    'CAPIXY #ع# ANTI-DANDRUFF SERUM SPRAY 120ML', 
    'كابكسي بخاخ سيروم معالج ومضاد للقشرة 120 مل', 
    375.00, 375.00, 'COSMO-MI', 'MAJESTIC BIO PHA',
    'Hair_Scalp_Care', 
    'scalp_treatment_leave_in', 
    'Anti-dandruff serum spray for scalp purifying and itching relief.', 
    FALSE
),
(
    144976, 
    'CAPIXY #ع# ANTI-DANDRUFF SHAMP 250ML', 
    'كابكسي شامبو معالج ومضاد للقشرة 250 مل', 
    320.00, 320.00, 'COSMO-MI', 'MAJESTIC BIO PHA',
    'Hair_Scalp_Care', 
    'anti_dandruff_shampoo', 
    'Scalp treatment anti-dandruff shampoo for controlling scalp flaking.', 
    FALSE
),
(
    37626, 
    'CAPIXY #ع# CREAM ANTI-HAIR LOSS 120ML', 
    'كابكسي كريم معالج ومضاد لتساقط الشعر 120 مل', 
    320.00, 320.00, 'COSMO-MI', 'MAJESTIC BIO PHA',
    'Hair_Scalp_Care', 
    'hair_conditioner_balm', 
    'Anti-hair loss conditioning cream formulated to strengthen weak hair roots.', 
    FALSE
),
(
    119151, 
    'CAPIXY #ع# EYE LASH&BROW TREAT SERUM 10ML', 
    'كابكسي سيروم معالج ومقوي للرموش والحواجب 10 مل', 
    550.00, 550.00, 'COSMO-MI', 'MAJESTIC BIO PHA',
    'Specialized_Care', 
    'nail_strengthening_cream', 
    'Nourishing treatment serum formulated to boost eyelash and eyebrow density.', 
    FALSE
),
(
    133234, 
    'CAPIXY #ع# HAIR MASK 250ML', 
    'كابكسي قناع ومحارب لتساقط وتغذية الشعر 250 مل', 
    450.00, 450.00, 'COSMO-MI', 'MAJESTIC BIO PHA',
    'Hair_Scalp_Care', 
    'anti_hair_loss_mask', 
    'Nourishing and anti-hair loss hair mask treatment for scalp and strands.', 
    FALSE
),
(
    140802, 
    'CAPIXY #ع# HAIR OIL ELIXIR ALL TYPES 30ML', 
    'كابكسي زيت إكسير مغذي للشعر لجميع الأنواع 30 مل', 
    750.00, 750.00, 'COSMO-MI', 'MAJESTIC BIO PHA',
    'Hair_Scalp_Care', 
    'nourishing_hair_serum', 
    'Nourishing elixir oil treatment for all hair types smoothing and shine.', 
    FALSE
),
(
    134252, 
    'CAPIXY #ع# HAIR SERUM FERTILIZER 120ML جميع انوا', 
    'كابكسي سيروم محفز ومخصب لنمو الشعر لجميع الأنواع 120 مل', 
    475.00, 475.00, 'COSMO-MI', 'MAJESTIC BIO PHA',
    'Hair_Scalp_Care', 
    'scalp_treatment_leave_in', 
    'Growth-stimulating hair serum fertilizer formulated to anchor follicles.', 
    FALSE
),
(
    133235, 
    'CAPIXY #ع# HYDRATING CONDITIONER 250ML', 
    'كابكسي بلسم مرطب ومغذي للشعر 250 مل', 
    350.00, 350.00, 'COSMO-MI', 'MAJESTIC BIO PHA',
    'Hair_Scalp_Care', 
    'hair_conditioner_balm', 
    'Hydrating hair conditioner for dry hair moisture replenishment.', 
    FALSE
),
(
    144583, 
    'CAPIXY #ع# INTENSE (DRY FOAM) 120ML جميع انواع', 
    'كابكسي رغوة جافة مكثفة لعلاج الشعر لجميع الأنواع 120 مل', 
    575.00, 575.00, 'COSMO-MI', 'MAJESTIC BIO PHA',
    'Hair_Scalp_Care', 
    'scalp_treatment_leave_in', 
    'Intense dry foam leave-in treatment for strengthening fragile hair.', 
    FALSE
),
(
    42466, 
    'CAPIXY #ع# INTENSE TONIC SPRAY HAIR LOSS 125ML', 
    'كابكسي بخاخ تونيك مكثف ومضاد لتساقط الشعر 125 مل', 
    700.00, 700.00, 'COSMO-MI', 'MAJESTIC BIO PHA',
    'Hair_Scalp_Care', 
    'scalp_treatment_leave_in', 
    'Intense anti-hair loss tonic spray formulated for hair density boost.', 
    FALSE
),
(
    145898, 
    'CAPIXY #ع# LEAVE IN HEAT PROTECTION SPRAY 200ML', 
    'كابكسي بخاخ حماية من الحرارة يترك على الشعر 200 مل', 
    350.00, 350.00, 'COSMO-MI', 'MAJESTIC BIO PHA',
    'Hair_Scalp_Care', 
    'scalp_treatment_leave_in', 
    'Heat protection leave-in spray designed to shield hair strands from thermal styling.', 
    FALSE
),
(
    42156, 
    'CAPIXY #ع# SHAMP ANTI-HAIR LOSS 250ML SULSATE FREE', 
    'كابكسي شامبو خالي من السلفات معالج ومضاد لتساقط الشعر 250 مل', 
    320.00, 320.00, 'COSMO-MI', 'MAJESTIC BIO PHA',
    'Hair_Scalp_Care', 
    'anti_hair_loss_shampoo', 
    'Sulfate-free anti-hair loss cleansing shampoo for gentle scalp care.', 
    FALSE
),
(
    42464, 
    'CAPIXY #ع# TONIC SPRAY ANTI-HAIR LOSS 250ML', 
    'كابكسي بخاخ تونيك معالج ومضاد لتساقط الشعر 250 مل', 
    420.00, 420.00, 'COSMO-MI', 'MAJESTIC BIO PHA',
    'Hair_Scalp_Care', 
    'scalp_treatment_leave_in', 
    'Anti-hair loss scalp tonic spray for stimulating hair follicles.', 
    FALSE
),
(
    119153, 
    'CAPIXY #ع# WOMEN HAIR TREAT VIALS (7X10ML)', 
    'كابكسي أمبولات معالجة ومقوية للشعر للنساء 7 أمبولات × 10 مل', 
    995.00, 995.00, 'COSMO-MI', 'MAJESTIC BIO PHA',
    'Hair_Scalp_Care', 
    'scalp_treatment_leave_in', 
    'Intensive hair treatment vials formulated for female hair loss control.', 
    FALSE
),
(
    145306, 
    'CAPIXY ADANCE REPAIR HAIR MASK 250ML', 
    'كابكسي قناع مطور معالج ومصلح للشعر التالف 250 جرام', 
    450.00, 450.00, 'COSMO-MI', 'MAJESTIC BIO PHA',
    'Hair_Scalp_Care', 
    'repairing_hair_mask', 
    'Advanced repair hair mask treatment for dry and damaged hair fibers.', 
    FALSE
),
(
    144975, 
    'CAPIXY ADVANCE REPAIR SHAMP 250ML', 
    'كابكسي شامبو مطور معالج ومصلح للشعر 250 مل', 
    320.00, 320.00, 'COSMO-MI', 'MAJESTIC BIO PHA',
    'Hair_Scalp_Care', 
    'repairing_hair_shampoo', 
    'Advanced repairing cleansing shampoo for damaged hair restoration.', 
    FALSE
),
(
    118592, 
    'PASSION #ع# BABY COLOGNE 100ML', 
    'باسيون كولونيا منعشة للأطفال 100 مل', 
    110.00, 110.00, 'COSMO-MI', 'بيوتى اند بيوند',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Baby cologne fragrance product outside core cosmeceutical skincare scope.', 
    TRUE
),
(
    121698, 
    'PASSION #ع# BABY HAIR OIL 100MLزيت شعر للأطفال', 
    'باسيون زيت مغذي ومرطب لشعر الأطفال 100 مل', 
    175.00, 175.00, 'COSMO-MI', 'بيوتى اند بيوند',
    'Hair_Scalp_Care', 
    'nourishing_hair_serum', 
    'Nourishing baby hair oil formulated for gentle hair moisturization.', 
    FALSE
),
(
    120091, 
    'PASSION #ع# BABY DIAPER RASH CREAM 100GM كريم حفاض', 
    'باسيون كريم واقي ومعالج لتهيج الحفاض للأطفال 100 جرام', 
    150.00, 150.00, 'COSMO-MI', 'بيوتى اند بيوند',
    'Specialized_Care', 
    'calming_relief_cream', 
    'Protective diaper rash cream to soothe and shield delicate baby skin.', 
    FALSE
),
(
    124822, 
    'PASSION #ع# BABY HAIR CREAM 120GM كريم ترطيب شعر ا', 
    'باسيون كريم ترطيب وتصفيف شعر الأطفال 120 جرام', 
    135.00, 135.00, 'COSMO-MI', 'بيوتى اند بيوند',
    'Hair_Scalp_Care', 
    'hair_conditioner_balm', 
    'Gentle hair moisturizing and styling cream formulated for children.', 
    FALSE
),
(
    118591, 
    'PASSION #ع# BABY MASSAGE OIL 100ML', 
    'باسيون زيت مساج مرطب ومهدئ للأطفال 100 مل', 
    130.00, 130.00, 'COSMO-MI', 'بيوتى اند بيوند',
    'Specialized_Body_Care', 
    'body_moisturizing_lotion', 
    'Soothing and hydrating baby massage oil for delicate skin softness.', 
    FALSE
),
(
    132330, 
    'PASSION #ع# BABY (WATER WIPES) 72PCS مناديل اطفال', 
    'باسيون مناديل مبللة مائية نقية للأطفال 72 منديل', 
    125.00, 125.00, 'COSMO-MI', 'بيوتى اند بيوند',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Baby cleansing water wipes product outside core cosmeceutical skincare scope.', 
    TRUE
),
(
    133483, 
    'PASSION #ع# BABY SOAP YLANG- YLANG 100GM صابونة اط', 
    'باسيون صابونة مرطبة ومغذية للأطفال بخلاصة الإيلنغ 100 جرام', 
    95.00, 95.00, 'COSMO-MI', 'بيوتى اند بيوند',
    'Skin_Cleansing', 
    'lipid_replenishing_cleanser', 
    'Gentle baby cleansing bar soap enriched with ylang-ylang extract.', 
    FALSE
),
(
    118590, 
    'PASSION #ع# BABY BODY LOTION 200ML', 
    'باسيون لوشن مرطب ولطيف للجسم للأطفال 200 مل', 
    160.00, 160.00, 'COSMO-MI', 'بيوتى اند بيوند',
    'Specialized_Body_Care', 
    'body_moisturizing_lotion', 
    'Moisturizing baby body lotion formulated for delicate skin barrier care.', 
    FALSE
),
(
    118589, 
    'PASSION #ع# BABY SHAMPO&SHOWER 275ML', 
    'باسيون شامبو وغسول استحمام لطيف للأطفال 275 مل', 
    195.00, 195.00, 'COSMO-MI', 'بيوتى اند بيوند',
    'Hair_Scalp_Care', 
    'moisturizing_hair_shampoo', 
    'Gentle 2-in-1 baby shampoo and body wash formula.', 
    FALSE
),
(
    131546, 
    'EVERYOUTH ANTI HAIR LOSS (10MLX6VIALS) امبولات', 
    'إفريوث أمبولات معالجة ومضادة لتساقط الشعر 6 أمبولات × 10 مل', 
    990.00, 990.00, 'COSMO-MI', 'بيوتى اند بيوند',
    'Hair_Scalp_Care', 
    'scalp_treatment_leave_in', 
    'Intensive anti-hair loss vials designed to nourish hair roots and combat thinning.', 
    FALSE
),
(
    116153, 
    'EVERYOUTH ANTI WRINKLES CREAM 50G', 
    'إفريوث كريم مرطب ومقاوم للتجاعيد وعلامات الشيخوخة 50 جرام', 
    550.00, 550.00, 'COSMO-MI', 'بيوتى اند بيوند',
    'Anti_Aging_Skin_Rejuvenation', 
    'anti_aging_day_cream', 
    'Anti-wrinkle facial moisturizing cream formulated to restore skin firmness.', 
    FALSE
),
(
    116155, 
    'EVERYOUTH DETOX ANTI AGING CLEANSER 200ML', 
    'إفريوث جل غسول منظف ومضاد للشيخوخة ومنقي للبشرة 200 مل', 
    350.00, 350.00, 'COSMO-MI', 'بيوتى اند بيوند',
    'Skin_Cleansing', 
    'brightening_cleansing_gel', 
    'Detoxifying anti-aging facial gel cleanser formulated for skin rejuvenation.', 
    FALSE
),
(
    119980, 
    'EVERYOUTH FACIAL MASK 200ML', 
    'إفريوث قناع مرطب ومغذي للوجه 200 مل', 
    320.00, 320.00, 'COSMO-MI', 'بيوتى اند بيوند',
    'Skin_Moisturization_Barrier', 
    'hydrating_sheet_mask', 
    'Nourishing and hydrating facial mask for restoring skin moisture balance.', 
    FALSE
),
(
    116154, 
    'EVERYOUTH FILLER GEL HYALURONIC 50G', 
    'إفريوث جل فيلر مالئ بالهيالورونيك مرطب للوجه 50 جرام', 
    650.00, 650.00, 'COSMO-MI', 'بيوتى اند بيوند',
    'Anti_Aging_Skin_Rejuvenation', 
    'firming_radiance_gel', 
    'Hyaluronic filler gel for plumping fine lines and deep facial moisturization.', 
    FALSE
),
(
    131548, 
    'EVERYOUTH SEROIL BILAYER HAIR SPRAY 240ML', 
    'إفريوث بخاخ زيت ثنائي الطبقات مغذي للشعر 240 مل', 
    450.00, 450.00, 'COSMO-MI', 'بيوتى اند بيوند',
    'Hair_Scalp_Care', 
    'scalp_treatment_leave_in', 
    'Bilayer nourishing oil hair spray for shine, softness, and anti-frizz.', 
    FALSE
),
(
    116156, 
    'EVERYOUTH TOTAL EYE CARE CREAM 30G', 
    'إفريوث كريم عناية شاملة لمنطقة العين 30 جرام', 
    495.00, 495.00, 'COSMO-MI', 'بيوتى اند بيوند',
    'Specialized_Care', 
    'eye_contour_care', 
    'Total eye contour care cream targeting fine lines, puffiness, and dark circles.', 
    FALSE
),
(
    137105, 
    'EVERYOUTH ANTI DANDRUFF LOTION 100ML', 
    'إفريوث لوشن معالج ومضاد للقشرة لفروة الرأس 100 مل', 
    390.00, 390.00, 'COSMO-MI', 'بيوتى اند بيوند',
    'Hair_Scalp_Care', 
    'scalp_treatment_leave_in', 
    'Anti-dandruff scalp lotion designed to soothe irritation and clear flakes.', 
    FALSE
),
(
    137104, 
    'EVERYOUTH ANTI DANDRUFF SHAMP 200ML', 
    'إفريوث شامبو معالج ومضاد للقشرة 200 مل', 
    350.00, 350.00, 'COSMO-MI', 'بيوتى اند بيوند',
    'Hair_Scalp_Care', 
    'anti_dandruff_shampoo', 
    'Scalp purifying anti-dandruff shampoo for controlling scalp flakes.', 
    FALSE
),
(
    116152, 
    'EVERYOUTH DETOX SERUM 30ML ANTI AGEING(V.C15%)', 
    'إفريوث سيروم منقي ومضاد للشيخوخة بفيتامين سي 15% بحجم 30 مل', 
    475.00, 475.00, 'COSMO-MI', 'بيوتى اند بيوند',
    'Anti_Aging_Skin_Rejuvenation', 
    'antioxidant_radiance_serum', 
    '15% Vitamin C antioxidant detoxifying serum for anti-aging and skin radiance.', 
    FALSE
),
(
    139204, 
    'EVERYOUTH HAIR LOTION ACCELERATOR 150ML', 
    'إفريوث لوشن محفز ومسرع لنمو الشعر 150 مل', 
    700.00, 700.00, 'COSMO-MI', 'بيوتى اند بيوند',
    'Hair_Scalp_Care', 
    'scalp_treatment_leave_in', 
    'Hair growth accelerator scalp lotion for stimulating hair follicles.', 
    FALSE
),
(
    131547, 
    'EVERYOUTH HAIR MASK 250ML', 
    'إفريوث قناع معالج ومغذي عميق للشعر 250 مل', 
    460.00, 460.00, 'COSMO-MI', 'بيوتى اند بيوند',
    'Hair_Scalp_Care', 
    'nourishing_hair_mask', 
    'Deeply nourishing hair mask treatment for dry and damaged hair strands.', 
    FALSE
),
(
    125604, 
    'SUPER KIDS ROLL-ON PINEAPPLE 30ML (1+50%)', 
    'سوبر كيدز مزيل عرق رول أون برائحة الأناناس للأطفال 30 مل', 
    165.00, 165.00, 'COSMO-MI', 'PARKVILLE PHARM',
    'Specialized_Body_Care', 
    'antiperspirant_deodorant', 
    'Gentle children roll-on deodorant scented with pineapple.', 
    FALSE
),
(
    145892, 
    'SUPER KIDS TOOTH PASTE(BERRIES) 50G 2+YEARS', 
    'سوبر كيدز معجون أسنان للأطفال بنكهة التوت لعمر سنتين فأكثر 50 جرام', 
    60.00, 60.00, 'COSMO-MI', 'PARKVILLE PHARM',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Children oral toothpaste product outside core cosmeceutical skincare scope.', 
    TRUE
),
(
    125605, 
    'SUPER KIDS ROLL-ON (1+50%) FRAGRANCE FREE 30ML', 
    'سوبر كيدز مزيل عرق رول أون بدون عطور للأطفال 30 مل', 
    165.00, 165.00, 'COSMO-MI', 'PARKVILLE PHARM',
    'Specialized_Body_Care', 
    'antiperspirant_deodorant', 
    'Fragrance-free roll-on deodorant formulated for sensitive children skin.', 
    FALSE
),
(
    138947, 
    'SUPER KIDS SHAM STRAW 300ML + CREAM 200ML عرض', 
    'سوبر كيدز مجموعة شامبو فراولة 300 مل + كريم 200 مل', 
    222.00, 222.00, 'COSMO-MI', 'PARKVILLE PHARM',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Promotional combo set combining kids shampoo and hair cream.', 
    TRUE
),
(
    138045, 
    'SUPER KIDS BODY LOTION 300ML', 
    'سوبر كيدز لوشن مرطب ولطيف للجسم للأطفال 300 مل', 
    250.00, 250.00, 'COSMO-MI', 'PARKVILLE PHARM',
    'Specialized_Body_Care', 
    'body_moisturizing_lotion', 
    'Gentle moisturizing body lotion formulated for children sensitive skin.', 
    FALSE
),
(
    128085, 
    'SUPER KIDS (عرض 3 قطع) WATER WIPES 72PCS', 
    'سوبر كيدز مجموعة مناديل مبللة مائية 3 عبوات × 72 منديل', 
    225.00, 225.00, 'Wipes0', 'PARKVILLE PHARM',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Promotional 3-pack water wipes product outside core cosmeceutical skincare scope.', 
    TRUE
),
(
    118481, 
    'SUPER KIDS HAIR MASK 1+YEARS 300G', 
    'سوبر كيدز قناع مرطب ومغذي لشعر الأطفال لعمر سنة فأكثر 300 جرام', 
    150.00, 150.00, 'COSMO-MI', 'PARKVILLE PHARM',
    'Hair_Scalp_Care', 
    'nourishing_hair_mask', 
    'Nourishing and detangling hair mask for toddlers and children aged 1+.', 
    FALSE
),
(
    126796, 
    'SUPER KIDS HAIR SERUM 100ML 1+YEARS', 
    'سوبر كيدز سيروم مرطب ومغذي لشعر الأطفال لعمر سنة فأكثر 100 مل', 
    350.00, 350.00, 'Hair Oil0', 'PARKVILLE PHARM',
    'Hair_Scalp_Care', 
    'nourishing_hair_serum', 
    'Gentle moisturizing hair serum for children aged 1+.', 
    FALSE
),
(
    44282, 
    'SUPER KIDS NUTRITIVE HAIR SPRAY 120ML', 
    'سوبر كيدز بخاخ مغذي ومصفف لشعر الأطفال 120 مل', 
    150.00, 150.00, 'COSMO-MI', 'PARKVILLE PHARM',
    'Hair_Scalp_Care', 
    'scalp_treatment_leave_in', 
    'Nutritive leave-in hair styling spray for children.', 
    FALSE
),
INSERT INTO cosmeceutical_product_classification_full (
    code, name_en, name_ar, price_1, price_2, category, supplier,
    domain, subcategory, reason, review_required
) VALUES
(
    133507, 
    'SUPER KIDS ROLL-ON LOLLIPOP SCENT 30ML', 
    'سوبر كيدز مزيل عرق رول أون برائحة اللولي بوب للأطفال 30 مل', 
    110.00, 110.00, 'COSMO-MI', 'PARKVILLE PHARM',
    'Specialized_Body_Care', 
    'antiperspirant_deodorant', 
    'Gentle children roll-on deodorant scented with lollipop.', 
    FALSE
),
(
    33584, 
    'SUPER KIDS SHAM &COND BLUEBERRY 500ML بالتوت', 
    'سوبر كيدز شامبو وبلسم للأطفال برائحة التوت الأزرق 500 مل', 
    220.00, 220.00, 'COSMO-MI', 'PARKVILLE PHARM',
    'Hair_Scalp_Care', 
    'moisturizing_hair_shampoo', 
    '2-in-1 blueberry scented kids cleansing shampoo and conditioner.', 
    FALSE
),
(
    25581, 
    'SUPER KIDS SHAM GREEN APPLE 300ML تفاح اخضر', 
    'سوبر كيدز شامبو للأطفال برائحة التفاح الأخضر 300 مل', 
    150.00, 150.00, 'COSMO-MI', 'PARKVILLE PHARM',
    'Hair_Scalp_Care', 
    'moisturizing_hair_shampoo', 
    'Gentle green apple scented hair shampoo for children.', 
    FALSE
),
(
    144818, 
    'SUPER KIDS TOOTH PASTE (NO FLAVOUR) 50G 2+YEARS', 
    'سوبر كيدز معجون أسنان للأطفال بدون نكهة لعمر سنتين فأكثر 50 جرام', 
    60.00, 60.00, 'COSMO-MI', 'PARKVILLE PHARM',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Children oral toothpaste product outside core cosmeceutical skincare scope.', 
    TRUE
),
(
    132615, 
    'SUPER KIDS VITAMIN D3 400IU ORAL DROPS 15ML', 
    'سوبر كيدز نقط فيتامين د3 الفموية للأطفال 400 وحدة دولية 15 مل', 
    45.00, 45.00, 'DROPS&SP', 'PARKVILLE PHARM',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Oral Vitamin D3 drops supplement outside core cosmeceutical skincare scope.', 
    TRUE
),
(
    1513, 
    'SUPER KIDS BABY SHAMP HONEY&MILK 200M', 
    'سوبر كيدز شامبو أطفال بالعسل والحليب 200 مل', 
    150.00, 150.00, 'COSMO-MI', 'PARKVILLE PHARM',
    'Hair_Scalp_Care', 
    'moisturizing_hair_shampoo', 
    'Nourishing honey and milk baby hair cleansing shampoo.', 
    FALSE
),
(
    145141, 
    'SUPER KIDS CHOCOLATE SPREAD 250G', 
    'سوبر كيدز شوكولاتة قابلة للدهن مغذية للأطفال 250 جرام', 
    300.00, 300.00, 'Chocolate', 'PARKVILLE PHARM',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Children food spread product outside core cosmeceutical skincare scope.', 
    TRUE
),
(
    138112, 
    'SUPER KIDS IRON SYRUP 150ML', 
    'سوبر كيدز شراب حديد مكمل غذائي للأطفال 150 مل', 
    130.00, 130.00, 'SYRUP&SU', 'PARKVILLE PHARM',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Oral iron dietary supplement syrup outside core cosmeceutical skincare scope.', 
    TRUE
),
(
    139168, 
    'SUPER KIDS LIP BALM STRAWBERRY 10G', 
    'سوبر كيدز مرطب شفاه للأطفال بنكهة الفراولة 10 جرام', 
    85.00, 85.00, 'Skin Care f', 'PARKVILLE PHARM',
    'Lip_Care', 
    'lip_repair_balm', 
    'Strawberry scented lip moisturizer balm formulated for children.', 
    FALSE
),
(
    125606, 
    'SUPER KIDS ROLL-ON (PINEAPPLE+FRAG FREE) 30ML ', 
    'سوبر كيدز مزيل عرق رول أون مجموعة أناناس وبدون عطور 30 مل', 
    165.00, 165.00, 'COSMO-MI', 'PARKVILLE PHARM',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Promotional double bundle set containing pineapple and fragrance-free roll-on deodorants.', 
    TRUE
),
(
    116123, 
    'SUPER KIDS SHAMP CURLY 300ML 2+YEARS', 
    'سوبر كيدز شامبو مخصص للشعر الكيرلي للأطفال لعمر سنتين فأكثر 300 مل', 
    180.01, 180.01, 'COSMO-MI', 'PARKVILLE PHARM',
    'Hair_Scalp_Care', 
    'moisturizing_hair_shampoo', 
    'Gentle curly hair shampoo formulated for kids aged 2+.', 
    FALSE
),
(
    128086, 
    'SUPER KIDS(CURLY GEL+REFRESH SPRAY 250ML)', 
    'سوبر كيدز مجموعة جل كيرلي 250 مل + بخاخ منعش 250 مل', 
    225.00, 225.00, 'COSMO-MI', 'PARKVILLE PHARM',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Promotional combo bundle set combining curly styling gel and refresh spray.', 
    TRUE
),
(
    22149, 
    'SUPER KIDS BUBBLE BATH GEL 300ML', 
    'سوبر كيدز جل استحمامات رغوي بابل باث للأطفال 300 مل', 
    150.00, 150.00, 'COSMO-MI', 'PARKVILLE PHARM',
    'Skin_Cleansing', 
    'soothing_cleansing_gel', 
    'Foaming bubble bath gel cleanser formulated for kids gentle bath care.', 
    FALSE
),
(
    119381, 
    'SUPER KIDS CURLY SPRAY 1+YEARS 250ML', 
    'سوبر كيدز بخاخ لتصفيف الشعر الكيرلي للأطفال لعمر سنة فأكثر 250 مل', 
    140.00, 140.00, 'COSMO-MI', 'PARKVILLE PHARM',
    'Hair_Scalp_Care', 
    'scalp_treatment_leave_in', 
    'Leave-in curly hair styling spray for toddlers and children aged 1+.', 
    FALSE
),
(
    139169, 
    'SUPER KIDS HYGIENE WATER WIPES 20PCS', 
    'سوبر كيدز مناديل مبللة مائية للعناية والنظافة الشخصية 20 منديل', 
    27.00, 27.00, 'Skin Care f', 'PARKVILLE PHARM',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Hygiene cleansing water wipes product outside core cosmeceutical skincare scope.', 
    TRUE
),
(
    138111, 
    'SUPER KIDS IRON DROPS 30ML', 
    'سوبر كيدز نقط حديد مكمل غذائي للأطفال 30 مل', 
    150.00, 150.00, 'DROPS&SP', 'PARKVILLE PHARM',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Oral iron dietary supplement drops outside core cosmeceutical skincare scope.', 
    TRUE
),
(
    132476, 
    'SUPER KIDS MULTI VITAMINS FOR KIDS 120 GUMMIES ت.ج', 
    'سوبر كيدز حلوى جيلي فيتامينات متعددة للأطفال 120 قطعة', 
    320.00, 320.00, 'Other Fooc', 'PARKVILLE PHARM',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Children multivitamin gummy supplements outside core cosmeceutical skincare scope.', 
    TRUE
),
(
    132480, 
    'SUPER KIDS MULTI VITAMINS FOR KIDS 60 GUMMIES', 
    'سوبر كيدز حلوى جيلي فيتامينات متعددة للأطفال 60 قطعة', 
    190.00, 190.00, 'Other Fooc', 'PARKVILLE PHARM',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Children multivitamin gummy supplements outside core cosmeceutical skincare scope.', 
    TRUE
),
(
    110347, 
    'SUPER KIDS ROLL-ON PINEAPPLE SCENT 30ML أناناس', 
    'سوبر كيدز مزيل عرق رول أون برائحة الأناناس للأطفال 30 مل', 
    110.00, 110.00, 'COSMO-MI', 'PARKVILLE PHARM',
    'Specialized_Body_Care', 
    'antiperspirant_deodorant', 
    'Gentle children roll-on deodorant scented with pineapple.', 
    FALSE
),
(
    120528, 
    'SUPER KIDS CURLY HAIR GEL 1+YEARS 250ML', 
    'سوبر كيدز جل لتصفيف الشعر الكيرلي للأطفال لعمر سنة فأكثر 250 مل', 
    160.00, 160.00, 'COSMO-MI', 'PARKVILLE PHARM',
    'Hair_Scalp_Care', 
    'scalp_treatment_leave_in', 
    'Curly hair styling gel formulated for toddlers and children aged 1+.', 
    FALSE
),
(
    114821, 
    'SUPER KIDS FACIAL FOAM 200ML', 
    'سوبر كيدز رغوة غسول لطيفة للوجه للأطفال 200 مل', 
    150.00, 150.00, 'COSMO-MI', 'PARKVILLE PHARM',
    'Skin_Cleansing', 
    'soothing_cleansing_gel', 
    'Gentle foaming facial cleanser formulated for delicate children skin.', 
    FALSE
),
(
    22504, 
    'SUPER KIDS SHAM STRAWBERRY 300ML شامبو فراولة', 
    'سوبر كيدز شامبو للأطفال برائحة الفراولة 300 مل', 
    150.00, 150.00, 'COSMO-MI', 'PARKVILLE PHARM',
    'Hair_Scalp_Care', 
    'moisturizing_hair_shampoo', 
    'Strawberry scented gentle hair cleansing shampoo for children.', 
    FALSE
),
(
    78358, 
    'SUPER KIDS SPRAY DETANGLING 120ML SULFATE FREE', 
    'سوبر كيدز بخاخ فك تشابك الشعر خالي من السلفات للأطفال 120 مل', 
    150.00, 150.00, 'COSMO-MI', 'PARKVILLE PHARM',
    'Hair_Scalp_Care', 
    'scalp_treatment_leave_in', 
    'Sulfate-free detangling leave-in hair spray for children.', 
    FALSE
),
(
    116685, 
    'SUPER KIDS WATER WIPES 72PCS مناديل مبللة', 
    'سوبر كيدز مناديل مبللة مائية نقية للأطفال 72 منديل', 
    100.00, 100.00, 'Wipes0', 'PARKVILLE PHARM',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Children pure water wipes product outside core cosmeceutical skincare scope.', 
    TRUE
),
(
    110328, 
    'SUPER KIDS LEAVE IN COND CURLS ACTIV 250ML', 
    'سوبر كيدز بلسم يترك على الشعر منشط للكيرلي للأطفال 250 مل', 
    170.00, 170.00, 'COSMO-MI', 'PARKVILLE PHARM',
    'Hair_Scalp_Care', 
    'hair_conditioner_balm', 
    'Leave-in curl activating hair conditioner for children.', 
    FALSE
),
(
    96733, 
    'SUPER KIDS SHAM&COND BATH GELSTRAW 500ML فراولة', 
    'سوبر كيدز شامبو وبلسم وجل استحمام 3 في 1 بالفراولة للأطفال 500 مل', 
    230.00, 230.00, 'COSMO-MI', 'PARKVILLE PHARM',
    'Hair_Scalp_Care', 
    'moisturizing_hair_shampoo', 
    '3-in-1 strawberry scented shampoo, conditioner, and body wash for kids.', 
    FALSE
),
(
    91045, 
    'SUPER KIDS ROLL-ON FRAGRANCE FREE 30ML', 
    'سوبر كيدز مزيل عرق رول أون بدون عطور للأطفال 30 مل', 
    110.00, 110.00, 'COSMO-MI', 'PARKVILLE PHARM',
    'Specialized_Body_Care', 
    'antiperspirant_deodorant', 
    'Fragrance-free roll-on deodorant formulated for sensitive children skin.', 
    FALSE
),
(
    85130, 
    'SUPER KIDS SUNSCREEN SPF50 BABY 6+YEARS LOTION 200ML', 
    'سوبر كيدز لوشن واقي شمس مخصص للأطفال SPF50 بحجم 200 مل', 
    310.00, 310.00, 'COSMO-MI', 'PARKVILLE PHARM',
    'Sun_Protection', 
    'kids_sunscreen_spray', 
    'Protective sunscreen lotion with SPF50 formulated for children aged 6+ years.', 
    FALSE
),
(
    30830, 
    'SUPER KIDS HAIR CREAM SOFT&SHINY 200ML', 
    'سوبر كيدز كريم مرطب وملمع لشعر الأطفال 200 مل', 
    145.00, 145.00, 'COSMO-MI', 'PARKVILLE PHARM',
    'Hair_Scalp_Care', 
    'hair_conditioner_balm', 
    'Softening and shine-enhancing hair cream for kids.', 
    FALSE
),
(
    146287, 
    'ALEJON#ع# CICA CLEANSER 200ML', 
    'أليجون سيكا غسول منظف ومهدئ للبشرة 200 مل', 
    280.00, 280.00, 'COSMO-MI', 'ALEJON',
    'Skin_Cleansing', 
    'soothing_cleansing_gel', 
    'Soothing and repairing Cica facial cleansing gel for compromised skin.', 
    FALSE
),
(
    42805, 
    'ALEJON#ع# COLLAGEN SERUM FACE&NECK 50ML', 
    'أليجون سيروم الكولاجين لشد وترطيب الوجه والرقبة 50 مل', 
    390.00, 390.00, 'COSMO-MI', 'ALEJON',
    'Anti_Aging_Skin_Rejuvenation', 
    'firming_radiance_gel', 
    'Collagen firming and hydrating serum for facial and neck skin elasticity.', 
    FALSE
),
(
    116042, 
    'ALEJON#ع# CORRECTIVE FOUND(2 SAND) SPF50 30ML', 
    'أليجون كريم أساس تصحيحي درجة ساند واقي شمس SPF50 بحجم 30 مل', 
    410.00, 410.00, 'COSMO-MI', 'ALEJON',
    'Sun_Protection', 
    'tinted_facial_sunscreen', 
    'Corrective shade sand foundation cream with broad-spectrum SPF50 sun protection.', 
    FALSE
),
(
    111140, 
    'ALEJON#ع# DRY SKIN CLEANSER 150ML', 
    'أليجون غسول مرطب ومنظف للبشرة الجافة 150 مل', 
    250.00, 250.00, 'COSMO-MI', 'ALEJON',
    'Skin_Cleansing', 
    'lipid_replenishing_cleanser', 
    'Moisturizing and lipid-replenishing cleanser formulated for dry skin.', 
    FALSE
),
(
    22520, 
    'ALEJON#ع# EYE CONTOUR SERUM 30ML', 
    'أليجون سيروم العناية بمنطقة العين 30 مل', 
    320.00, 320.00, 'COSMO-MI', 'ALEJON',
    'Specialized_Care', 
    'eye_contour_care', 
    'Eye contour care serum targeting dark circles, fine lines, and puffiness.', 
    FALSE
),
(
    31222, 
    'ALEJON#ع# FACIAL TONER FACE & NECK ALL SKIN 200ML', 
    'أليجون تونر منظف ومنعش للوجه والرقبة لجميع أنواع البشرة 200 مل', 
    270.00, 270.00, 'COSMO-MI', 'ALEJON',
    'Skin_Cleansing', 
    'soothing_cleansing_gel', 
    'Refreshing and balancing facial toner lotion for all skin types.', 
    FALSE
),
(
    21407, 
    'ALEJON#ع# FOAM CLEANSER OILY SKIN 200ML', 
    'أليجون غسول رغوي منظف ومطهر للبشرة الدهنية 200 مل', 
    295.00, 295.00, 'COSMO-MI', 'ALEJON',
    'Acne_Oil_Control', 
    'acne_cleansing_gel', 
    'Purifying foaming cleansing gel for oily and acne-prone skin.', 
    FALSE
),
(
    109917, 
    'ALEJON#ع# HAIR CONDITIONER 200ML SULFATE FREE', 
    'أليجون بلسم مرطب للشعر خالي من السلفات 200 مل', 
    275.00, 275.00, 'COSMO-MI', 'ALEJON',
    'Hair_Scalp_Care', 
    'hair_conditioner_balm', 
    'Sulfate-free hydrating hair conditioner for smooth hair strands.', 
    FALSE
),
(
    106127, 
    'ALEJON#ع# HAIR MASK INTENSE DAMAGE&REPAIR 200ML', 
    'أليجون قناع معالج ومصلح مكثف للشعر التالف 200 مل', 
    320.00, 320.00, 'COSMO-MI', 'ALEJON',
    'Hair_Scalp_Care', 
    'repairing_hair_mask', 
    'Intense damage repair hair mask for restoring dry and brittle hair.', 
    FALSE
),
(
    125361, 
    'ALEJON#ع# POST LASER CREAM 75G', 
    'أليجون كريم مهدئ ومرمم بعد الجلسات والليزر 75 جرام', 
    240.00, 240.00, 'COSMO-MI', 'ALEJON',
    'Skin_Moisturization_Barrier', 
    'barrier_repair_hydrator', 
    'Post-procedure calming and repairing cream for laser and dermatological treatments.', 
    FALSE
),
(
    124045, 
    'ALEJON#ع# ROLL-ON ORIENTAL 50ML(48H)', 
    'أليجون مزيل عرق رول أون برائحة أورينتال حماية 48 ساعة 50 مل', 
    220.00, 220.00, 'COSMO-MI', 'ALEJON',
    'Specialized_Body_Care', 
    'antiperspirant_deodorant', 
    '48-hour oriental scented roll-on antiperspirant deodorant.', 
    FALSE
),
(
    106126, 
    'ALEJON#ع# SHAMPOO ANTI-HAIR LOSS 200ML SLSF', 
    'أليجون شامبو معالج ومضاد لتساقط الشعر خالي من سلفات لوريل الصوديوم 200 مل', 
    275.00, 275.00, 'COSMO-MI', 'ALEJON',
    'Hair_Scalp_Care', 
    'anti_hair_loss_shampoo', 
    'Sodium lauryl sulfate-free anti-hair loss cleansing shampoo.', 
    FALSE
),
(
    25843, 
    'ALEJON#ع# SPRAY HAIR LOTION AMINDXIL 2 150ML', 
    'أليجون بخاخ لوشن معالج لتساقط الشعر بأمينوكسيل 2% بحجم 150 مل', 
    430.00, 430.00, 'COSMO-MI', 'ALEJON',
    'Hair_Scalp_Care', 
    'scalp_treatment_leave_in', 
    'Anti-hair loss scalp lotion spray formulated with 2% Aminexil.', 
    FALSE
),
(
    115377, 
    'ALEJON#ع# TAN OIL CARROT VIT E MOIST 200ML', 
    'أليجون زيت تسمير للجسم بالجزر وفيتامين إي المرطب 200 مل', 
    320.00, 320.00, 'COSMO-MI', 'ALEJON',
    'Sun_Protection', 
    'tanning_oil', 
    'Moisturizing carrot and Vitamin E body tanning oil.', 
    FALSE
),
(
    24806, 
    'ALEJON#ع# WHITENING CLEANSER FOAM 200ML', 
    'أليجون رغوة غسول ومفتحة للبشرة 200 مل', 
    295.00, 295.00, 'COSMO-MI', 'ALEJON',
    'Pigmentation_Skin_Tone', 
    'brightening_cleansing_gel', 
    'Brightening and whitening facial cleansing foam for even skin tone.', 
    FALSE
),
(
    9379, 
    'ALEJON#ع# WHITENING BODY MILK 200ML', 
    'أليجون حليب مرطب ومفتح للجسم 200 مل', 
    360.00, 360.00, 'COSMO-MI', 'ALEJON',
    'Pigmentation_Skin_Tone', 
    'anti_pigmentation_serum', 
    'Brightening body milk formulated for moisturizing and even skin complexion.', 
    FALSE
),
(
    36268, 
    'ALEJON#ع# OILY SOAP ACNE PRONE 100G', 
    'أليجون صابونة طبية للبشرة الدهنية المعرضة للحبوب 100 جرام', 
    150.00, 150.00, 'COSMO-MI', 'ALEJON',
    'Acne_Oil_Control', 
    'acne_cleansing_gel', 
    'Medical cleansing bar soap formulated for oily and acne-prone skin.', 
    FALSE
),
(
    124044, 
    'ALEJON#ع# ROLL-ON FRAGRANCE FREE 50ML(48H)', 
    'أليجون مزيل عرق رول أون بدون عطور حماية 48 ساعة 50 مل', 
    220.00, 220.00, 'COSMO-MI', 'ALEJON',
    'Specialized_Body_Care', 
    'antiperspirant_deodorant', 
    '48-hour fragrance-free roll-on antiperspirant deodorant.', 
    FALSE
),
(
    123842, 
    'ALEJON #ع#FOOT CREAM 75G', 
    'أليجون كريم مرطب ومعالج للقدمين 75 جرام', 
    295.00, 295.00, 'COSMO-MI', 'ALEJON',
    'Specialized_Body_Care', 
    'foot_crack_repair_cream', 
    'Deeply moisturizing foot cream formulated for cracked heels and dry skin.', 
    FALSE
),
(
    116423, 
    'ALEJON #ع#HAND &NAIL CREAM 75G', 
    'أليجون كريم مرطب لليدين والأظافر 75 جرام', 
    230.00, 230.00, 'COSMO-MI', 'ALEJON',
    'Specialized_Body_Care', 
    'hand_repair_cream', 
    'Nourishing hand and nail repair cream for daily hydration.', 
    FALSE
),
(
    124042, 
    'ALEJON #ع#MEN ROLL-ON CHAMPION 50ML(48H)', 
    'أليجون مزيل عرق رجالي رول أون تشامبيون حماية 48 ساعة 50 مل', 
    220.00, 220.00, 'COSMO-MI', 'ALEJON',
    'Specialized_Body_Care', 
    'antiperspirant_deodorant', 
    '48-hour roll-on antiperspirant deodorant for men (Champion scent).', 
    FALSE
),
(
    112793, 
    'ALEJON #ع#OILY SKIN ACNE CREAM 50G', 
    'أليجون كريم معالج لحب الشباب للبشرة الدهنية 50 جرام', 
    230.00, 230.00, 'COSMO-MI', 'ALEJON',
    'Acne_Oil_Control', 
    'acne_spot_treatment', 
    'Acne treatment cream formulated to clear blemishes on oily skin.', 
    FALSE
),
(
    124043, 
    'ALEJON #ع#ROLL-ON MIDNIGHT 50ML(48H)', 
    'أليجون مزيل عرق رول أون برائحة ميدنايت حماية 48 ساعة 50 مل', 
    220.00, 220.00, 'COSMO-MI', 'ALEJON',
    'Specialized_Body_Care', 
    'antiperspirant_deodorant', 
    '48-hour roll-on antiperspirant deodorant in Midnight scent.', 
    FALSE
),
INSERT INTO cosmeceutical_product_classification_full (
    code, name_en, name_ar, price_1, price_2, category, supplier,
    domain, subcategory, reason, review_required
) VALUES
(
    33379, 
    'ALEJON #ع#SUN SCREEN CREAM SPF50 75ML', 
    'أليجون كريم واقي شمس SPF50 بحجم 75 مل', 
    350.00, 350.00, 'COSMO-MI', 'ALEJON',
    'Sun_Protection', 
    'facial_sunscreen_cream', 
    'Broad-spectrum SPF50 facial sunscreen cream providing sun defense and moisturizing protection.', 
    FALSE
),
(
    40320, 
    'ALEJON #ع#SUN SCREEN GEL SPF50 75ML', 
    'أليجون جل واقي شمس SPF50 بحجم 75 مل', 
    410.00, 410.00, 'COSMO-MI', 'ALEJON',
    'Sun_Protection', 
    'mattifying_facial_sunscreen', 
    'High protection SPF50 facial sunscreen gel suitable for oily and combination skin.', 
    FALSE
),
(
    120702, 
    'ALEJON #ع#SUN SCREEN PRIMER SPF50 50ML', 
    'أليجون برايمر واقي شمس SPF50 بحجم 50 مل', 
    575.00, 575.00, 'COSMO-MI', 'ALEJON',
    'Sun_Protection', 
    'facial_sunscreen_fluid', 
    'Sunscreen primer offering SPF50 protection with makeup base smoothing properties.', 
    FALSE
),
(
    146285, 
    'ALEJON #ع#UREA BODY WASH 500ML', 
    'أليجون غسول مرطب للجسم باليوريا 500 مل', 
    320.00, 320.00, 'COSMO-MI', 'ALEJON',
    'Skin_Cleansing', 
    'lipid_replenishing_cleanser', 
    'Moisturizing body wash enriched with Urea to replenish lipids and relieve dry body skin.', 
    FALSE
),
(
    104249, 
    'ALEJON #ع#WHITENING CREAM FACE&BODY 50ML', 
    'أليجون كريم مرطب ومفتح للوجه والجسم 50 مل', 
    345.00, 345.00, 'COSMO-MI', 'ALEJON',
    'Pigmentation_Skin_Tone', 
    'pigmentation_day_cream', 
    'Moisturizing and skin brightening cream for even tone across face and body.', 
    FALSE
),
(
    116418, 
    'ALEJON CORRECTIVE FOUND(1 FAIR) SPF50 30ML', 
    'أليجون كريم أساس تصحيحي درجة فايير واقي شمس SPF50 بحجم 30 مل', 
    410.00, 410.00, 'COSMO-MI', 'ALEJON',
    'Sun_Protection', 
    'tinted_facial_sunscreen', 
    'Corrective foundation cream in shade Fair providing high broad-spectrum SPF50 coverage.', 
    FALSE
),
(
    117775, 
    'ALEJON ROLL-ON FRAGRANCE+ORIENTAL 50ML عرض', 
    'أليجون مجموعة مزيل عرق رول أون عطرية + أورينتال 50 مل', 
    300.00, 300.00, 'COSMO-MI', 'ALEJON',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Promotional double bundle set (1+1) containing fragrance and oriental roll-on deodorants.', 
    TRUE
),
(
    117779, 
    'ALEJON ROLL-ON MIDNIGHT+CHAMPION 50ML عرض', 
    'أليجون مجموعة مزيل عرق رول أون ميدنايت + تشامبيون 50 مل', 
    300.00, 300.00, 'COSMO-MI', 'ALEJON',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Promotional double bundle set (1+1) containing Midnight and Champion roll-on deodorants.', 
    TRUE
),
(
    117778, 
    'ALEJON ROLL-ON MIDNIGHT+FRAGRANCE 50ML عرض', 
    'أليجون مجموعة مزيل عرق رول أون ميدنايت + عطرية 50 مل', 
    300.00, 300.00, 'COSMO-MI', 'ALEJON',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Promotional double bundle set (1+1) containing Midnight and Fragrance roll-on deodorants.', 
    TRUE
),
(
    117777, 
    'ALEJON ROLL-ON ORIENTAL+CHAMPION 50ML عرض', 
    'أليجون مجموعة مزيل عرق رول أون أورينتال + تشامبيون 50 مل', 
    300.00, 300.00, 'COSMO-MI', 'ALEJON',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Promotional double bundle set (1+1) containing Oriental and Champion roll-on deodorants.', 
    TRUE
),
(
    117776, 
    'ALEJON ROLL-ON ORIENTAL+MIDNIGHT 50ML عرض', 
    'أليجون مجموعة مزيل عرق رول أون أورينتال + ميدنايت 50 مل', 
    300.00, 300.00, 'COSMO-MI', 'ALEJON',
    'NEEDS_REVIEW', 
    'NEEDS_REVIEW', 
    'Promotional double bundle set (1+1) containing Oriental and Midnight roll-on deodorants.', 
    TRUE
),
(
    144015, 
    'ALEJON SPRAY HAIR LOTION ANTI-DANDRUFF 150ML #C#', 
    'أليجون بخاخ لوشن معالج ومضاد للقشرة لفروة الرأس 150 مل', 
    310.00, 310.00, 'COSMO-MI', 'ALEJON',
    'Hair_Scalp_Care', 
    'scalp_treatment_leave_in', 
    'Anti-dandruff scalp treatment spray lotion designed to clear flakes and soothe scalp.', 
    FALSE
),
(
    116421, 
    'ALEJON SPRAY BI-PHASE COLLAGEN 200ML', 
    'أليجون بخاخ ثنائي الطبقات بالكولاجين المرطب للشعر 200 مل', 
    295.00, 295.00, 'COSMO-MI', 'ALEJON',
    'Hair_Scalp_Care', 
    'scalp_treatment_leave_in', 
    'Bi-phase collagen hydrating leave-in hair spray for strand softening and protection.', 
    FALSE
),
(
    116925, 
    'ALEJON SUN SPRAY SPF50 ALL 250ML #C# عرض', 
    'أليجون بخاخ واقي شمس لجميع الأجسام SPF50 بحجم 250 مل', 
    575.00, 575.00, 'COSMO-MI', 'ALEJON',
    'Sun_Protection', 
    'sunscreen_spray_mist', 
    'Broad-spectrum body sunscreen spray mist providing SPF50 protection.', 
    FALSE
),
(
    115819, 
    'ALEJON#ع# (10%)UREA CREAM SHEA 200G', 
    'أليجون كريم مرطب باليوريا 10% وزبدة الشيا 200 جرام', 
    380.00, 380.00, 'COSMO-MI', 'ALEJON',
    'Skin_Moisturization_Barrier', 
    'barrier_repair_hydrator', 
    'Deeply moisturizing 10% Urea and Shea Butter cream formulated for dry skin barrier restoration.', 
    FALSE
),
(
    109918, 
    'ALEJON#ع# ALOE VERA PEEL-OFF FACIAL MASK 125ML', 
    'أليجون قناع مقشر ومنظف للوجه بالصبار 125 مل', 
    220.00, 220.00, 'COSMO-MI', 'ALEJON',
    'Skin_Cleansing', 
    'soothing_cleansing_gel', 
    'Soothing Aloe Vera peel-off face mask for skin cleansing and impurity removal.', 
    FALSE
),
(
    108815, 
    'ALEJON#ع#ANTI-HAIR LOSS VIALS(15X3ML)', 
    'أليجون أمبولات معالجة ومضادة لتساقط الشعر 15 أمبولة × 3 مل', 
    790.00, 790.00, 'COSMO-MI', 'ALEJON',
    'Hair_Scalp_Care', 
    'scalp_treatment_leave_in', 
    'Intensive anti-hair loss scalp vials formulated to strengthen roots and reduce thinning.', 
    FALSE
);
