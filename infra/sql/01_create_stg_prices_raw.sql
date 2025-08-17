IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = 'stg')
BEGIN
  EXEC('CREATE SCHEMA stg');
END;

IF OBJECT_ID(N'stg.prices_raw', N'U') IS NULL
BEGIN
  CREATE TABLE stg.prices_raw (
    load_id           UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID(),
    load_ts_utc       DATETIME2(0)     NOT NULL DEFAULT SYSUTCDATETIME(),
    source_system     VARCHAR(50)      NOT NULL DEFAULT 'AlphaVantage',
    symbol            VARCHAR(20)      NOT NULL,
    price_date        DATE             NOT NULL,
    open_price        DECIMAL(18,6)    NULL,
    high_price        DECIMAL(18,6)    NULL,
    low_price         DECIMAL(18,6)    NULL,
    close_price       DECIMAL(18,6)    NULL,
    volume            BIGINT           NULL,
    CONSTRAINT PK_prices_raw PRIMARY KEY (symbol, price_date, load_id)
  );
END;
