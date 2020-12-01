--FIRST DB INDIVIDUAL INIT----------------------------------------------------------

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

--Rentals id sequence creating 
BEGIN
    BEGIN
         EXECUTE IMMEDIATE 'DROP SEQUENCE RENTALS_ID_SEQUENCE';
    EXCEPTION
         WHEN OTHERS THEN
                IF SQLCODE != -2289 THEN
                     RAISE;
                END IF;
    END;
    EXECUTE IMMEDIATE 'CREATE SEQUENCE RENTALS_ID_SEQUENCE 
        INCREMENT BY 1 
        START WITH 1 
        MAXVALUE 99999999999999 
        MINVALUE 1 
        NOCACHE 
        ORDER';
END;
/

--Rentals id insertion trigger creating
CREATE OR REPLACE TRIGGER wypozyczenia_on_insert
  BEFORE INSERT ON wypozyczenia
  FOR EACH ROW
BEGIN
  SELECT RENTALS_ID_SEQUENCE.nextval
  INTO :new.ID_Wypozyczenia
  FROM dual;
END;
/

--Return id sequence creating 
BEGIN
    BEGIN
         EXECUTE IMMEDIATE 'DROP SEQUENCE RETURNS_ID_SEQUENCE';
    EXCEPTION
         WHEN OTHERS THEN
                IF SQLCODE != -2289 THEN
                     RAISE;
                END IF;
    END;
    EXECUTE IMMEDIATE 'CREATE SEQUENCE RETURNS_ID_SEQUENCE 
        INCREMENT BY 1 
        START WITH 1 
        MAXVALUE 99999999999999 
        MINVALUE 1 
        NOCACHE 
        ORDER';
END;
/

--Rentals id insertion trigger creating
CREATE OR REPLACE TRIGGER zwroty_on_insert
  BEFORE INSERT ON zwroty
  FOR EACH ROW
BEGIN
  SELECT RETURNS_ID_SEQUENCE.nextval
  INTO :new.ID_Zwrotu
  FROM dual;
END;
/

--Creating remote database synonym to pojazdy
CREATE OR REPLACE PUBLIC SYNONYM remoteVehicles FOR pojazdy@WYPOZYCZALNIA_MICHAL;

--Creating remote database synonym to wypozyczenia
CREATE OR REPLACE PUBLIC SYNONYM remoteRentals FOR wypozyczenia@WYPOZYCZALNIA_MICHAL;

--Creating remote database synonym to wypozyczenia
CREATE OR REPLACE PUBLIC SYNONYM remoteReturns FOR zwroty@WYPOZYCZALNIA_MICHAL;

COMMIT;
