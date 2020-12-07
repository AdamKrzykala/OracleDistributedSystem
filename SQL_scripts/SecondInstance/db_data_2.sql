--DEFAULT DATA CONFIGURATION---------------------------------------------------
    execute insert_new_wypozyczalnia(1, 1000, '59-700', 'Boleslawiec', 'Sierpnia 80', 11, 4);
     
    execute insert_new_klient('Adam','NULL','Nowak','97070206831','123456781', 'B', '59-700', 'Boleslawiec', 'Kasztanowa', 1, 1);
    execute insert_new_klient('Mariusz', NULL, 'Krzykala', '12345678912', '123456782', 'B', '59-700', 'Boleslawiec', 'Akacjowa', 2, 2);
    execute insert_new_klient('Artur','Andrzej','Kowalski','97070206833','123456783', 'B', '59-700', 'Boleslawiec', 'Florkowa', 3, 3);
    execute insert_new_klient('Maciek', NULL, 'Nowacki', '12345678914', '123456784', 'B', '59-700', 'Boleslawiec', 'Fiolkowa', 4, 4);
    execute insert_new_klient('Waldemar','Piotr','Kowalewski','97070206835','123456785', 'B', '59-700', 'Boleslawiec', 'Akacjowa', 5, 5);
    execute insert_new_klient('Aleksander', NULL, 'Lewicki', '12345678916', '123456786', 'B', '59-700', 'Boleslawiec', 'Glogowa', 6, 6);
    execute insert_new_klient('Maria','NULL','Nowak','97070206837','123456787', 'B', '59-700', 'Boleslawiec', 'Jarzebinowa', 7, 7);
    execute insert_new_klient('Jagoda', NULL, 'Krzykala', '12345678918', '123456788', 'B', '59-700', 'Boleslawiec', 'Paryska', 8, 8);
    
    execute insert_new_pojazd('V1234567890QA36O1', 'DBL1221', TO_DATE('2011-05-03', 'yyyy-mm-dd'), 325146, TO_DATE('2021-01-03', 'yyyy-mm-dd'), '0', 1, 'BMW E30', 2000, 13, 'B', 199);
    execute insert_new_pojazd('A1269567890AX3702', 'DBL1232', TO_DATE('2012-06-21', 'yyyy-mm-dd'), 410789, TO_DATE('2021-02-21', 'yyyy-mm-dd'), '0', 1, 'BMW E30', 2000, 13, 'B', 299);
    execute insert_new_pojazd('B1269567890AA3703', 'DBL1693', TO_DATE('2013-03-17', 'yyyy-mm-dd'), 210789, TO_DATE('2021-03-21', 'yyyy-mm-dd'), '0', 1, 'Audi A4', 2000, 10, 'B', 399);
    execute insert_new_pojazd('C1269567890ZZ3704', 'DBL1234', TO_DATE('2014-02-02', 'yyyy-mm-dd'), 230128, TO_DATE('2021-04-21', 'yyyy-mm-dd'), '0', 1, 'Audi A6', 2000, 12, 'B', 499);
    execute insert_new_pojazd('V1234567890QW36O5', 'DBL1235', TO_DATE('2015-05-03', 'yyyy-mm-dd'), 325146, TO_DATE('2021-05-03', 'yyyy-mm-dd'), '0', 1, 'BMW E30', 2000, 13, 'B', 599);
    execute insert_new_pojazd('A1269567890XX3706', 'DBL1236', TO_DATE('2016-06-21', 'yyyy-mm-dd'), 410789, TO_DATE('2021-06-21', 'yyyy-mm-dd'), '0', 1, 'BMW E30', 2000, 13, 'B', 699);
    execute insert_new_pojazd('B1269567890AA3707', 'DBL1697', TO_DATE('2017-03-17', 'yyyy-mm-dd'), 210789, TO_DATE('2021-07-21', 'yyyy-mm-dd'), '0', 1, 'Audi A4', 2000, 10, 'B', 799);
    execute insert_new_pojazd('C1269567890ZZ3708', 'DBL1238', TO_DATE('2018-02-02', 'yyyy-mm-dd'), 230128, TO_DATE('2021-08-21', 'yyyy-mm-dd'), '0', 1, 'Audi A6', 2000, 12, 'B', 899);

    execute insert_new_wypozyczenie(1,'97070206831','DBL1231',TO_DATE('2020-11-03', 'yyyy-mm-dd'),2000);
    execute insert_new_wypozyczenie(1,'12345678912','DBL1232',TO_DATE('2021-01-03', 'yyyy-mm-dd'),3000);
                            
    execute insert_new_zwrot(1,'TAK','TAK','97070206831','DBL1231');
    execute insert_new_zwrot(1,'TAK','NIE','12345678912','DBL1232');
-------------------------------------------------------------------------------
COMMIT;