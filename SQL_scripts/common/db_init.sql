--External database link creating
CREATE DATABASE LINK WYPOZYCZALNIA_ADAM 
    CONNECT TO c##adam 
    IDENTIFIED BY adam 
    USING 'ORCLADAM';

--External database link creating
CREATE DATABASE LINK WYPOZYCZALNIA_MICHAL 
    CONNECT TO c##mnowak 
    IDENTIFIED BY mnowak5 
    USING 'ORCLMICHAL';
    
--TABLES CONFIGURATION----------------------------------------------------------

--Customers table creating
BEGIN
    BEGIN
         EXECUTE IMMEDIATE 'DROP TABLE Klienci';
    EXCEPTION
         WHEN OTHERS THEN
                IF SQLCODE != -942 THEN
                     RAISE;
                END IF;
    END;
    EXECUTE IMMEDIATE 'CREATE TABLE Klienci (
        ID_Klienta      INT             generated always as identity (START with 1 INCREMENT by 1),
        ID_Adresu       INT             not null,
        Imie            VARCHAR(30)     not null,
        Nazwisko        VARCHAR(30)     not null,
        DrugieImie      VARCHAR(30)     null,
        PESEL           VARCHAR(11)     not null,
        NumerTel        VARCHAR(9)      not null,
        KatPrawaJazdy   CHAR(1)         not null,
        PRIMARY KEY(ID_Klienta)
    )';
END;
/
--Vehicles table creating
BEGIN
    BEGIN
         EXECUTE IMMEDIATE 'DROP TABLE pojazdy';
    EXCEPTION
         WHEN OTHERS THEN
                IF SQLCODE != -942 THEN
                     RAISE;
                END IF;
    END;
    EXECUTE IMMEDIATE 'CREATE TABLE pojazdy (
        ID_Pojazdu              INT             not null,
        ID_Modelu               INT             not null,
        NumerVIN                VARCHAR(17)     not null,
        NumerRejestracyjny      VARCHAR(9)      not null,
        Rocznik                 DATE            not null,
        Przebieg                INT             not null, 
        DataWaznosciPrzegladu   DATE            null,
        Uszkodzony              CHAR(3)         null,
        AktualnaWypozyczalnia   INT             null,
        CONSTRAINT pojazdy_pk PRIMARY KEY(ID_pojazdu)
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
        ID_Modelu               INT             generated always as identity (START with  1 INCREMENT by 1),
        Model                   VARCHAR(30)     not null,
        PojemnoscSilnika        INT             not null,
        SrednieSpalanie         INT             null,
        KategoriaPrawaJazdy     CHAR(1)         not null,
        StawkaZaDzien           FLOAT           not null,
        PRIMARY KEY(ID_Modelu)
    )';
END;
/
--Rentals table creating
BEGIN
    BEGIN
        EXECUTE IMMEDIATE 'DROP TABLE Wypozyczenia';
    EXCEPTION
         WHEN OTHERS THEN
            IF SQLCODE != -942 THEN
                 RAISE;
            END IF;
    END;
    EXECUTE IMMEDIATE 'CREATE TABLE Wypozyczenia (
        ID_Wypozyczenia         INT         not null,
        ID_Wypozyczalni         INT         not null,
        ID_Klienta              INT         not null,
        ID_Pojazdu              INT         not null,
        ID_Zwrotu               INT         null,
        TerminWypozyczenia      DATE        not null,
        PlanowanyTerminZwrotu   DATE        not null,
        PobranaKaucja           FLOAT       not null,
        CONSTRAINT wypozyczenia_pk PRIMARY KEY(ID_Wypozyczenia)
    )';
END;
/
--Returns table creating
BEGIN
    BEGIN
        EXECUTE IMMEDIATE 'DROP TABLE Zwroty';
    EXCEPTION
         WHEN OTHERS THEN
            IF SQLCODE != -942 THEN
                 RAISE;
            END IF;
    END;
    EXECUTE IMMEDIATE 'CREATE TABLE Zwroty (
        ID_Zwrotu           INT         not null,
        ID_Wypozyczalni     INT         not null,
        TerminZwrotu        DATE        not null,
        Zaplacono           VARCHAR2(3)     not null,
        KaraZaSpoznienie    FLOAT(2)    null,
        ZwrotKaucji         VARCHAR2(3)     not null,
        PRIMARY KEY(ID_Zwrotu)
    )';
END;
/
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
        ID_Wypozyczalni     INT       generated always as identity (START with 1 INCREMENT by 1),
        ID_Adresu           INT       not null,
        NumerWypozyczalni   INT       not null,
        WolneMiejsca        INT       not null,
        PRIMARY KEY(ID_Wypozyczalni)
    )';
