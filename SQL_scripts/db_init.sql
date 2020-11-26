--Customers table creating
BEGIN
    BEGIN
         EXECUTE IMMEDIATE 'DROP TABLE customers';
    EXCEPTION
         WHEN OTHERS THEN
                IF SQLCODE != -942 THEN
                     RAISE;
                END IF;
    END;
    EXECUTE IMMEDIATE 'CREATE TABLE customers (
            CustomerID      NUMBER(38)      generated always as identity (START with 1 INCREMENT by 1),
            AddressID       NUMBER (38)     not null,
            FirstName       VARCHAR(30)     not null,
    SecondName      VARCHAR(30)     not null,
    LastName        VARCHAR(30)     not null,
    PESEL           VARCHAR(11)     not null,
    telephone       VARCHAR(9)      not null,
    cathegory       CHAR(1)         not null,
    
    CONSTRAINT customer_pk PRIMARY KEY (CustomerID)
    )';
END;
/
----Indexes to customers table creating
CREATE INDEX customers_AddressID_idx ON customers(AddressID);
CREATE INDEX customers_PESEL_idx ON customers(PESEL);
CREATE INDEX customers_telephone_idx ON customers(telephone);

--Vehicles table creating
BEGIN
    BEGIN
         EXECUTE IMMEDIATE 'DROP TABLE vehicles';
    EXCEPTION
         WHEN OTHERS THEN
                IF SQLCODE != -942 THEN
                     RAISE;
                END IF;
    END;
    EXECUTE IMMEDIATE 'CREATE TABLE vehicles (
    VehicleID       NUMBER(38)      generated always as identity (START with 1 INCREMENT by 1),
    ModelID         NUMBER(38)      not null,
    vinNumber       VARCHAR(17)     not null,
    evidenceNumber  VARCHAR(9)      not null,
    productionYear  NUMBER(38)      not null,
    mileage         NUMBER(38)      not null, 
    nextReview      DATE            not null,
    damaged         VARCHAR(1)      not null,
    pricePerDay     FLOAT(2)        not null,

    CONSTRAINT vehicle_pk PRIMARY KEY (VehicleID)
    )';
END;
/
--Indexes to vehicles table creating
CREATE INDEX vehicles_ModelID_idx ON vehicles(ModelID);
CREATE INDEX vehicles_vinNumber_idx ON vehicles(vinNumber);
CREATE INDEX vehicles_evidenceNumber_idx ON vehicles(evidenceNumber);

--Models table creating
BEGIN
    BEGIN
         EXECUTE IMMEDIATE 'DROP TABLE models';
    EXCEPTION
         WHEN OTHERS THEN
                IF SQLCODE != -942 THEN
                     RAISE;
                END IF;
    END;
    EXECUTE IMMEDIATE 'CREATE TABLE models (
    ModelID         NUMBER(38)      generated always as identity (START with  1 INCREMENT by 1),
    ModelName       VARCHAR(30)     not null,
    engineCapacity  NUMBER(38)      not null,
    cathegory       VARCHAR(1)      not null,
    producent       VARCHAR(20)     not null,
    
    CONSTRAINT model_pk PRIMARY KEY (ModelID)
    )';
END;
/

--Indexes to models table creating
CREATE INDEX models_ModelName_idx ON models(ModelName);
CREATE INDEX models_producent_idx ON models(producent);

--Rentals table creating
BEGIN
    BEGIN
        EXECUTE IMMEDIATE 'DROP TABLE rentals';
    EXCEPTION
         WHEN OTHERS THEN
                IF SQLCODE != -942 THEN
                     RAISE;
                END IF;
    END;
    EXECUTE IMMEDIATE 'CREATE TABLE rentals (
    RentalID        NUMBER(38)      generated always as identity (START with 1 INCREMENT by 1),
    RentHouseID     NUMBER(38)      not null,
    CustomerID      NUMBER(38)      not null,
    VehicleID       NUMBER(38)      not null,
    ReturnID        NUMBER(38)      not null,
    rentalDate      DATE            not null,
    plannedReturn   DATE            not null,
    deposit         NUMBER(38)      not null,  
    
    CONSTRAINT rental_pk PRIMARY KEY (RentalID)
    )';
END;
/

--Indexes to rentals table creating 
CREATE INDEX rentals_RentHouseID_idx ON rentals(RentHouseID);
CREATE INDEX rentals_CustomerID_idx ON rentals(CustomerID);
CREATE INDEX rentals_VehicleID_idx ON rentals(VehicleID);
CREATE INDEX rentals_ReturnID_idx ON rentals(ReturnID);

--Returns table creating
BEGIN
    BEGIN
        EXECUTE IMMEDIATE 'DROP TABLE returns';
    EXCEPTION
         WHEN OTHERS THEN
                IF SQLCODE != -942 THEN
                     RAISE;
                END IF;
    END;
    EXECUTE IMMEDIATE 'CREATE TABLE returns (
    ReturnID        NUMBER(38)      not null,
    RentalHouseID   NUMBER(38)      not null,
    returnDate      DATE            not null,
    paid            VARCHAR(1)      not null,
    penalty         FLOAT(2)        null,
    depositReturn   VARCHAR(1)      not null,
    
    CONSTRAINT return_pk PRIMARY KEY (ReturnID)
    )';
END;
/

--Creating indexes to returns table
CREATE INDEX returns_RentalHouseID_idx ON returns(RentalHouseID);

--RentalHouses table creating
BEGIN
    BEGIN
        EXECUTE IMMEDIATE 'DROP TABLE rentalHouses';
    EXCEPTION
         WHEN OTHERS THEN
                IF SQLCODE != -942 THEN
                     RAISE;
                END IF;
    END;
    EXECUTE IMMEDIATE 'CREATE TABLE rentalHouses (
    RentalHouseID   NUMBER(38)      not null,
    AddressID       NUMBER(38)      not null,
    freePlaces      NUMBER(38)      not null,
    
    CONSTRAINT rentalHouse_pk PRIMARY KEY(RentalHouseID)
    )';
END;
/

--Creating indexes to rentalHouses table
CREATE INDEX rentalHouses_AddressID_idx ON rentalHouses(AddressID);

--Address table creating
BEGIN
    BEGIN
        EXECUTE IMMEDIATE 'DROP TABLE addresses';
    EXCEPTION
         WHEN OTHERS THEN
                IF SQLCODE != -942 THEN
                     RAISE;
                END IF;
    END;
    EXECUTE IMMEDIATE 'CREATE TABLE addresses (
    AddressID       NUMBER(38)      not null,
    postalCode      VARCHAR(6)      not null,
    town            VARCHAR(20)     not null,
    street          VARCHAR(30)     not null,
    houseNumber     NUMBER(38)      not null,
    homeNumber      NUMBER(38)      null,
    
    CONSTRAINT address_pk PRIMARY KEY (AddressID)
    )';
END;
/

--Creating indexes to addresses table
CREATE INDEX addresses_postalCode_idx ON addresses(postalCode);
CREATE INDEX addresses_town_idx ON addresses(town);

commit;




