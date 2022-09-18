# Verve-Group-Task
This repository contains the solution for the verve group DS task.

# Solution
## *Assumption*

Here, I work on the data with the assumption that for each bid_price the events with win type 0 and 1 sum up to be the total events. For example, for the bid_price 9 we participated in only 1 auction.

## *Please Note*

The sql query for the task is written in Google cloud Bigquery. The json data was uploaded to the table in BQ and used for the calcuation purposes.

## *Win Rate*
**Calculation for win-rate is based on following formula:**

```
Win Rate = Win events / Total events * 100
 
Total events = Win events + Loss events
```
Please find win-rate.sql file attached.


#### *Problem 2*

In order to increase the revenue, I would bid for the price that has a bitter win-rate. But we cannot simply select the best win rate, we must also look at the event count. For example bid price of 9$ has only 1 event whereas bid_price of 0.2 has 10 million events. Hence, I remove those bid prices that either have too many events or not enough events manually. This process is called outlier removal.

#### *Outlier Removal Process:*

Here, for outlier removal, I am using Inter Quantile Range(IQR) where

Q1 = first quartile
Q3 = third quartile
IQR = Q3 - Q1

As a result the final table that I get is as below.

**Table 1. Win Rate Data for application A**

|    | app   |   bid_price |   events |   total_events | win rate |
|---:|:------|------------:|---------:|---------------:|---------:|
|  0 | A     |        0.01 |        0 |         100000 |      0.0 |
|  0 | A     |        0.10 |     3000 |          10000 |     30.0 |
|  0 | A     |        0.50 |    20000 |         100000 |     20.0 |
|  0 | A     |        0.75 |     3000 |          10000 |     30.0 |
|  0 | A     |        1.00 |      600 |           1000 |     60.0 |

Based on the above table, a bid price of 1.0$ would be the most optimal choice in order to increase revenue.

Please find attached jupyter notebook for outlier removal.
