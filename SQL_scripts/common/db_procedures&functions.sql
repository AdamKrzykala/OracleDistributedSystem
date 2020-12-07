
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
create or replace procedure update_adres(input_ID_Adresu in adresy.id_adresu%TYPE,
                                         input_KodPocztowy in adresy.kodpocztowy%TYPE,
                                         input_Miejscowosc in adresy.miejscowosc%TYPE,
                                         input_Ulica in adresy.ulica%TYPE,
                                         input_NumerDomu in adresy.numerdomu%TYPE,
                                         input_NumerMieszkania in adresy.numermieszkania%TYPE) IS 
BEGIN
    UPDATE Adresy SET adresy.kodpocztowy = input_KodPocztowy,
                      adresy.miejscowosc = input_Miejscowosc,
                      adresy.ulica = input_Ulica,
                      adresy.numerdomu = input_NumerDomu,
                      adresy.numermieszkania = input_NumerMieszkania 
    WHERE input_ID_Adresu = adresy.id_adresu;
END;
/
create or replace procedure delete_adres(input_ID_Adresu in adresy.id_adresu%TYPE) IS 
BEGIN
    DELETE FROM Adresy@WYPOZYCZALNIA_ADAM WHERE input_ID_Adresu = adresy.id_adresu;
    DELETE FROM Adresy@WYPOZYCZALNIA_MICHAL WHERE input_ID_Adresu = adresy.id_adresu;
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
create or replace procedure update_klient(input_ID_Klienta in klienci.id_klienta%TYPE,
                                          input_Imie in klienci.imie%TYPE,
                                          input_DrugieImie in klienci.drugieimie%TYPE,
                                          input_Nazwisko in klienci.nazwisko%TYPE,
                                          input_PESEL in klienci.pesel%TYPE,
                                          input_NrTel in klienci.numertel%TYPE,
                                          input_KategoriaPrawaJazdy in klienci.katprawajazdy%TYPE) IS 
BEGIN
    UPDATE Klienci SET klienci.imie = input_Imie,
                       klienci.drugieimie = input_DrugieImie,
                       klienci.nazwisko = input_Nazwisko,
                       klienci.pesel = input_PESEL,
                       klienci.numertel = input_NrTel,
                       klienci.katprawajazdy = input_KategoriaPrawaJazdy
    WHERE input_ID_Klienta = klienci.id_klienta;
END;
/
create or replace procedure delete_klient(input_ID_Klienta in klienci.id_klienta%TYPE) IS 
BEGIN
    DELETE FROM Klienci@WYPOZYCZALNIA_ADAM WHERE input_ID_Klienta = klienci.id_klienta;
    DELETE FROM Klienci@WYPOZYCZALNIA_MICHAL WHERE input_ID_Klienta = klienci.id_klienta;
END;
/
create or replace procedure insert_new_model(input_Model in ModeleServer.model%TYPE,
                                             input_Pojemnosc in ModeleServer.pojemnoscsilnika%TYPE,
                                             input_Spalanie in ModeleServer.sredniespalanie%TYPE,
                                             input_KatPrawaJazdy in ModeleServer.kategoriaprawajazdy%TYPE,
                                             input_Stawka in ModeleServer.stawkazadzien%TYPE) IS 
BEGIN
    DECLARE 
    cnt INT := 0;
    BEGIN
        SELECT COUNT(*) INTO cnt FROM ModeleServer WHERE input_Model in ModeleServer.model AND
                                                       input_Pojemnosc in ModeleServer.pojemnoscsilnika AND
                                                       input_Spalanie in ModeleServer.sredniespalanie AND
                                                       input_KatPrawaJazdy in ModeleServer.kategoriaprawajazdy AND
                                                       input_Stawka in ModeleServer.stawkazadzien;
        IF(cnt = 0) THEN
            INSERT INTO ModeleServer(model, pojemnoscsilnika, sredniespalanie, kategoriaprawajazdy, stawkazadzien)
            VALUES(input_Model, input_Pojemnosc, input_Spalanie, input_KatPrawaJazdy, input_Stawka);
        END IF;
    END;
END;
/
create or replace procedure update_model(input_ID_Modelu in modeleServer.id_modelu%TYPE,
                                         input_Model in modeleServer.model%TYPE,
                                         input_Pojemnosc in modeleServer.pojemnoscsilnika%TYPE,
                                         input_Spalanie in modeleServer.sredniespalanie%TYPE,
                                         input_KatPrawaJazdy in modeleServer.kategoriaprawajazdy%TYPE,
                                         input_Stawka in modeleServer.stawkazadzien%TYPE) IS 
