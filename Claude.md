إليك الترتيب الاحترافي الكامل — مبني على **ترتيب الاعتماديات (dependency order)**، وموحّد فيه الـ naming conventions والـ audit pattern مع الجداول اللي بنيناها قبل كده (`row_version`, soft delete, comments).

## 1. الأساسيات (Schemas + Extensions) — أول حاجة تتنفذ

```sql
CREATE SCHEMA IF NOT EXISTS product;
CREATE SCHEMA IF NOT EXISTS drug;
CREATE SCHEMA IF NOT EXISTS inventory;
CREATE SCHEMA IF NOT EXISTS silver;

CREATE EXTENSION IF NOT EXISTS pg_trgm;
CREATE EXTENSION IF NOT EXISTS btree_gist;
```

## 2. Lookup/Reference Tables (مفيش عليها dependencies)

```sql
CREATE TABLE product.product_type (
    type_id     SMALLINT     PRIMARY KEY,
    type_name   VARCHAR(50)  NOT NULL UNIQUE,
    CONSTRAINT chk_type_name CHECK (type_name IN
        ('drug','paramedical','cosmo_medical','cosmetic',
         'beauty_tool','sports_equipment','medical_device'))
);
COMMENT ON TABLE product.product_type IS
    'Fixed, small set of structural product types — drives which *_attributes extension table applies.';

CREATE TABLE drug.manufacturer (
    manufacturer_id   BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    manufacturer_name VARCHAR(255) NOT NULL UNIQUE,
    country           VARCHAR(100),
    is_active         BOOLEAN NOT NULL DEFAULT TRUE
);
```

**ليه اتقدّم:** كل جدول تاني (`product`, `device_attributes`, `generic_drug`) هيعمل عليهم `REFERENCES` — لازم يتخلقوا الأول عشان الـ FK يشتغل.

## 3. Category — هرمي، محتاج self-reference

```sql
CREATE TABLE product.category (
    category_id         BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    parent_category_id  BIGINT REFERENCES product.category(category_id),
    category_name_ar    VARCHAR(255) NOT NULL,
    display_order        INTEGER      NOT NULL DEFAULT 0,
    is_active             BOOLEAN      NOT NULL DEFAULT TRUE,

    CONSTRAINT uq_category_sibling UNIQUE (parent_category_id, category_name_ar)
);
CREATE INDEX idx_category_parent ON product.category(parent_category_id);
COMMENT ON CONSTRAINT uq_category_sibling ON product.category IS
    'Prevents duplicate category names under the same parent (e.g. two "كريمات" under the same section).';
```

**إضافة احترافية:** ضفت `uq_category_sibling` — مكنش موجود في نسختك الأصلية، وده بيمنع غلطة شائعة (تصنيف مكرر بنفس الاسم تحت نفس الأب).

## 4. Drug Generic Reference (قبل الـ extension tables اللي بتشاور عليه)

```sql
CREATE TABLE drug.generic_drug (
    generic_id          BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    generic_name_en     VARCHAR(255) NOT NULL,
    generic_name_ar     VARCHAR(255) NOT NULL,
    atc_code            VARCHAR(20),
    eda_formulary_code  VARCHAR(50) UNIQUE,
    dosage_form         VARCHAR(50),
    strength            VARCHAR(50),
    is_controlled       BOOLEAN NOT NULL DEFAULT FALSE,
    created_at          TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at          TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX idx_generic_name_ar_trgm ON drug.generic_drug
    USING gin (generic_name_ar gin_trgm_ops);   -- يخدم الـ Drug Matching Engine مباشرة

CREATE TRIGGER set_updated_at
BEFORE UPDATE ON drug.generic_drug
FOR EACH ROW EXECUTE FUNCTION product.trg_set_updated_at();
```

## 5. product.product

*(اتبنى قبل كده — هنا بس بالترتيب الصحيح ضمن السكريبت الكامل، لأنه بيحتاج `product_type` و`category` جاهزين الأول)*

## 6. Extension Tables (Class Table Inheritance) — بعد product.product

```sql
CREATE TABLE product.drug_attributes (
    product_id          BIGINT PRIMARY KEY REFERENCES product.product(product_id) ON DELETE CASCADE,
    generic_id          BIGINT NOT NULL REFERENCES drug.generic_drug(generic_id),
    eda_formulary_code  VARCHAR(50),
    is_controlled       BOOLEAN NOT NULL DEFAULT FALSE
);

CREATE TABLE product.cosmo_medical_attributes (
    product_id            BIGINT PRIMARY KEY REFERENCES product.product(product_id) ON DELETE CASCADE,
    active_ingredient     VARCHAR(255),
    skin_condition_target VARCHAR(255)
);

CREATE TABLE product.device_attributes (
    product_id                BIGINT PRIMARY KEY REFERENCES product.product(product_id) ON DELETE CASCADE,
    manufacturer_id           BIGINT REFERENCES drug.manufacturer(manufacturer_id),
    warranty_months            INTEGER CHECK (warranty_months IS NULL OR warranty_months >= 0)
    -- requires_serial_tracking اتشال من هنا — موجود بالفعل في product.product
    -- تكراره هنا كان بيسبب "two sources of truth" لنفس القرار
);

CREATE TABLE product.cosmetic_attributes (
    product_id        BIGINT PRIMARY KEY REFERENCES product.product(product_id) ON DELETE CASCADE,
    shade_or_variant  VARCHAR(100)
);
```

