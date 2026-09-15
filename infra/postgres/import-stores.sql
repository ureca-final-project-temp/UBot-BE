CREATE TEMP TABLE store_import (
    name VARCHAR(150),
    sido VARCHAR(50),
    sigungu VARCHAR(50),
    address VARCHAR(500),
    phone VARCHAR(30),
    longitude DECIMAL(10, 7),
    latitude DECIMAL(10, 7)
);

\copy store_import (name, sido, sigungu, address, phone, longitude, latitude) FROM '/tmp/lgu_stores_all_final.csv' WITH (FORMAT csv, HEADER true, ENCODING 'UTF8');

INSERT INTO stores (
    store_name,
    sido,
    sigungu,
    address,
    phone_number,
    longitude,
    latitude
)
SELECT
    name,
    sido,
    sigungu,
    address,
    NULLIF(phone, ''),
    longitude,
    latitude
FROM store_import
WHERE name IS NOT NULL
  AND address IS NOT NULL
  AND longitude IS NOT NULL
  AND latitude IS NOT NULL
ON CONFLICT (store_name, address) DO UPDATE
SET sido = EXCLUDED.sido,
    sigungu = EXCLUDED.sigungu,
    phone_number = EXCLUDED.phone_number,
    longitude = EXCLUDED.longitude,
    latitude = EXCLUDED.latitude,
    updated_at = CURRENT_TIMESTAMP;

DROP TABLE store_import;