BEGIN
    UPDATE ModeleServer SET modeleServer.model = modeleServer.model,
                            modeleServer.pojemnoscsilnika = modeleServer.pojemnoscsilnika,
                            modeleServer.sredniespalanie = modeleServer.sredniespalanie,
                            modeleServer.kategoriaprawajazdy = modeleServer.kategoriaprawajazdy,
                            modeleServer.stawkazadzien = modeleServer.stawkazadzien
    WHERE input_ID_Modelu = modeleServer.id_modelu;
END;
/
create or replace procedure delete_model(input_ID_Modelu in modeleServer.id_modelu%TYPE) IS 
BEGIN
    DELETE FROM ModeleServer WHERE input_ID_Modelu = modeleServer.id_modelu;
END;
/
create or replace procedure insert_new_pojazd(input_NumerVIN in pojazdy.numervin%TYPE,
                                              input_NumerRej in pojazdy.numerrejestracyjny%TYPE,
                                              input_Rocznik in pojazdy.rocznik%TYPE,
                                              input_Przebieg in pojazdy.przebieg%TYPE,
                                              input_DataPrzegladu in pojazdy.datawaznosciprzegladu%TYPE,
                                              input_Uszkodzony in pojazdy.uszkodzony%TYPE,
                                              input_AktualnaWypozyczalnia in pojazdy.aktualnawypozyczalnia%TYPE,
                                              input_Model in modeleServer.model%TYPE,
                                              input_Pojemnosc in modeleServer.pojemnoscsilnika%TYPE,
                                              input_Spalanie in modeleServer.sredniespalanie%TYPE,
                                              input_KatPrawaJazdy in modeleServer.kategoriaprawajazdy%TYPE,
                                              input_Stawka in modeleServer.stawkazadzien%TYPE) IS 
BEGIN
    DECLARE 
    index_value INT := 0;
    cnt INT := 0;
    current_usr VARCHAR2(30) := '';
    BEGIN
        SELECT COUNT(*) INTO cnt FROM Pojazdy WHERE input_NumerVIN in pojazdy.numervin;
        IF(cnt = 0) THEN
            insert_new_model(input_Model, input_Pojemnosc, input_Spalanie, input_KatPrawaJazdy, input_Stawka);
            SELECT ID_Modelu INTO index_value FROM ModeleServer WHERE input_Model in modeleServer.model AND
                                                                input_Pojemnosc in modeleServer.pojemnoscsilnika AND
                                                                input_Spalanie in modeleServer.sredniespalanie AND
                                                                input_KatPrawaJazdy in modeleServer.kategoriaprawajazdy AND
                                                                input_Stawka in modeleServer.stawkazadzien;

            INSERT INTO Pojazdy(id_modelu, numervin, numerrejestracyjny, rocznik, przebieg, datawaznosciprzegladu, uszkodzony, aktualnawypozyczalnia)
            VALUES(index_value, input_NumerVIN, input_NumerRej, input_Rocznik, input_Przebieg, input_DataPrzegladu, input_Uszkodzony, input_AktualnaWypozyczalnia);
            
            select user into current_usr from dual;
            DBMS_STATS.GATHER_TABLE_STATS(current_usr,'POJAZDY');
        END IF;
    END;
END;
/
create or replace procedure update_pojazd(input_ID_Pojazdu in pojazdy.id_pojazdu%TYPE,
                                          input_NumerVIN in pojazdy.numervin%TYPE,
                                          input_NumerRej in pojazdy.numerrejestracyjny%TYPE,
                                          input_Rocznik in pojazdy.rocznik%TYPE,
                                          input_Przebieg in pojazdy.przebieg%TYPE,
                                          input_DataPrzegladu in pojazdy.datawaznosciprzegladu%TYPE,
                                          input_Uszkodzony in pojazdy.uszkodzony%TYPE) IS 
BEGIN
    UPDATE Pojazdy SET pojazdy.numervin = input_NumerVIN,
                       pojazdy.numerrejestracyjny = input_NumerRej,
                       pojazdy.rocznik = input_Rocznik,
                       pojazdy.przebieg = input_Przebieg,
                       pojazdy.datawaznosciprzegladu = input_DataPrzegladu,
                       pojazdy.uszkodzony = input_Uszkodzony
    WHERE input_ID_Pojazdu = pojazdy.id_pojazdu;
