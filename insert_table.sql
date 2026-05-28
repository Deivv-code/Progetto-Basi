USE progettocorriera;

# popolamento Clienti
LOAD DATA LOCAL INFILE "C:/Users/dvdca/Desktop/progetto_basi_script/Popolamento/Clienti.csv"
INTO table Cliente
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
IGNORE 1 LINES;
UPDATE Cliente SET numero_telefono = TRIM(BOTH '\r' from Cliente.numero_telefono);

# popolamento Rider
LOAD DATA LOCAL INFILE "C:/Users/dvdca/Desktop/progetto_basi_script/Popolamento/Riders.csv"
INTO table Rider
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
IGNORE 1 LINES;
UPDATE Rider SET IBAN = TRIM(BOTH '\r' from IBAN);

# popolamento Ristoratore
LOAD DATA LOCAL INFILE "C:/Users/dvdca/Desktop/progetto_basi_script/Popolamento/Ristoratori.csv"
INTO table Ristoratore
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
IGNORE 1 LINES
(nome,numero_telefono,cognome);
UPDATE Ristoratore SET numero_telefono = TRIM(BOTH '\r' from numero_telefono);

# popolamento Ristorante
LOAD DATA LOCAL INFILE "C:/Users/dvdca/Desktop/progetto_basi_script/Popolamento/Ristoranti.csv"
INTO table Ristorante
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
IGNORE 1 LINES
(nome_locale,numero_telefono_gestore,via,provincia,citta,numero_telefono,CAP);
UPDATE Ristorante SET numero_telefono = TRIM(BOTH '\r' from numero_telefono);

# popolamento Ordini
LOAD DATA LOCAL INFILE "C:/Users/dvdca/Desktop/progetto_basi_script/Popolamento/Ordini.csv"
INTO table Ordine
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
IGNORE 1 LINES
(ristorante, via_ritiro, provincia_ritiro, citta_ritiro, 
cliente, rider_numero, IBAN_rider, CAP_ritiro);

# popolamento Piatti
LOAD DATA LOCAL INFILE "C:/Users/dvdca/Desktop/progetto_basi_script/Popolamento/Piatti.csv"
INTO table Piatto
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
IGNORE 1 LINES
(nome_piatto,percentuale_sconto,ristorante, prezzo);
UPDATE piatto SET 
nome_piatto = TRIM(BOTH '\r' from nome_piatto), 
ristorante = TRIM(BOTH '\r' from ristorante);

# popolamento Inclusione
LOAD DATA LOCAL INFILE "C:/Users/dvdca/Desktop/progetto_basi_script/Popolamento/Inclusione.csv"
INTO table Inclusione
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
IGNORE 1 LINES
(piatto_ristorante,piatto_nome,ordine);

# popolamento Allergeni
LOAD DATA LOCAL INFILE "C:/Users/dvdca/Desktop/progetto_basi_script/Popolamento/Allergeni.csv"
INTO table Allergeno
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
IGNORE 1 LINES;

# popolamento Contenuto
INSERT INTO Contenuto(allergeno,piatto,piatto_ristorante) 
values ("Glutine","Pasta alla Carbonara","+39 0556794356"),
("Glutine","Smash Burger","+39 0556794356"),
("Glutine","Pasta al Forno", "+39 0557869567"),
("Glutine","Pasticciotti","+39 0557869567"),
("Glutine","Parmigiana","+39 0557869567"),
("Uova e derivati","Pasta alla Carbonara","+39 0556794356"),
("Uova e derivati","Smash Burger","+39 0556794356"),
("Uova e derivati","Pasticciotti","+39 0557869567"),
("Lupino e derivati","Trippa vegana", "+39 3494380239"),
("Soia e derivati","Ravioli carne","+39 0556767675"),
("Soia e derivati","Ravioli vegetariani","+39 0556767675");



# popolamento Ricevuta
LOAD DATA LOCAL INFILE "C:/Users/dvdca/Desktop/progetto_basi_script/Popolamento/Ricevute.csv"
INTO table Ricevuta
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
IGNORE 1 LINES
(metodo_di_pagamento,data_pagamento,orario_pagamento,numero_univoco,totale_pagato);