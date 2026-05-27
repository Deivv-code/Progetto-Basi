USE progettocorriera;

# popolamento Clienti
LOAD DATA LOCAL INFILE "C:/Users/dvdca/Desktop/progetto_basi_script/Clienti.csv"
INTO table Cliente
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
IGNORE 1 LINES;
UPDATE Cliente SET numero_telefono = TRIM(BOTH '\r' from Cliente.numero_telefono);

# popolamento Rider
LOAD DATA LOCAL INFILE "C:/Users/dvdca/Desktop/progetto_basi_script/Riders.csv"
INTO table Rider
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
IGNORE 1 LINES;
UPDATE Rider SET IBAN = TRIM(BOTH '\r' from IBAN);

# popolamento Ristoratore
LOAD DATA LOCAL INFILE "C:/Users/dvdca/Desktop/progetto_basi_script/Ristoratori.csv"
INTO table Ristoratore
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
IGNORE 1 LINES
(nome,numero_telefono,cognome);
UPDATE Ristoratore SET numero_telefono = TRIM(BOTH '\r' from numero_telefono);

# popolamento Ristorante
LOAD DATA LOCAL INFILE "C:/Users/dvdca/Desktop/progetto_basi_script/Ristoranti.csv"
INTO table Ristorante
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
IGNORE 1 LINES
(nome_locale,numero_telefono_gestore,via,provincia,citta,numero_telefono,CAP);
UPDATE Ristorante SET numero_telefono = TRIM(BOTH '\r' from numero_telefono);

# popolamento Ordini
LOAD DATA LOCAL INFILE "C:/Users/dvdca/Desktop/progetto_basi_script/Ordini.csv"
INTO table Ordine
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
IGNORE 1 LINES
(ristorante, via_ritiro, provincia_ritiro, citta_ritiro, 
cliente, rider_numero, IBAN_rider, CAP_ritiro);

# popolamento Allergeni
LOAD DATA LOCAL INFILE "C:/Users/dvdca/Desktop/progetto_basi_script/Allergeni.csv"
INTO table Allergeno
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
IGNORE 1 LINES;
