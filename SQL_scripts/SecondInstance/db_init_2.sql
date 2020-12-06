--SECOND DB INDIVIDUAL INIT----------------------------------------------------------

--Vehicle id insertion trigger creating
CREATE OR REPLACE TRIGGER pojazdy_on_insert
  BEFORE INSERT ON pojazdy
  FOR EACH ROW
BEGIN
  SELECT VEHICLE_ID_SEQUENCE.nextval@WYPOZYCZALNIA_ADAM 
  INTO :new.ID_Pojazdu
  FROM dual;
END;
/

--Rentals id insertion trigger creating
CREATE OR REPLACE TRIGGER wypozyczenia_on_insert
  BEFORE INSERT ON wypozyczenia
  FOR EACH ROW
BEGIN
  SELECT RENTALS_ID_SEQUENCE.nextval@WYPOZYCZALNIA_ADAM 
  INTO :new.ID_Wypozyczenia
  FROM dual;
END;
/

--Returns id insertion trigger creating
CREATE OR REPLACE TRIGGER zwroty_on_insert
  BEFORE INSERT ON zwroty
  FOR EACH ROW
BEGIN
  SELECT RETURNS_ID_SEQUENCE.nextval@WYPOZYCZALNIA_ADAM 
  INTO :new.ID_Zwrotu
  FROM dual;
END;
/

--Customer id insertion trigger creating
CREATE OR REPLACE TRIGGER klienci_on_insert
  BEFORE INSERT ON klienci
  FOR EACH ROW
BEGIN
  SELECT CUSTOMER_ID_SEQUENCE.nextval@WYPOZYCZALNIA_ADAM
  INTO :new.ID_Klienta
  FROM dual;
END;
/

--Address id insertion trigger creating
CREATE OR REPLACE TRIGGER adresy_on_insert
  BEFORE INSERT ON adresy
  FOR EACH ROW
BEGIN
  SELECT ADDRESS_ID_SEQUENCE.nextval@WYPOZYCZALNIA_ADAM
  INTO :new.ID_Adresu
  FROM dual;
END;
/


--Snapshot of rentalHouses for slave
--Creating snapshot log for models
BEGIN
    BEGIN
         EXECUTE IMMEDIATE 'DROP SNAPSHOT WypozyczalnieMV';
    EXCEPTION
         WHEN OTHERS THEN
            IF SQLCODE != -12003 THEN
                 RAISE;
            END IF;
    END;
    EXECUTE IMMEDIATE 'CREATE SNAPSHOT WypozyczalnieMV
        BUILD IMMEDIATE 
        REFRESH FAST 
        NEXT sysdate + (1/(24*60*6))
        AS
        SELECT * FROM wypozyczalnieServer';
END;
/

--Snapshot of models for slave
BEGIN
    BEGIN
         EXECUTE IMMEDIATE 'DROP SNAPSHOT ModeleMV';
    EXCEPTION
         WHEN OTHERS THEN
            IF SQLCODE != -12003 THEN
                 RAISE;
            END IF;
    END;
    EXECUTE IMMEDIATE 'CREATE SNAPSHOT ModeleMV
        BUILD IMMEDIATE 
        REFRESH FAST
        NEXT sysdate + (1/(24*60))
        AS
        SELECT * FROM modeleServer
        ';
END;
/

--PEER-TO-PEER SNAPSHOTS----------------------------------------
--Creating snapshot log for customers 2 direction to 1 MASTER
BEGIN
    BEGIN
         EXECUTE IMMEDIATE 'DROP SNAPSHOT LOG ON Klienci';
    EXCEPTION
         WHEN OTHERS THEN
            IF SQLCODE != -12002 THEN
                 RAISE;
            END IF;
    END;
    EXECUTE IMMEDIATE 'CREATE SNAPSHOT LOG
        ON Klienci
        WITH PRIMARY KEY
        INCLUDING NEW VALUES';
END;
/
--Snapshot of customers from 1 MASTER
BEGIN
    BEGIN
         EXECUTE IMMEDIATE 'DROP SNAPSHOT KlienciMaster1';
    EXCEPTION
         WHEN OTHERS THEN
            IF SQLCODE != -12003 THEN
                 RAISE;
            END IF;
    END;
    EXECUTE IMMEDIATE 'CREATE SNAPSHOT KlienciMaster1
        BUILD IMMEDIATE 
        REFRESH FAST
        NEXT sysdate + (1/(24*60))
        AS
        SELECT * FROM klienci@WYPOZYCZALNIA_ADAM
        ';
END;
/
--Creating remote database synonym to pojazdy
CREATE OR REPLACE PUBLIC SYNONYM remoteVehicles FOR pojazdy@WYPOZYCZALNIA_ADAM;

--Creating remote database synonym to wypozyczenia
CREATE OR REPLACE PUBLIC SYNONYM remoteRentals FOR wypozyczenia@WYPOZYCZALNIA_ADAM;

--Creating remote database synonym to zwroty
CREATE OR REPLACE PUBLIC SYNONYM remoteReturns FOR zwroty@WYPOZYCZALNIA_ADAM;

COMMIT;
