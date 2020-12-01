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
                                              input_AktualnaWypozyczalnia in pojazdy.aktualnawypozyczalnia%TYPE,
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

            INSERT INTO Pojazdy(id_modelu, numervin, numerrejestracyjny, rocznik, przebieg, datawaznosciprzegladu, uszkodzony, aktualnawypozyczalnia)
            VALUES(index_value, input_NumerVIN, input_NumerRej, input_Rocznik, input_Przebieg, input_DataPrzegladu, input_Uszkodzony, input_AktualnaWypozyczalnia);
        END IF;
    END;
END;
/
create or replace procedure insert_new_wypozyczalnia(input_NumerWypozyczalni in wypozyczalnie.numerwypozyczalni%TYPE,
                                                     input_IloscMiejsc in wypozyczalnie.wolnemiejsca%TYPE,
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
            INSERT INTO Wypozyczalnie(id_adresu, wolnemiejsca, numerwypozyczalni)
            VALUES(index_value, input_IloscMiejsc, input_NumerWypozyczalni);
        END IF;
    END;
END;
/
create or replace procedure insert_new_wypozyczenie(input_NumerWypozyczalni in wypozyczalnie.numerwypozyczalni%TYPE,
                                                    input_PeselKlienta in klienci.pesel%TYPE,
                                                    input_NumerRejPojazdu in pojazdy.numerrejestracyjny%TYPE,
                                                    input_PlanowanyTerminZwrotu in wypozyczenia.planowanyterminzwrotu%TYPE,
                                                    input_PobranaKaucja in wypozyczenia.pobranakaucja%TYPE) IS 
BEGIN
    DECLARE 
    index_wypozyczalni INT := 0;
    index_klienta INT := 0;
    index_pojazdu INT := 0;
    termin_wypozyczenia DATE := CURRENT_DATE;
    cnt INT := 0;
    BEGIN
        SELECT ID_Wypozyczalni INTO index_wypozyczalni FROM Wypozyczalnie WHERE wypozyczalnie.numerwypozyczalni = input_NumerWypozyczalni;
        SELECT ID_Klienta INTO index_klienta FROM Klienci WHERE klienci.pesel = input_PeselKlienta;
        SELECT ID_Pojazdu INTO index_pojazdu FROM Pojazdy WHERE pojazdy.numerrejestracyjny = input_NumerRejPojazdu;
        
        SELECT COUNT(*) INTO cnt from SHOW_ALL_ACTIVE_RENTALS WHERE id_pojazdu = ID_Pojazdu;
        IF(cnt = 0) THEN
            INSERT INTO Wypozyczenia(id_wypozyczalni, id_klienta, id_pojazdu, id_zwrotu, terminwypozyczenia, planowanyterminzwrotu, pobranakaucja)
            VALUES(index_wypozyczalni, index_klienta, index_pojazdu, NULL, termin_wypozyczenia, input_PlanowanyTerminZwrotu, input_PobranaKaucja);
        END IF;
    END;
END;
/
COMMIT;

