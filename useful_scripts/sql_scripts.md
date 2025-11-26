## Check current database permissions

Used to check current database permissions and role memberships for principals (external users/groups and SQL users).

Run this query in the context of the target database (e.g., in SSMS, Azure Data Studio or the SQL editor in Databricks SQL).

```sql
SELECT
    p.name AS principal_name,
    p.type_desc AS principal_type,
    r.name AS role_name
FROM sys.database_principals p
LEFT JOIN sys.database_role_members m ON p.principal_id = m.member_principal_id
LEFT JOIN sys.database_principals r ON m.role_principal_id = r.principal_id
WHERE p.type_desc IN ('EXTERNAL_USER', 'EXTERNAL_GROUP', 'SQL_USER')
ORDER BY principal_name;
```

## Assign Managed Identity Access to the Database
```sql
-- Switch to your target database
USE "sqldbFinance";
GO

-- Create a contained user for the Databricks managed identity
CREATE USER "[system assigned managed identity]" FROM EXTERNAL PROVIDER;
GO

-- Grant read access to the staging schema (or specific table)
GRANT SELECT ON SCHEMA::stg TO "[system assigned managed identity]";
-- Or more narrowly:
-- GRANT SELECT ON OBJECT::[stg].[prices_raw] TO [databricks-myworkspace];
GO

```