END;
/
create or replace procedure delete_pojazd(input_ID_Pojazdu in pojazdy.id_pojazdu%TYPE) IS 
BEGIN
    DELETE FROM Pojazdy WHERE input_ID_Pojazdu = pojazdy.id_pojazdu;
END;
/
create or replace procedure insert_new_wypozyczalnia(input_NumerWypozyczalni in wypozyczalnieServer.numerwypozyczalni%TYPE,
                                                     input_IloscMiejsc in wypozyczalnieServer.wolnemiejsca%TYPE,
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
                                                   input_NumerDomu = adresy.numerdomu AND
                                                   input_NumerMieszkania = adresy.numermieszkania;
        IF(cnt = 0) THEN
            insert_new_adres(input_KodPocztowy, input_Miejscowosc, input_Ulica, input_NumerDomu, input_NumerMieszkania);
            SELECT ID_Adresu INTO index_value FROM Adresy WHERE adresy.kodpocztowy = input_KodPocztowy AND
                                                            adresy.miejscowosc = input_Miejscowosc AND 
                                                            adresy.ulica = input_Ulica AND
                                                            adresy.numerdomu = input_NumerDomu AND
                                                            adresy.numermieszkania = input_NumerMieszkania;
            INSERT INTO wypozyczalnieServer(id_adresu, wolnemiejsca, numerwypozyczalni)
            VALUES(index_value, input_IloscMiejsc, input_NumerWypozyczalni);
        END IF;
        
        
    END;
END;
/
create or replace procedure update_wypozyczalnia(input_ID_Wypozyczalni in wypozyczalnieServer.id_wypozyczalni%TYPE,
                                                 input_NumerWypozyczalni in wypozyczalnieServer.numerwypozyczalni%TYPE,
                                                 input_IloscMiejsc in wypozyczalnieServer.wolnemiejsca%TYPE) IS 
BEGIN
    UPDATE wypozyczalnieServer SET wypozyczalnieServer.numerwypozyczalni = input_NumerWypozyczalni,
                             wypozyczalnieServer.wolnemiejsca = input_IloscMiejsc
    WHERE input_ID_Wypozyczalni = wypozyczalnieServer.id_wypozyczalni;
END;
/
create or replace procedure delete_wypozyczalnia(input_ID_Wypozyczalni in wypozyczalnieServer.id_wypozyczalni%TYPE) IS 
BEGIN
    DELETE FROM wypozyczalnieServer WHERE input_ID_Wypozyczalni = wypozyczalnieServer.id_wypozyczalni;
END;
/
create or replace procedure insert_new_wypozyczenie(input_NumerWypozyczalni in wypozyczalnieServer.numerwypozyczalni%TYPE,
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
    active_rental Wypozyczenia%ROWTYPE;
    BEGIN
        SELECT ID_Wypozyczalni INTO index_wypozyczalni FROM wypozyczalnieServer WHERE wypozyczalnieServer.numerwypozyczalni = input_NumerWypozyczalni;
        SELECT ID_Klienta INTO index_klienta FROM Klienci WHERE klienci.pesel = input_PeselKlienta;
        SELECT ID_Pojazdu INTO index_pojazdu FROM Pojazdy WHERE pojazdy.numerrejestracyjny = input_NumerRejPojazdu;
        
        SELECT COUNT(*) INTO cnt FROM SHOW_ALL_ACTIVE_RENTALS WHERE id_pojazdu = index_pojazdu;
        IF(cnt = 0) THEN
            INSERT INTO Wypozyczenia(id_wypozyczalni, id_klienta, id_pojazdu, id_zwrotu, terminwypozyczenia, planowanyterminzwrotu, pobranakaucja)
            VALUES(index_wypozyczalni, index_klienta, index_pojazdu, NULL, termin_wypozyczenia, input_PlanowanyTerminZwrotu, input_PobranaKaucja);
        END IF;
    END;
END;
/
create or replace procedure update_wypozyczenie(input_ID_Wypozyczenia in wypozyczenia.id_wypozyczenia%TYPE,
                                                input_PlanowanyTerminZwrotu in wypozyczenia.planowanyterminzwrotu%TYPE,
                                                input_PobranaKaucja in wypozyczenia.pobranakaucja%TYPE) IS 
BEGIN
    UPDATE Wypozyczenia SET wypozyczenia.planowanyterminzwrotu = input_PlanowanyTerminZwrotu,
                            wypozyczenia.pobranakaucja = input_PobranaKaucja
    WHERE input_ID_Wypozyczenia = wypozyczenia.id_wypozyczenia;
END;
/
create or replace procedure delete_wypozyczenie(input_ID_Wypozyczenia in wypozyczenia.id_wypozyczenia%TYPE) IS 
BEGIN
    DELETE FROM Wypozyczenia WHERE input_ID_Wypozyczenia = wypozyczenia.id_wypozyczenia;
END;
/
create or replace procedure insert_new_zwrot(input_NumerWypozyczalni in wypozyczalnieServer.numerwypozyczalni%TYPE,
                                             input_Zaplacono in zwroty.zaplacono%TYPE,
                                             input_ZwrotKaucji in zwroty.zwrotkaucji%TYPE,
                                             input_PeselKlienta in klienci.pesel%TYPE,
                                             input_NumerRejPojazdu in pojazdy.numerrejestracyjny%TYPE) IS 
BEGIN
    DECLARE 
    index_wypozyczalni INT := 0;
    index_klienta INT := 0;
    index_pojazdu INT := 0;
    index_zwrotu INT := 0;
    index_wypozyczenia INT := 0;
    termin_zwrotu DATE := CURRENT_DATE;
    planowany_termin_zwrotu DATE;
    kara_za_spoznienie zwroty.karazaspoznienie%TYPE := 0;
    cnt INT := 0;
    BEGIN
        SELECT ID_Wypozyczalni INTO index_wypozyczalni FROM wypozyczalnieServer WHERE wypozyczalnieServer.numerwypozyczalni = input_NumerWypozyczalni;
        SELECT ID_Klienta INTO index_klienta FROM Klienci WHERE klienci.pesel = input_PeselKlienta;
        SELECT ID_Pojazdu INTO index_pojazdu FROM Pojazdy WHERE pojazdy.numerrejestracyjny = input_NumerRejPojazdu;
        
        SELECT COUNT(*) INTO cnt FROM SHOW_ALL_ACTIVE_RENTALS WHERE id_pojazdu = index_pojazdu;
        SELECT id_wypozyczenia INTO index_wypozyczenia FROM SHOW_ALL_ACTIVE_RENTALS WHERE id_pojazdu = index_pojazdu;
        
        IF(cnt = 1) THEN
            SELECT PlanowanyTerminZwrotu INTO planowany_termin_zwrotu from Wypozyczenia WHERE wypozyczenia.id_wypozyczenia = index_wypozyczenia;
            
            IF(planowany_termin_zwrotu - termin_zwrotu < 0) THEN
                kara_za_spoznienie := 3000;
            END IF;
            
            INSERT INTO Zwroty(id_wypozyczalni, terminzwrotu, zaplacono, karazaspoznienie, zwrotkaucji)
            VALUES(index_wypozyczalni, termin_zwrotu, input_Zaplacono, kara_za_spoznienie, input_ZwrotKaucji);
            
            SELECT id_zwrotu INTO index_zwrotu FROM Zwroty WHERE id_wypozyczalni = index_wypozyczalni AND
                                                                 terminzwrotu = termin_zwrotu AND
                                                                 zaplacono = input_Zaplacono AND
                                                                 karazaspoznienie = kara_za_spoznienie AND
                                                                 zwrotkaucji = input_ZwrotKaucji;
                                                                 
            UPDATE wypozyczenia@WYPOZYCZALNIA_MICHAL SET id_zwrotu = index_zwrotu WHERE id_wypozyczenia = index_wypozyczenia;
            UPDATE wypozyczenia@WYPOZYCZALNIA_ADAM SET id_zwrotu = index_zwrotu WHERE id_wypozyczenia = index_wypozyczenia;
        END IF;
    END;
END;
/
create or replace procedure update_zwrot(input_ID_Zwrotu in zwroty.id_zwrotu%TYPE,
                                         input_Zaplacono in zwroty.zaplacono%TYPE,
                                         input_ZwrotKaucji in zwroty.zwrotkaucji%TYPE) IS 
BEGIN
    UPDATE Zwroty SET zwroty.zaplacono = input_Zaplacono,
                      zwroty.zwrotkaucji = input_ZwrotKaucji
    WHERE input_ID_Zwrotu = zwroty.id_zwrotu;
END;
/
create or replace procedure delete_zwrot(input_ID_Zwrotu in zwroty.id_zwrotu%TYPE) IS 
BEGIN
    DELETE FROM Zwroty WHERE input_ID_Zwrotu = zwroty.id_zwrotu;
END;
/
COMMIT;