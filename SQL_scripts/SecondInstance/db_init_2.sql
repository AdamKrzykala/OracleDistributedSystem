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

--Creating remote database synonym to models on server
CREATE OR REPLACE PUBLIC SYNONYM modeleServer FOR modele@WYPOZYCZALNIA_ADAM;

--Creating remote database synonym to rentalHouses on server
CREATE OR REPLACE PUBLIC SYNONYM wypozyczalnieServer FOR wypozyczalnie@WYPOZYCZALNIA_ADAM;


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
        NEXT sysdate + 1
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
        NEXT sysdate + (1/(24*60*5))
        AS
        SELECT * FROM modeleServer
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