**تصحيح احترافي مهم:** شلت `requires_serial_tracking` من `device_attributes` لأنه أصلاً موجود في `product.product` (الجدول الأساسي). لو سبتها في الاتنين، هتبقى عندك **two sources of truth** لنفس القرار — ولو يوم اختلفوا (واحد TRUE والتاني FALSE) هتبقى في مشكلة تكامل بيانات بلا داعي. القاعدة: أي flag بيوجّه الـ application logic (زي gating) مكانه الجدول الأساسي بس.

### إنفاذ الـ Polymorphism من الـ DB نفسه (إضافة enterprise)

```sql
CREATE OR REPLACE FUNCTION product.trg_enforce_type_consistency()
RETURNS TRIGGER AS $$
DECLARE
    v_type_name VARCHAR(50);
BEGIN
    SELECT pt.type_name INTO v_type_name
    FROM product.product p JOIN product.product_type pt ON pt.type_id = p.type_id
    WHERE p.product_id = NEW.product_id;

    IF TG_TABLE_NAME = 'drug_attributes' AND v_type_name != 'drug' THEN
        RAISE EXCEPTION 'product_id % is not of type drug', NEW.product_id;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
-- نفس المنطق يتكرر (أو يتعمم بـ TG_ARGV) لباقي جداول الـ attributes
```
ده بيمنع غلطة إنسانية شائعة: حد يحط صف في `cosmetic_attributes` لمنتج نوعه `type_id = drug` بالغلط.

## 7. Clinical Info (Bronze/Gold) + SCD (Silver)

```sql
CREATE TABLE drug.drug_clinical_info (
    generic_id          BIGINT PRIMARY KEY REFERENCES drug.generic_drug(generic_id),
    indications         TEXT,
    side_effects        TEXT,
    contraindications   TEXT,
    dosage_instructions TEXT,
    warnings            TEXT,
    source              VARCHAR(100) NOT NULL,
    last_updated_at     TIMESTAMPTZ NOT NULL DEFAULT now(),
    CONSTRAINT chk_source CHECK (source IN ('EDA formulary','manufacturer insert','LLM extraction'))
);

CREATE TABLE silver.drug_clinical_info_scd (
    scd_id            BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    generic_id        BIGINT       NOT NULL REFERENCES drug.generic_drug(generic_id),
    indications       TEXT,
    side_effects      TEXT,
    contraindications TEXT,
    match_confidence  NUMERIC(5,2) CHECK (match_confidence BETWEEN 0 AND 100),
    source_file       VARCHAR(255),
    effective_from    TIMESTAMPTZ  NOT NULL,
    effective_to      TIMESTAMPTZ,
    is_current        BOOLEAN      NOT NULL DEFAULT TRUE
);

-- يضمن صف "current" واحد بس لكل generic_id — كان ناقص في النسخة الأصلية
CREATE UNIQUE INDEX uq_scd_one_current ON silver.drug_clinical_info_scd(generic_id)
    WHERE is_current = TRUE;

CREATE INDEX idx_scd_generic_history ON silver.drug_clinical_info_scd(generic_id, effective_from);
```

**تصحيحات احترافية هنا:**
1. أضفت `PRIMARY KEY (scd_id)` — الجدول الأصلي مكنش ليه أي مفتاح، وده مشكلة في جدول SCD بالذات (مينفعش يبقى فيه صفوف مكررة تمامًا بلا identity).
2. `uq_scd_one_current` partial unique index — بيمنع غلطة إن يبقى فيه صفين `is_current = TRUE` لنفس الـ generic_id في نفس الوقت (ده باغ شائع جدًا في تصميمات SCD Type 2).

## الترتيب النهائي للتنفيذ (Execution Order)

```
1. CREATE SCHEMA (product, drug, inventory, silver) + extensions
2. product.product_type
3. drug.manufacturer
4. product.category
5. drug.generic_drug
6. product.product          (يعتمد على 2، 4)
7. product.drug_attributes, cosmo_medical_attributes,
   device_attributes, cosmetic_attributes   (تعتمد على 5، 6، 3)
8. drug.drug_clinical_info   (يعتمد على 5)
9. silver.drug_clinical_info_scd  (يعتمد على 5)
```

عايز أضيفلك سكريبت `rollback` (DROP بالترتيب العكسي) كمان، عشان تقدر تعمل migration آمن في بيئة الـ staging قبل production؟
