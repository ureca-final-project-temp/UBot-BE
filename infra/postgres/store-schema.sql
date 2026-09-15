CREATE TABLE IF NOT EXISTS store (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    sido VARCHAR(30) NOT NULL,
    sigungu VARCHAR(50) NOT NULL,
    address VARCHAR(255) NOT NULL,
    phone VARCHAR(30),

    longitude DOUBLE PRECISION NOT NULL,
    latitude DOUBLE PRECISION NOT NULL,

    location geography(Point, 4326)
        GENERATED ALWAYS AS (
            ST_SetSRID(
                ST_MakePoint(longitude, latitude),
                4326
            )::geography
        ) STORED,

    CONSTRAINT uq_store_name_address UNIQUE (name, address)
);

CREATE INDEX IF NOT EXISTS idx_store_location
ON store USING GIST (location);