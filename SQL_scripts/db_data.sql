--DEFAULT DATA CONFIGURATION---------------------------------------------------
BEGIN
   insert_new_adres('53-225', 'Buczacz', 'Narcyzowa', 11, 2);
   insert_new_adres('53-225', 'Buczacz', 'Narcyzowa', 11, 1);
   insert_new_adres('59-700', 'Boleslawiec', 'Jarzebinowa', 7, 4);
   insert_new_klient('Michal', 'Stanislaw', 'Nowak', '97070206830', '123456789', 'B', '53-225', 'Buczacz', 'Narcyzowa', 11, 2);
   insert_new_klient('Adam', NULL, 'Krzykala', '12345678919', '123456789', 'B', '59-700', 'Boleslawiec', 'Jarzebinowa', 7, 4);
   insert_new_klient('Adam', NULL, 'Krzykala', '12345678919', '123456789', 'B', '59-700', 'Boleslawiec', 'Jarzebinowa', 7, 4);
END;
-------------------------------------------------------------------------------
COMMIT;