--CREATING VIEWS TO DATABASE

--Creating partitioned view of all vehicles
CREATE OR REPLACE VIEW SHOW_ALL_VEHICLES AS
SELECT * FROM remoteVehicles
UNION ALL
SELECT * FROM pojazdy;

--Creating partitioned view of all available vehicles
CREATE OR REPLACE VIEW SHOW_ALL_AVAILABLE_VEHICLES AS
SELECT * FROM remoteVehicles WHERE remoteVehicles.AktualnaWypozyczalnia IS NOT NULL
UNION ALL
SELECT * FROM pojazdy WHERE pojazdy.AktualnaWypozyczalnia IS NOT NULL;

--Creating partitioned view of locally available vehicles
CREATE OR REPLACE VIEW SHOW_AVAILABLE_VEHICLES AS
SELECT * FROM remoteVehicles WHERE remoteVehicles.AktualnaWypozyczalnia = 1
UNION ALL
SELECT * FROM pojazdy WHERE pojazdy.AktualnaWypozyczalnia = 1;

--Creating partitioned view of all global rentals
CREATE OR REPLACE VIEW SHOW_ALL_RENTALS AS
SELECT * FROM remoteRentals
UNION ALL
SELECT * FROM wypozyczenia

COMMIT;