--DEFAULT DATA CONFIGURATION---------------------------------------------------
    execute insert_new_wypozyczalnia(0, 2000, '53-300', 'Wroclaw', 'Fabryczna', 12, 33);
     
    execute insert_new_klient('Jacek','NULL','Nowak','97070206811','103456781', 'B', '53-300', 'Wroclaw', 'Kasztanowa', 1, 1);
    execute insert_new_klient('Wojciech', NULL, 'Krzykala', '22345678922', '123456782', 'B', '53-300', 'Wroclaw', 'Akacjowa', 2, 2);
    execute insert_new_klient('Andrzej','Piotr','Jurek','97070206843','323456783', 'B', '53-300', 'Wroclaw', 'Florkowa', 3, 3);
    execute insert_new_klient('Waldemar', NULL, 'Adamski', '12345678954', '423456784', 'B', '53-300', 'Wroclaw', 'Fiolkowa', 4, 4);
    execute insert_new_klient('Maciek','Tadeusz','Kowalewski','97070206865','523456785', 'B', '53-300', 'Wroclaw', 'Akacjowa', 5, 5);
    execute insert_new_klient('Wojciech', NULL, 'Lewicki', '12345678976', '623456786', 'B', '53-300', 'Wroclaw', 'Glogowa', 6, 6);
    execute insert_new_klient('Maja','NULL','Kula','97070206837','723456797', 'B', '53-300', 'Wroclaw', 'Jarzebinowa', 7, 7);
    execute insert_new_klient('Ola', NULL, 'Konefal', '12345678918', '823456188', 'B', '53-300', 'Wroclaw', 'Paryska', 8, 8);
    
    execute insert_new_pojazd('A1234567890QW36O1', 'DW1231', TO_DATE('2011-05-03', 'yyyy-mm-dd'), 325146, TO_DATE('2021-01-03', 'yyyy-mm-dd'), '0', 0, 'Mercedes W200', 2000, 13, 'B', 199);
    execute insert_new_pojazd('B1269567890XX3702', 'DW1232', TO_DATE('2012-06-21', 'yyyy-mm-dd'), 410789, TO_DATE('2021-02-21', 'yyyy-mm-dd'), '0', 0, 'BMW E30', 2000, 13, 'B', 299);
    execute insert_new_pojazd('C1269567890AA3703', 'DW1693', TO_DATE('2013-03-17', 'yyyy-mm-dd'), 210789, TO_DATE('2021-03-21', 'yyyy-mm-dd'), '0', 0, 'Audi A4', 2000, 10, 'B', 399);
    execute insert_new_pojazd('D1269567890ZZ3704', 'DW1234', TO_DATE('2014-02-02', 'yyyy-mm-dd'), 230128, TO_DATE('2021-04-21', 'yyyy-mm-dd'), '0', 0, 'Audi A6', 2000, 12, 'B', 499);
    execute insert_new_pojazd('E1234567890QW36O5', 'DW1235', TO_DATE('2015-05-03', 'yyyy-mm-dd'), 325146, TO_DATE('2021-05-03', 'yyyy-mm-dd'), '0', 0, 'BMW E30', 2000, 13, 'B', 599);
    execute insert_new_pojazd('F1269567890XX3706', 'DW1236', TO_DATE('2016-06-21', 'yyyy-mm-dd'), 410789, TO_DATE('2021-06-21', 'yyyy-mm-dd'), '0', 0, 'BMW E30', 2000, 13, 'B', 699);
    execute insert_new_pojazd('G1269567890AA3707', 'DW1697', TO_DATE('2017-03-17', 'yyyy-mm-dd'), 210789, TO_DATE('2021-07-21', 'yyyy-mm-dd'), '0', 0, 'Audi A4', 2000, 10, 'B', 799);
    execute insert_new_pojazd('H1269567890ZZ3708', 'DW1238', TO_DATE('2018-02-02', 'yyyy-mm-dd'), 230128, TO_DATE('2021-08-21', 'yyyy-mm-dd'), '0', 0, 'Audi A6', 2000, 12, 'B', 899);
    
    execute insert_new_wypozyczenie(0,'97070206811','DW1231',TO_DATE('2020-11-03', 'yyyy-mm-dd'),2000);
    execute insert_new_wypozyczenie(0,'22345678922','DW1232',TO_DATE('2021-01-03', 'yyyy-mm-dd'),3000);
                            
    execute insert_new_zwrot(0,'TAK','TAK','97070206811','DW1231');
    execute insert_new_zwrot(0,'TAK','NIE','22345678922','DW1232');
-------------------------------------------------------------------------------
COMMIT;