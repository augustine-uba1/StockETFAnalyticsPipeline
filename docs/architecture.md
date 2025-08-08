# Architecture Diagram

```mermaid
---
config:
      theme: forest
---
graph LR
 subgraph BUILD[**Build and Release Stages**]
    INFRA["Infra Pipeline<br/>(Deploy ARM Templates)"] --> ETL["ETL Pipeline<br/>(Deploy ADF + Notebooks)"]
    ETL --> TEST["Smoke Test<br/>(check SQL + Delta tables)"]
    TEST --> RELNOTE[Generate Release Notes]
    RELNOTE --> EMAIL[Email Release Notes to Stakeholders]
 end

 subgraph **Data Flow Chart**
  API["Stock API (Alpha Vantage)"] --> SQL[("Azure SQL<br/>stg.prices_raw")]
  SQL --> DBXJOB[Databricks Job<br/> Raw → Bronze → Silver → Gold]
  DBXJOB --> BRZ[(Delta Table<br/>bronze.prices_raw)]
  DBXJOB --> SLV[(Delta Table<br/>silver.prices)]
  DBXJOB --> GLD[(Delta Table<br/>gold.indicators)]
  GLD --> DSQL[Databricks SQL Warehouse]
  DSQL --> PBI[Power BI Dashboard]
 end
