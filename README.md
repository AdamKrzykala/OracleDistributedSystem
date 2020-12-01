FOR EACH INSTANCE CALL FIRSTLY:
	1. Common db_init.sql
	2. Individual db_init.sql
	
FOR EACH INSTANCE CALL SECONDLY:
	1. Common db_procedures&functions.sql
	2. Common db_views.sql
	3. Common db_data.sql

DISTRIBUTED MECHANISMS:

DONE:
	partitioned vehicles,
	partitioned rentals

TO DO:	
	partitioned returns, 
	replicated master-master sequences and triggers, 
	replicated multimaster clients,
	replicated multimaster addresses,
	replicated multimaster,
	locally partitioned clients 