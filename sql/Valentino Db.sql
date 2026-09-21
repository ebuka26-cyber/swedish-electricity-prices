ALTER TABLE panel_hourly ADD COLUMN wind_decile INTEGER;

UPDATE panel_hourly p
SET wind_decile = d.nt
FROM (
  SELECT ts_utc, ZONE,
         NTILE(10) OVER (ORDER BY wind_onshore_mw) AS nt
  FROM panel_hourly
) d
WHERE p.ts_utc = d.ts_utc AND p.zone = d.zone;