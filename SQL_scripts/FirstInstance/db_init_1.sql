--FIRST DB INDIVIDUAL INIT----------------------------------------------------------

--External database link creating
CREATE DATABASE LINK WYPOZYCZALNIA_MICHAL 
    CONNECT TO c##mnowak 
    IDENTIFIED BY mnowak5 
    USING 'ORCLMICHAL';

--Vehilce id sequence creating 
BEGIN
    BEGIN
         EXECUTE IMMEDIATE 'DROP SEQUENCE VEHICLE_ID_SEQUENCE';
    EXCEPTION
         WHEN OTHERS THEN
                IF SQLCODE != -2289 THEN
                     RAISE;
                END IF;
    END;
    EXECUTE IMMEDIATE 'CREATE SEQUENCE VEHICLE_ID_SEQUENCE 
        INCREMENT BY 1 
        START WITH 1 
        MAXVALUE 99999999999999 
        MINVALUE 1 
        NOCACHE 
        ORDER';
END;
/

--Vehicle id insertion trigger creating
CREATE OR REPLACE TRIGGER pojazdy_on_insert
  BEFORE INSERT ON pojazdy
  FOR EACH ROW
BEGIN
  SELECT VEHICLE_ID_SEQUENCE.nextval
  INTO :new.ID_Pojazdu
  FROM dual;
END;
/

--Creating remote database synonym to pojazdy
CREATE OR REPLACE PUBLIC SYNONYM remoteVehicles FOR pojazdy@WYPOZYCZALNIA_MICHAL;

COMMIT;
