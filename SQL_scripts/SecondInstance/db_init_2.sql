--SECOND DB INDIVIDUAL INIT----------------------------------------------------------

--Vehicle id insertion trigger creating
CREATE OR REPLACE TRIGGER pojazdy_on_insert
  BEFORE INSERT ON pojazdy
  FOR EACH ROW
BEGIN
  SELECT VEHICLE_ID_SEQUENCE.nextval@WYPOZYCZALNIA_ADAM --This sequence must be replicated
  INTO :new.ID_Pojazdu
  FROM dual;
END;
/

--Rentals id insertion trigger creating
CREATE OR REPLACE TRIGGER wypozyczenia_on_insert
  BEFORE INSERT ON wypozyczenia
  FOR EACH ROW
BEGIN
  SELECT RENTALS_ID_SEQUENCE.nextval@WYPOZYCZALNIA_ADAM --This sequence must be replicated
  INTO :new.ID_Wypozyczenia
  FROM dual;
END;
/

--Returns id insertion trigger creating
CREATE OR REPLACE TRIGGER zwroty_on_insert
  BEFORE INSERT ON zwroty
  FOR EACH ROW
BEGIN
  SELECT RETURNS_ID_SEQUENCE.nextval@WYPOZYCZALNIA_ADAM --This sequence must be replicated
  INTO :new.ID_Zwrotu
  FROM dual;
END;
/

--Creating remote database synonym to rentalHouses on server
CREATE OR REPLACE PUBLIC SYNONYM serverWypozyczalnie FOR wypozyczalnie@WYPOZYCZALNIA_ADAM;

--Snapshot of rentalHouses for slave
CREATE SNAPSHOT WypozyczalnieServer
BUILD IMMEDIATE 
REFRESH FAST AS
SELECT * FROM serverWypozyczalnie;

--Creating remote database synonym to models on server
CREATE OR REPLACE PUBLIC SYNONYM serverModels FOR modele@WYPOZYCZALNIA_ADAM;

--Snapshot of models for slave
CREATE SNAPSHOT ModeleServer
BUILD IMMEDIATE 
REFRESH FAST AS
SELECT * FROM serverModels;

--Creating remote refresh group synonym to rentalHousesRefreshGroup
CREATE OR REPLACE PUBLIC SYNONYM remoteRentalHousesRefreshGroup 
    FOR rentalHousesRefreshGroup@WYPOZYCZALNIA_ADAM;

--Creating remote refresh group synonym to modelsRefreshGroup
CREATE OR REPLACE PUBLIC SYNONYM remoteModelsRefreshGroup
    FOR modelsRefreshGroup@WYPOZYCZALNIA_ADAM;

--Adding snapshots to refresh group on server
DBMS_REFRESH.ADD(name=>'rentalHousesRefreshGroup@WYPOZYCZALNIA_ADAM', 
                    list=>'WypozyczalnieServer');
                    
DBMS_REFRESH.ADD(name=>'modelsRefreshGroup@WYPOZYCZALNIA_ADAM', 
                    list=>'ModeleServer');

--Creating remote database synonym to pojazdy
CREATE OR REPLACE PUBLIC SYNONYM remoteVehicles FOR pojazdy@WYPOZYCZALNIA_ADAM;

--Creating remote database synonym to wypozyczenia
CREATE OR REPLACE PUBLIC SYNONYM remoteRentals FOR wypozyczenia@WYPOZYCZALNIA_ADAM;

--Creating remote database synonym to zwroty
CREATE OR REPLACE PUBLIC SYNONYM remoteReturns FOR zwroty@WYPOZYCZALNIA_ADAM;

COMMIT;
