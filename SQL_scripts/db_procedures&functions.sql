--PROCEDURES CONFIGURATION-----------------------------------------------------

--Creating procedure to new address inserting
create or replace procedure insert_new_adres(KodPocztowy in adresy.kodpocztowy%TYPE,
                                             Miejscowosc in adresy.miejscowosc%TYPE,
                                             Ulica in adresy.ulica%TYPE,
                                             NumerDomu in adresy.numerdomu%TYPE,
                                             NumerMieszkania in adresy.numermieszkania%TYPE) as 
begin
    DECLARE cnt INT;
    BEGIN
        SELECT COUNT(*) INTO cnt FROM adresy WHERE NOT EXISTS(SELECT *
                                                              FROM adresy
                                                              WHERE kodpocztowy = KodPocztowy and
                                                                    miejscowosc = Miejscowosc);
        IF(cnt = 0) THEN
            INSERT INTO Adresy(kodpocztowy, miejscowosc, ulica, numerdomu, numermieszkania)
            VALUES (KodPocztowy, Miejscowosc, Ulica, NumerDomu, NumerMieszkania);
        END IF;
    END;
end insert_new_adres;
/

--Creating procedure to new client inserting
create or replace procedure insert_new_klient(Imie in klienci.imie%TYPE,
                                              DrugieImie in klienci.drugieimie%TYPE default NULL,
                                              Nazwisko in klienci.nazwisko%TYPE,
                                              PESEL in klienci.pesel%TYPE,
                                              NrTel in klienci.numertel%TYPE,
                                              KategoriaPrawaJazdy in klienci.katprawajazdy%TYPE,
                                              KodPocztowy in adresy.kodpocztowy%TYPE,
                                              Miejscowosc in adresy.miejscowosc%TYPE,
                                              Ulica in adresy.ulica%TYPE,
                                              NumerDomu in adresy.numerdomu%TYPE,
                                              NumerMieszkania in adresy.numermieszkania%TYPE default NULL) as 
begin
    insert_new_adres(KodPocztowy, Miejscowosc, Ulica, NumerDomu, NumerMieszkania);
    declare index_value INT;
    BEGIN
        select ID_Adresu into index_value from Adresy where kodpocztowy = KodPocztowy and
                                                          miejscowosc = Miejscowosc and 
                                                          ulica = Ulica and
                                                          numerdomu = NumerDomu and
                                                          numermieszkania = NumerMieszkania;

        INSERT INTO Klienci(id_adresu, imie, drugieimie, nazwisko, pesel, numertel, katprawajazdy)
        VALUES (index_value, Imie, DrugieImie, Nazwisko, PESEL, NrTel, KategoriaPrawaJazdy);
    END;
end insert_new_klient;
/
COMMIT;

