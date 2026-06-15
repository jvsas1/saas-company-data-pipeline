# SaaS Company Data Pipeline

A hands-on data engineering project where I built an ELT pipeline from scratch — ingesting raw SaaS customer data, loading it into a warehouse, and transforming it into analytics-ready tables with dbt.

The goal was to learn the modern data stack by building something real, end to end.

## What it does

Raw CSV files go in, clean business metrics come out. Along the way:

- Python reads the CSVs and loads them into PostgreSQL (local) and BigQuery (cloud)
- dbt transforms the data through three layers — Bronze, Silver and Gold
- The Gold layer feeds a Tableau dashboard with churn, revenue and support metrics

The same dbt code runs locally on PostgreSQL during development and on BigQuery in production — just by switching the target.

## Stack

Python · dbt Core · Docker · PostgreSQL · Google BigQuery · Tableau

## How the data is organized

I followed the Medallion Architecture, which splits the transformation into three layers:

- **Bronze** — raw data, untouched, just exposed for dbt to track
- **Silver** — cleaned up: types fixed, nulls handled, tables joined
- **Gold** — the final metrics, aggregated and ready for dashboards

The Gold layer has four models: churn summary, MRR by plan, support performance, and a customer overview.

## Running it yourself

You'll need Python 3.12+, Docker, and a Google Cloud project with BigQuery enabled.

```bash
# clone and enter the project
git clone https://github.com/jvsas1/saas-company-data-pipeline.git
cd saas-company-data-pipeline

# set up your environment variables
cp .env.example .env   # then fill in your own values

# start PostgreSQL
docker-compose up -d

# run the ingestion pipeline
python py_scripts/main.py

# run the transformations
cd transformation_layer
dbt run                  # local (PostgreSQL)
dbt run --target prod    # cloud (BigQuery)
```

To explore the lineage graph and docs: 



```bash
dbt docs generate --target prod
dbt docs serve
```

## Dashboard

Built in Tableau on top of the Gold layer in BigQuery. *Link coming soon.*

