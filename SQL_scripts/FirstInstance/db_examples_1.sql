-- KLIENT
--dodanie klienta
execute insert_new_klient('Kacper','NULL','Wojno','99070206831','123455781', 'B', '59-700', 'Boleslawiec', 'Eukaliptusowa', 2, 20);
--aktualizacja nr.tel
execute update_klient(/*TU WPISAC JEGO LOKALNE ID*/'Kacper','NULL','Wojno','99070206831','153245697', 'B');
-- usuniecie klienta
execute delete_klient(/*TU WPISAC JEGO LOKALNE ID*/);

-- POJAZD
--dodanie pojazdu
execute insert_new_pojazd('A1234567890PP36O1', 'DW9999', TO_DATE('2011-05-03', 'yyyy-mm-dd'), 325146, TO_DATE('2021-01-03', 'yyyy-mm-dd'), '0', 0, 'Mercedes W220', 2000, 13, 'B', 499);
--aktualizacja przebiegu
execute update_pojazd(/*TU WPISAC JEGO LOKALNE ID*/'A1234567890QW36O1', 'DW9999', TO_DATE('2011-05-03', 'yyyy-mm-dd'), 411111, TO_DATE('2021-01-03', 'yyyy-mm-dd'), '0');
--usuniecie pojazdu
execute delete_pojazd(/*TU WPISAC JEGO LOKALNE ID*/);

-- WYPO¯YCZENIE
--dodanie wypozyczenia
execute insert_new_wypozyczenie(0,'97070206811','DW1231',TO_DATE('2020-11-03', 'yyyy-mm-dd'),2000);
--aktualizacja planowanego terminu zwrotu i pobranej kaucji
execute update_wypozyczenie(/*TU WPISAC JEGO LOKALNE ID*/TO_DATE('2020-12-18', 'yyyy-mm-dd'), 2229);
--usuniecie wypozyczenia
execute delete_wypozyczenie(/*TU WPISAC JEGO LOKALNE ID*/);

-- ZWROT
--dodanie zwrotu
execute insert_new_zwrot(0,'TAK','TAK'/*TU WPISAC PESEL KLIENTA*//*TUTAJ WPISAC REJESTRACJE POJAZDU*/);
--aktualizacja czy zwrot kaucji
execute update_zwrot(/*TU WPISAC JEGO LOKALNE ID*/'TAK', 'NIE');
--usuniecie zwrotu
-- UWAGA ZEBY USUNAC ZWROT NAJPIERW TRZEBA USUNAC POWIAZANE Z NIM WYPOZYCZENIE PONIEWAZ JEST PODRZEDNE !!!!!!!!
execute delete_zwrot(/*TU WPISAC JEGO LOKALNE ID*/);