gui: createdb umami
psql: CREATE ROLE umami WITH LOGIN PASSWORD 'password';
psql: GRANT ALL PRIVILEGES ON DATABASE umami TO umami;
psql: \c umami to select the umami database
psql: CREATE EXTENSION IF NOT EXISTS pgcrypto;
psql: GRANT ALL PRIVILEGES ON SCHEMA public TO umami;
 
DATABASE_URL: postgresql://umami:pass@psqldb-sc-umami-lab-01.postgres.database.azure.com:5432/umami?sslmode=require

admin
umami