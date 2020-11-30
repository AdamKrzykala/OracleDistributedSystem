--PROCEDURES CONFIGURATION-----------------------------------------------------
create or replace procedure insert_new_adres(input_KodPocztowy in adresy.kodpocztowy%TYPE,
                                             input_Miejscowosc in adresy.miejscowosc%TYPE,
                                             input_Ulica in adresy.ulica%TYPE,
                                             input_NumerDomu in adresy.numerdomu%TYPE,
                                             input_NumerMieszkania in adresy.numermieszkania%TYPE) IS 
BEGIN
    DECLARE cnt INT;
    BEGIN
        SELECT COUNT(*) INTO cnt FROM adresy WHERE input_KodPocztowy = adresy.kodpocztowy AND
                                                   input_Miejscowosc = adresy.miejscowosc AND
                                                   input_Ulica = adresy.ulica AND
                                                   input_NumerMieszkania = adresy.numermieszkania;
        IF(cnt = 0) THEN
            INSERT INTO Adresy(kodpocztowy, miejscowosc, ulica, numerdomu, numermieszkania)
            VALUES(input_KodPocztowy, input_Miejscowosc, input_Ulica, input_NumerDomu, input_NumerMieszkania);
        END IF;
    END;
END;
/
create or replace procedure insert_new_klient(input_Imie in klienci.imie%TYPE,
                                              input_DrugieImie in klienci.drugieimie%TYPE,
                                              input_Nazwisko in klienci.nazwisko%TYPE,
                                              input_PESEL in klienci.pesel%TYPE,
                                              input_NrTel in klienci.numertel%TYPE,
                                              input_KategoriaPrawaJazdy in klienci.katprawajazdy%TYPE,
                                              input_KodPocztowy in adresy.kodpocztowy%TYPE,
                                              input_Miejscowosc in adresy.miejscowosc%TYPE,
                                              input_Ulica in adresy.ulica%TYPE,
                                              input_NumerDomu in adresy.numerdomu%TYPE,
                                              input_NumerMieszkania in adresy.numermieszkania%TYPE) IS 
BEGIN
    DECLARE 
    index_value INT := 0;
    cnt INT := 0;
    BEGIN
        SELECT COUNT(*) INTO cnt FROM Klienci WHERE input_PESEL = klienci.pesel;
        IF(cnt = 0) THEN
            insert_new_adres(input_KodPocztowy, input_Miejscowosc, input_Ulica, input_NumerDomu, input_NumerMieszkania);
            SELECT ID_Adresu INTO index_value FROM Adresy WHERE adresy.kodpocztowy = input_KodPocztowy AND
                                                                adresy.miejscowosc = input_Miejscowosc AND 
                                                                adresy.ulica = input_Ulica AND
                                                                adresy.numerdomu = input_NumerDomu AND
                                                                adresy.numermieszkania = input_NumerMieszkania;

            INSERT INTO Klienci(id_adresu, imie, drugieimie, nazwisko, pesel, numertel, katprawajazdy)
            VALUES(index_value, input_Imie, input_DrugieImie, input_Nazwisko, input_PESEL, input_NrTel, input_KategoriaPrawaJazdy);
        END IF;
    END;
END;
/
create or replace procedure insert_new_model(input_Model in modele.model%TYPE,
                                             input_Pojemnosc in modele.pojemnoscsilnika%TYPE,
                                             input_Spalanie in modele.sredniespalanie%TYPE,
                                             input_KatPrawaJazdy in modele.kategoriaprawajazdy%TYPE,
                                             input_Stawka in modele.stawkazadzien%TYPE) IS 
BEGIN
    DECLARE 
    cnt INT := 0;
    BEGIN
        SELECT COUNT(*) INTO cnt FROM Modele WHERE input_Model in modele.model AND
                                                   input_Pojemnosc in modele.pojemnoscsilnika AND
                                                   input_Spalanie in modele.sredniespalanie AND
                                                   input_KatPrawaJazdy in modele.kategoriaprawajazdy AND
                                                   input_Stawka in modele.stawkazadzien;
        IF(cnt = 0) THEN
            INSERT INTO Modele(model, pojemnoscsilnika, sredniespalanie, kategoriaprawajazdy, stawkazadzien)
            VALUES(input_Model, input_Pojemnosc, input_Spalanie, input_KatPrawaJazdy, input_Stawka);
        END IF;
    END;
