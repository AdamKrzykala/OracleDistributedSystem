--FIRST DB INDIVIDUAL INIT----------------------------------------------------------

--RentalHouses table creating
BEGIN
    BEGIN
        EXECUTE IMMEDIATE 'DROP TABLE Wypozyczalnie';
    EXCEPTION
         WHEN OTHERS THEN
            IF SQLCODE != -942 THEN
                 RAISE;
            END IF;
    END;
    EXECUTE IMMEDIATE 'CREATE TABLE Wypozyczalnie (
        ID_Wypozyczalni     INT       NOT NULL,
        ID_Adresu           INT       not null,
        NumerWypozyczalni   INT       not null,
        WolneMiejsca        INT       not null,
        CONSTRAINT wypozyczalnie_pk PRIMARY KEY(ID_Wypozyczalni)
    )';
END;
/

--Models table creating
BEGIN
    BEGIN
         EXECUTE IMMEDIATE 'DROP TABLE Modele';
    EXCEPTION
         WHEN OTHERS THEN
            IF SQLCODE != -942 THEN
                 RAISE;
            END IF;
    END;
    EXECUTE IMMEDIATE 'CREATE TABLE Modele (
        ID_Modelu               INT             NOT NULL,
        Model                   VARCHAR(30)     not null,
        PojemnoscSilnika        INT             not null,
        SrednieSpalanie         INT             null,
        KategoriaPrawaJazdy     CHAR(1)         not null,
        StawkaZaDzien           FLOAT           not null,
        CONSTRAINT modele_pk PRIMARY KEY(ID_Modelu)
    )';
END;
/

--FOREIGN KEYS CONFIGURATION----------------------------------------------------
BEGIN
    EXECUTE IMMEDIATE 'ALTER TABLE Pojazdy ADD CONSTRAINT fk_PojazdModel FOREIGN KEY (ID_Modelu) REFERENCES Modele(ID_Modelu)';
    EXECUTE IMMEDIATE 'ALTER TABLE Wypozyczenia ADD CONSTRAINT fk_WypozyczenieWypozyczalnia FOREIGN KEY (ID_Wypozyczalni) REFERENCES Wypozyczalnie(ID_Wypozyczalni)';
    EXECUTE IMMEDIATE 'ALTER TABLE Zwroty ADD CONSTRAINT fk_ZwrotWypozyczalnia FOREIGN KEY (ID_Wypozyczalni) REFERENCES Wypozyczalnie(ID_Wypozyczalni)';
END;
/

--Indexes to models table creating
CREATE INDEX idx_Model_Model_idx    ON Modele(Model);

--Creating indexes to rentalHouses table
CREATE INDEX idx_Wypozyczalnia_ID_Adresu             ON Wypozyczalnie(ID_Adresu);
CREATE INDEX idx_Wypozyczalnia_ID_NumerWypo  ON Wypozyczalnie(NumerWypozyczalni);

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

--Returns id insertion trigger creating
CREATE OR REPLACE TRIGGER zwroty_on_insert
  BEFORE INSERT ON zwroty
  FOR EACH ROW
BEGIN
  SELECT RETURNS_ID_SEQUENCE.nextval
  INTO :new.ID_Zwrotu
  FROM dual;
END;
/

--RentalHouses id sequence creating 
BEGIN
    BEGIN
         EXECUTE IMMEDIATE 'DROP SEQUENCE RENTALHOUSE_ID_SEQUENCE';
    EXCEPTION
         WHEN OTHERS THEN
                IF SQLCODE != -2289 THEN
                     RAISE;
                END IF;
    END;
    EXECUTE IMMEDIATE 'CREATE SEQUENCE RENTALHOUSE_ID_SEQUENCE 
        INCREMENT BY 1 
        START WITH 1 
        MAXVALUE 99999999999999 
        MINVALUE 1 
        NOCACHE 
        ORDER';
END;
/

