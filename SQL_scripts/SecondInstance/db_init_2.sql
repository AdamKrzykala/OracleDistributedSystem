--SECOND DB INDIVIDUAL INIT----------------------------------------------------------

--External database link creating
CREATE DATABASE LINK WYPOZYCZALNIA_ADAM 
    CONNECT TO c##adam 
    IDENTIFIED BY adam 
    USING 'ORCLADAM';
    
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

--Creating remote database synonym to pojazdy
CREATE OR REPLACE PUBLIC SYNONYM remoteVehicles FOR pojazdy@WYPOZYCZALNIA_ADAM;
