# From the Deep

In this problem, you'll write freeform responses to the questions provided in the specification.

## Random Partitioning

A major advantage of this approach is that data is distributed evenly, preventing any single vessel or node from running out of storage space or becoming overwhelmed by an excessive number of write operations. However, its primary drawback is inefficiency during read operations, to query a specific time range, the researcher must execute the query across all vessels simultaneously, which leads to excessive consumption of network resources and processing time.

## Partitioning by Hour

This design drastically optimizes time-range queries, as it allows a researcher to connect to a single "ship" to retrieve all records for a specific hour without burdening the rest of the network. The critical drawback is the creation of bottlenecks (known as "data skew" or "hotspots"): since most observations occur in the early morning hours, "Ship A" will become saturated with data and collapse, while the other ships will remain virtually empty.

## Partitioning by Hash Value

Hash partitioning ensures an even distribution of storage across the nodes and allows for the instant retrieval of a specific record by querying a single node—provided the exact timestamp is known. A drawback is that this method destroys the physical chronological order of the data; when searching for a continuous time range, the records will be scattered randomly, once again necessitating a query across all nodes.
