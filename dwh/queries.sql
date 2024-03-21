CREATE OR REPLACE EXTERNAL TABLE zoomcamp-final-project-416709.earthquake_dataset.earthquake_external
WITH PARTITION COLUMNS (
  event_date DATE
)
OPTIONS (
 format = 'PARQUET',
 uris = ['gs://zoomcamp-final-project-416709-bucket/earthquake_data/*'],
 hive_partition_uri_prefix = 'gs://zoomcamp-final-project-416709-bucket/earthquake_data',
 require_hive_partition_filter = false
);

CREATE OR REPLACE TABLE zoomcamp-final-project-416709.earthquake_dataset.earthquake
PARTITION BY event_date
CLUSTER BY magnitude_class AS
SELECT *,
  CASE
    WHEN (mag>=3 AND mag<4) THEN 'Minor'
    WHEN (mag>=4 AND mag<5) THEN 'Light'
    WHEN (mag>=5 AND mag<6) THEN 'Moderate'
    WHEN (mag>=6 AND mag<7) THEN 'Strong'
    WHEN (mag>=7 AND mag<8) THEN 'Major'
    WHEN (mag>=8) THEN 'Great'
    ELSE 'Unclassified'
    END
    AS magnitude_class
FROM zoomcamp-final-project-416709.earthquake_dataset.earthquake_external;
