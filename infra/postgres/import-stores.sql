\copy store (name, sido, sigungu, address, phone, longitude, latitude) FROM '/tmp/lgu_stores_all_final.csv' WITH (FORMAT csv, HEADER true, ENCODING 'UTF8');