--RentalHouse id insertion trigger creating
CREATE OR REPLACE TRIGGER wypozyczalnie_on_insert
  BEFORE INSERT ON wypozyczalnie
  FOR EACH ROW
BEGIN
  SELECT RENTALHOUSE_ID_SEQUENCE.nextval
  INTO :new.ID_Wypozyczalni
  FROM dual;
END;
/

--Models id sequence creating 
BEGIN
    BEGIN
         EXECUTE IMMEDIATE 'DROP SEQUENCE MODEL_ID_SEQUENCE';
    EXCEPTION
         WHEN OTHERS THEN
                IF SQLCODE != -2289 THEN
                     RAISE;
                END IF;
    END;
    EXECUTE IMMEDIATE 'CREATE SEQUENCE MODEL_ID_SEQUENCE 
        INCREMENT BY 1 
        START WITH 1 
        MAXVALUE 99999999999999 
        MINVALUE 1 
        NOCACHE 
        ORDER';
END;
/

--Model id insertion trigger creating
CREATE OR REPLACE TRIGGER modele_on_insert
  BEFORE INSERT ON modele
  FOR EACH ROW
BEGIN
  SELECT MODEL_ID_SEQUENCE.nextval
  INTO :new.ID_Modelu
  FROM dual;
END;
/

--Customers id sequence creating 
BEGIN
    BEGIN
         EXECUTE IMMEDIATE 'DROP SEQUENCE CUSTOMER_ID_SEQUENCE';
    EXCEPTION
         WHEN OTHERS THEN
                IF SQLCODE != -2289 THEN
                     RAISE;
                END IF;
    END;
    EXECUTE IMMEDIATE 'CREATE SEQUENCE CUSTOMER_ID_SEQUENCE 
        INCREMENT BY 1 
        START WITH 1 
        MAXVALUE 99999999999999 
        MINVALUE 1 
        NOCACHE 
        ORDER';
END;
/

--Customer id insertion trigger creating
CREATE OR REPLACE TRIGGER klienci_on_insert
  BEFORE INSERT ON klienci
  FOR EACH ROW
BEGIN
  SELECT CUSTOMER_ID_SEQUENCE.nextval
  INTO :new.ID_Klienta
  FROM dual;
END;
/

--Addresses id sequence creating 
BEGIN
    BEGIN
         EXECUTE IMMEDIATE 'DROP SEQUENCE ADDRESS_ID_SEQUENCE';
    EXCEPTION
         WHEN OTHERS THEN
                IF SQLCODE != -2289 THEN
                     RAISE;
                END IF;
    END;
    EXECUTE IMMEDIATE 'CREATE SEQUENCE ADDRESS_ID_SEQUENCE 
        INCREMENT BY 1 
        START WITH 1 
        MAXVALUE 99999999999999 
        MINVALUE 1 
        NOCACHE 
        ORDER';
END;
/

--Address id insertion trigger creating
CREATE OR REPLACE TRIGGER adresy_on_insert
  BEFORE INSERT ON adresy
  FOR EACH ROW
BEGIN
  SELECT ADDRESS_ID_SEQUENCE.nextval
  INTO :new.ID_Adresu
  FROM dual;
END;
/


--Creating remote database synonym to pojazdy
CREATE OR REPLACE PUBLIC SYNONYM remoteVehicles FOR pojazdy@WYPOZYCZALNIA_MICHAL;

--Creating remote database synonym to wypozyczenia
CREATE OR REPLACE PUBLIC SYNONYM remoteRentals FOR wypozyczenia@WYPOZYCZALNIA_MICHAL;

--Creating remote database synonym to zwroty
CREATE OR REPLACE PUBLIC SYNONYM remoteReturns FOR zwroty@WYPOZYCZALNIA_MICHAL;

