# RevOps Analytics

Revenue analysis and monitoring project built with dbt and DuckDB to track company's ARR health, monthly trends, and churn.

## Models

### Staging
- **stg_deals** — cleans and standardizes raw deal data (type casting, column renaming)

### Marts
- **mart_revenue** — tracks Closed Won deal performance with cumulative ARR over time and ranking by segment
- **mart_arr_movement** — month-over-month ARR delta showing revenue trends
- **mart_churn** — renewal-based churn analysis showing churned ARR and churn rate
- **mart_first_deals_by_segment** — first Closed Won deal per segment using ROW_NUMBER()
- **mart_pipeline_summary** — monthly pipeline overview with Enterprise ARR share
- **mart_account_ranking** — top accounts by Closed Won ARR with NTILE(2) percentile ranking
- **mart_deal_profile** — deals with extended account and contact details 
- **mart_arr_trend** - month-over-month ARR delta showing revenue trends (previous and next months)x



## Data Quality
9 automated tests covering: `unique`, `not_null`, `accepted_values`, and conditional `not_null` for optional fields.

## Tech Stack
- dbt Core 1.11
- DuckDB
- SQL
- Git / GitHub

## How to Run
```bash
# Run all models
dbt run

# Run data quality tests
dbt test
```

## Project Structure
```
models/
  staging/    # source cleaning and standardization
  marts/      # business logic and metrics
seeds/        # sample deal data (CSV)
```

## Notes
Built as a learning project to develop RevOps analytics skills. 
Developed with the assistance of Claude (Anthropic) as a coding mentor.