CREATE TABLE IF NOT EXISTS stores (
    store_id BIGSERIAL PRIMARY KEY,
    store_name VARCHAR(150) NOT NULL,
    sido VARCHAR(50),
    sigungu VARCHAR(50),
    address VARCHAR(500) NOT NULL,

    latitude DECIMAL(10, 7) NOT NULL,
    longitude DECIMAL(10, 7) NOT NULL,

    location geography(Point, 4326)
        GENERATED ALWAYS AS (
            ST_SetSRID(
                ST_MakePoint(
                    longitude::double precision,
                    latitude::double precision
                ),
                4326
            )::geography
        ) STORED,

    phone_number VARCHAR(30),
    business_hours TEXT,
    is_active BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP,

    CONSTRAINT uq_stores_name_address UNIQUE (store_name, address)
);

CREATE INDEX IF NOT EXISTS idx_stores_location
ON stores USING GIST (location);