--SERVER-SLAVE SNAPSHOTS----------------------------------
--Creating snapshot log for rentalHouses
BEGIN
    BEGIN
         EXECUTE IMMEDIATE 'DROP SNAPSHOT LOG ON Wypozyczalnie';
    EXCEPTION
         WHEN OTHERS THEN
            IF SQLCODE != -12002 THEN
                 RAISE;
            END IF;
    END;
    EXECUTE IMMEDIATE 'CREATE SNAPSHOT LOG
        ON Wypozyczalnie
        WITH PRIMARY KEY,
        ROWID(ID_Adresu,
                NumerWypozyczalni,
                WolneMiejsca)
        INCLUDING NEW VALUES';
END;
/

--Creating snapshot log for models
BEGIN
    BEGIN
         EXECUTE IMMEDIATE 'DROP SNAPSHOT LOG ON Modele';
    EXCEPTION
         WHEN OTHERS THEN
            IF SQLCODE != -12002 THEN
                 RAISE;
            END IF;
    END;
    EXECUTE IMMEDIATE 'CREATE SNAPSHOT LOG
        ON Modele
        WITH PRIMARY KEY
        INCLUDING NEW VALUES';
END;
/
-----------------------------------------------------------


--PEER-TO-PEER SNAPSHOTS-----------------------------------
--Creating snapshot log for customers 1 direction
-- IN COMMON FILE 
--Snapshot of customers from 2 MASTER
BEGIN
    BEGIN
         EXECUTE IMMEDIATE 'DROP SNAPSHOT KlienciMaster2';
    EXCEPTION
         WHEN OTHERS THEN
            IF SQLCODE != -12003 THEN
                 RAISE;
            END IF;
    END;
    EXECUTE IMMEDIATE 'CREATE SNAPSHOT KlienciMaster2
        BUILD IMMEDIATE 
        REFRESH FORCE
        NEXT sysdate + (1/(24*60*6))
        AS
        SELECT * FROM klienci@WYPOZYCZALNIA_MICHAL
        ';
END;
/
--Creating snapshot log for addresses 1 direction
-- IN COMMON FILE
--Snapshot of addresses from 2 MASTER
BEGIN
    BEGIN
         EXECUTE IMMEDIATE 'DROP SNAPSHOT AdresyMaster2';
    EXCEPTION
         WHEN OTHERS THEN
            IF SQLCODE != -12003 THEN
                 RAISE;
            END IF;
    END;
    EXECUTE IMMEDIATE 'CREATE SNAPSHOT AdresyMaster2
        BUILD IMMEDIATE 
        REFRESH FORCE
        NEXT sysdate + (1/(24*60*6))
        AS
        SELECT * FROM adresy@WYPOZYCZALNIA_MICHAL
        ';
END;
/

--Creating remote database synonym to pojazdy
CREATE OR REPLACE PUBLIC SYNONYM remoteVehicles FOR pojazdy@WYPOZYCZALNIA_MICHAL;

--Creating remote database synonym to wypozyczenia
CREATE OR REPLACE PUBLIC SYNONYM remoteRentals FOR wypozyczenia@WYPOZYCZALNIA_MICHAL;

--Creating remote database synonym to zwroty
CREATE OR REPLACE PUBLIC SYNONYM remoteReturns FOR zwroty@WYPOZYCZALNIA_MICHAL;

--Peer-to-peer master site concatenation
CREATE OR REPLACE VIEW SHOW_ALL_CLIENTS AS
SELECT * FROM klienci
UNION ALL
SELECT * FROM kliencimaster2;

CREATE OR REPLACE VIEW SHOW_ALL_ADDRESSES AS
SELECT * FROM adresy
UNION ALL
SELECT * FROM adresymaster2;

--Creating partitioned view of locally available vehicles
CREATE OR REPLACE VIEW SHOW_AVAILABLE_VEHICLES AS
SELECT * FROM remoteVehicles WHERE remoteVehicles.AktualnaWypozyczalnia = 0
UNION ALL
SELECT * FROM pojazdy WHERE pojazdy.AktualnaWypozyczalnia = 0;


COMMIT;
