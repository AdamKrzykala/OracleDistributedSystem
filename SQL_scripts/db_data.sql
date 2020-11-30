--DEFAULT DATA CONFIGURATION---------------------------------------------------
BEGIN
    insert_new_klient('Michal', 'Stanislaw', 'Nowak', '97070206830', '123456789', 'B', '53-225', 'Buczacz', 'Narcyzowa', 11, 2);
    insert_new_klient('Adam', NULL, 'Krzykala', '12345678919', '123456789', 'B', '59-700', 'Boleslawiec', 'Jarzebinowa', 7, 4);
    
    insert_new_wypozyczalnia(0, 2000, '53-225', 'Wroclaw', 'Fabryczna', 113, 13);
    insert_new_wypozyczalnia(1, 1000, '59-700', 'Boleslawiec', 'Sierpnia 80', 11, 4);
    
    insert_new_pojazd('V1234567890QW36O8', 'DW1234', TO_DATE('2003/05/03', 'yyyy/mm/dd'), 325146, TO_DATE('2021/05/03', 'yyyy/mm/dd'), '0', 0, 'BMW E30', 2000, 13, 'B', 299);
    insert_new_pojazd('A1269567890XX3702', 'DW1235', TO_DATE('2003/06/21', 'yyyy/mm/dd'), 410789, TO_DATE('2021/06/21', 'yyyy/mm/dd'), '0', 1, 'BMW E30', 2000, 13, 'B', 299);
    insert_new_pojazd('B1269567890AA3702', 'DW1695', TO_DATE('2006/03/17', 'yyyy/mm/dd'), 210789, TO_DATE('2021/02/21', 'yyyy/mm/dd'), '0', 0, 'Audi A4', 2000, 10, 'B', 199);
    insert_new_pojazd('C1269567890ZZ3702', 'DW1237', TO_DATE('2009/02/02', 'yyyy/mm/dd'), 230128, TO_DATE('2021/07/21', 'yyyy/mm/dd'), '0', 1, 'Audi A6', 2000, 12, 'B', 399);
END;
-------------------------------------------------------------------------------
COMMIT;