END;
/
create or replace procedure insert_new_pojazd(input_NumerVIN in pojazdy.numervin%TYPE,
                                              input_NumerRej in pojazdy.numerrejestracyjny%TYPE,
                                              input_Rocznik in pojazdy.rocznik%TYPE,
                                              input_Przebieg in pojazdy.przebieg%TYPE,
                                              input_DataPrzegladu in pojazdy.datawaznosciprzegladu%TYPE,
                                              input_Uszkodzony in pojazdy.uszkodzony%TYPE,
                                              input_Model in modele.model%TYPE,
                                              input_Pojemnosc in modele.pojemnoscsilnika%TYPE,
                                              input_Spalanie in modele.sredniespalanie%TYPE,
                                              input_KatPrawaJazdy in modele.kategoriaprawajazdy%TYPE,
                                              input_Stawka in modele.stawkazadzien%TYPE) IS 
BEGIN
    DECLARE 
    index_value INT := 0;
    cnt INT := 0;
    BEGIN
        SELECT COUNT(*) INTO cnt FROM Pojazdy WHERE input_NumerVIN in pojazdy.numervin;
        IF(cnt = 0) THEN
            insert_new_model(input_Model, input_Pojemnosc, input_Spalanie, input_KatPrawaJazdy, input_Stawka);
            SELECT ID_Modelu INTO index_value FROM Modele WHERE input_Model in modele.model AND
                                                                input_Pojemnosc in modele.pojemnoscsilnika AND
                                                                input_Spalanie in modele.sredniespalanie AND
                                                                input_KatPrawaJazdy in modele.kategoriaprawajazdy AND
                                                                input_Stawka in modele.stawkazadzien;

            INSERT INTO Pojazdy(id_modelu, numervin, numerrejestracyjny, rocznik, przebieg, datawaznosciprzegladu, uszkodzony)
            VALUES(index_value, input_NumerVIN, input_NumerRej, input_Rocznik, input_Przebieg, input_DataPrzegladu, input_Uszkodzony);
        END IF;
    END;
END;
/
create or replace procedure insert_new_wypozyczalnia(input_IloscMiejsc in wypozyczalnie.wolnemiejsca%TYPE,
                                                     input_KodPocztowy in adresy.kodpocztowy%TYPE,
                                                     input_Miejscowosc in adresy.miejscowosc%TYPE,
                                                     input_Ulica in adresy.ulica%TYPE,
                                                     input_NumerDomu in adresy.numerdomu%TYPE,
                                                     input_NumerMieszkania in adresy.numermieszkania%TYPE) IS 
BEGIN
    DECLARE 
    index_value INT := 0;
    cnt INT := 0;
    BEGIN
        SELECT COUNT(*) INTO cnt FROM Adresy WHERE input_KodPocztowy = adresy.kodpocztowy AND
                                                   input_Miejscowosc = adresy.miejscowosc AND
                                                   input_Ulica = adresy.ulica AND
                                                   input_NumerMieszkania = adresy.numermieszkania;
        IF(cnt = 0) THEN
            insert_new_adres(input_KodPocztowy, input_Miejscowosc, input_Ulica, input_NumerDomu, input_NumerMieszkania);
            
            SELECT ID_Adresu INTO index_value FROM Adresy WHERE adresy.kodpocztowy = input_KodPocztowy AND
                                                                adresy.miejscowosc = input_Miejscowosc AND 
                                                                adresy.ulica = input_Ulica AND
                                                                adresy.numerdomu = input_NumerDomu AND
                                                                adresy.numermieszkania = input_NumerMieszkania;
            INSERT INTO Wypozyczalnie(id_adresu, wolnemiejsca)
            VALUES(index_value, input_IloscMiejsc);
        END IF;
    END;
END;
/
COMMIT;

