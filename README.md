FOR EACH INSTANCE CALL FIRSTLY:
	1. Common db_init.sql
	2. Individual db_init.sql
	
FOR EACH INSTANCE CALL SECONDLY:
	1. Common db_views.sql
	2. Common db_procedures&functions.sql
	3. Common db_data.sql

DISTRIBUTED MECHANISMS:

DONE:
	partitioned vehicles,
	partitioned rentals,
	partitioned returns

TO DO:	
	replicated snapshots models, 
	replicated snapshots rentalHouses,
	replicated multimaster clients,
	replicated multimaster addresses,
	locally partitioned clients 