
# dbt + Snowflake-managed Iceberg starter

This repo is a minimal, working scaffold where **dbt reads Snowflake-managed Iceberg tables** as sources and **writes the transformed output as another managed Iceberg table**.

## What you get
- `catalogs.yml` wired for **Iceberg catalog integration** (Snowflake built-in catalog + external volume).
- Example sources (`orders_ice`, `customers_ice`) assumed to be **managed Iceberg** tables.
- A sample incremental model (`fct_orders_ice.sql`) that **creates/writes an Iceberg table** via dbt.
- Basic tests and docs.

> ⚠️ Versioning: use **dbt-core/dbt-snowflake ≥ 1.9**. Iceberg catalog integrations and model configs changed recently—if you’re pinned to older versions, use the legacy `table_format: 'iceberg'` config on models.

## Quickstart

1. Install deps:
   ```bash
   python -m venv .venv && source .venv/bin/activate
   pip install dbt-core==1.9.* dbt-snowflake==1.9.*
   ```

2. Copy **profiles.yml** to your `~/.dbt/profiles.yml` (or set `DBT_PROFILES_DIR` to this folder) and fill in connection values.

3. Validate connection:
   ```bash
   dbt debug
   ```

4. Pull packages (none required by default):
   ```bash
   dbt deps
   ```

5. Test compile + run:
   ```bash
   dbt run --select fct_orders_ice
   dbt test
   ```

## Files to edit

- `catalogs.yml` → set **`external_volume`** and confirm `catalog_type: built_in` for Snowflake-managed Iceberg, or configure **REST/Open Catalog** if you need cross-engine access.
- `dbt_project.yml` → set your **database**, **schema**, and defaults.
- `profiles.yml` → set **account/user/role/warehouse/auth**.
- `models/sources.yml` → point to your **existing managed Iceberg** source tables.
- `models/fct_orders_ice.sql` → tweak logic and keys.

## References
- dbt Snowflake Iceberg support & catalogs: https://docs.getdbt.com/docs/mesh/iceberg/snowflake-iceberg-support
- About Iceberg catalogs in dbt: https://docs.getdbt.com/docs/mesh/iceberg/about-catalogs
- Snowflake catalog integrations (managed/external): https://docs.snowflake.com/en/user-guide/tables-iceberg-configure-catalog-integration
