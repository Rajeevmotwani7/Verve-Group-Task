WITH
  cte AS (
  SELECT
    app,
    bid_price,
    sum(events) AS total_events
  FROM
    `xgybmv1to7ub.clustering.verve_data`
  GROUP BY
    app,
    bid_price ),
  cte1 AS (
  SELECT
    app,
    bid_price,
    events
  FROM
    `xgybmv1to7ub.clustering.verve_data`
  WHERE
    win = 1 )
SELECT
  app,
  bid_price,
  cte1.events,
  cte.total_events,
  (events/total_events)*100 as win_rate,
  bid_price*events as revenue
FROM
  cte
JOIN
  cte1
USING
  (app,
    bid_price)