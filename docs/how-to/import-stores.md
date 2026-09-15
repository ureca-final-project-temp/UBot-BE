## 매장 데이터 적재

PostgreSQL 컨테이너가 실행 중인 상태에서 Store 테이블을 생성합니다.

```powershell
Get-Content infra/postgres/store-schema.sql | docker compose exec -T postgres psql -U ubot -d ubot
```

CSV 파일을 PostgreSQL 컨테이너로 복사합니다.

```powershell
docker compose cp infra/postgres/data/lgu_stores_all_final.csv postgres:/tmp/lgu_stores_all_final.csv
```

처음 적재하는 경우 매장 데이터를 적재합니다.

```powershell
Get-Content infra/postgres/import-stores.sql | docker compose exec -T postgres psql -U ubot -d ubot
```

기존 Store 데이터를 새 CSV로 다시 적재하려면 먼저 기존 데이터를 비운 뒤 다시 적재합니다.

```powershell
docker compose exec -T postgres psql -U ubot -d ubot -c "TRUNCATE TABLE store RESTART IDENTITY;"
docker compose cp infra/postgres/data/lgu_stores_all_final.csv postgres:/tmp/lgu_stores_all_final.csv
Get-Content infra/postgres/import-stores.sql | docker compose exec -T postgres psql -U ubot -d ubot
```

적재 결과를 확인합니다.

```powershell
docker compose exec postgres psql -U ubot -d ubot
```

```sql
SELECT COUNT(*) FROM store;

SELECT
    id,
    name,
    address,
    phone,
    longitude,
    latitude,
    ST_AsText(location::geometry) AS location
FROM store
ORDER BY id
LIMIT 5;
```