END;
/
--Address table creating
BEGIN
    BEGIN
        EXECUTE IMMEDIATE 'DROP TABLE Adresy';
    EXCEPTION
         WHEN OTHERS THEN
            IF SQLCODE != -942 THEN
                 RAISE;
            END IF;
    END;
    EXECUTE IMMEDIATE 'CREATE TABLE Adresy (
        ID_Adresu           INT             generated always as identity (START with 1 INCREMENT by 1),
        KodPocztowy         VARCHAR2(6)     not null,
        Miejscowosc         VARCHAR2(30)    not null,
        Ulica               VARCHAR2(30)    not null,
        NumerDomu           INT             not null,
        NumerMieszkania     INT             null,
        PRIMARY KEY(ID_Adresu)
    )';
END;
/
--FOREIGN KEYS CONFIGURATION----------------------------------------------------
BEGIN
    EXECUTE IMMEDIATE 'ALTER TABLE Klienci ADD CONSTRAINT fk_KlientAdres FOREIGN KEY (ID_Adresu) REFERENCES Adresy(ID_Adresu)';
    EXECUTE IMMEDIATE 'ALTER TABLE Pojazdy ADD CONSTRAINT fk_PojazdModel FOREIGN KEY (ID_Modelu) REFERENCES Modele(ID_Modelu)';
    EXECUTE IMMEDIATE 'ALTER TABLE Wypozyczenia ADD CONSTRAINT fk_WypozyczenieWypozyczalnia FOREIGN KEY (ID_Wypozyczalni) REFERENCES Wypozyczalnie(ID_Wypozyczalni)';
    EXECUTE IMMEDIATE 'ALTER TABLE Wypozyczenia ADD CONSTRAINT fk_WypozyczenieKlient FOREIGN KEY (ID_Klienta) REFERENCES Klienci(ID_Klienta)';
    EXECUTE IMMEDIATE 'ALTER TABLE Wypozyczenia ADD CONSTRAINT fk_WypozyczeniePojazd FOREIGN KEY (ID_Pojazdu) REFERENCES Pojazdy(ID_Pojazdu)';
    EXECUTE IMMEDIATE 'ALTER TABLE Wypozyczenia ADD CONSTRAINT fk_WypozyczenieZwrot FOREIGN KEY (ID_Zwrotu) REFERENCES Zwroty(ID_Zwrotu)';
    EXECUTE IMMEDIATE 'ALTER TABLE Zwroty ADD CONSTRAINT fk_ZwrotWypozyczalnia FOREIGN KEY (ID_Wypozyczalni) REFERENCES Wypozyczalnie(ID_Wypozyczalni)';
    EXECUTE IMMEDIATE 'ALTER TABLE Wypozyczalnie ADD CONSTRAINT fk_WypozyczalniaAdres FOREIGN KEY (ID_Adresu) REFERENCES Adresy(ID_Adresu)';
END;
/
--INDEXES CONFIGURATION---------------------------------------------------------
----Indexes to customers table creating
CREATE INDEX idx_Klient_ID_Adresu   ON Klienci(ID_Adresu);
CREATE INDEX idx_Klient_PESEL       ON Klienci(PESEL);
CREATE INDEX idx_Klient_NumerTel    ON Klienci(NumerTel);

--Indexes to vehicles table creating
CREATE INDEX idx_Pojazd_ID_Modelu              ON Pojazdy(ID_Modelu);
CREATE INDEX idx_Pojazd_NumerVIN               ON Pojazdy(NumerVIN);
CREATE INDEX idx_Pojazd_NumerRejestracyjny     ON Pojazdy(NumerRejestracyjny);

--Indexes to models table creating
CREATE INDEX idx_Model_Model_idx    ON Modele(Model);

--Indexes to rentals table creating 
CREATE INDEX idx_Wypozyczenie_ID_Wypozyczalni   ON Wypozyczenia(ID_Wypozyczalni);
CREATE INDEX idx_Wypozyczenie_ID_Klienta        ON Wypozyczenia(ID_Klienta);
CREATE INDEX idx_Wypozyczenie_ID_Pojazdu        ON Wypozyczenia(ID_Pojazdu);
CREATE INDEX idx_Wypozyczenie_ID_Zwrotu         ON Wypozyczenia(ID_Zwrotu);

--Creating indexes to returns table
CREATE INDEX idx_Zwrot_ID_Wypozyczalni      ON Zwroty(ID_Wypozyczalni);

--Creating indexes to rentalHouses table
CREATE INDEX idx_Wypozyczalnia_ID_Adresu             ON Wypozyczalnie(ID_Adresu);
CREATE INDEX idx_Wypozyczalnia_ID_NumerWypozyczalni  ON Wypozyczalnie(NumerWypozyczalni);

--Creating indexes to addresses table
CREATE INDEX idx_Adres_KodPocztowy      ON Adresy(KodPocztowy);
CREATE INDEX idx_Adres_Miejscowosc      ON Adresy(Miejscowosc);

COMMIT;