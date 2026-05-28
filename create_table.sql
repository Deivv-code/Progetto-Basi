# Creazione database
DROP DATABASE IF EXISTS ProgettoCorriera;
CREATE DATABASE IF NOT EXISTS ProgettoCorriera;
USE ProgettoCorriera;

# Creazione tabelle
Drop table if exists Cliente;
Create table Cliente(
nome varchar(40) not null,
cognome varchar(40) not null,
numero_telefono varchar(20) PRIMARY KEY not null
);

Drop table if exists Rider;
Create table Rider(
nome varchar(40) not null,
cognome varchar(40) not null,
numero_telefono varchar(20) not null,
IBAN varchar(27) not null,
PRIMARY KEY(numero_telefono, IBAN)
);

Drop table if exists Ristoratore;
Create table Ristoratore(
nome varchar(40) not null,
cognome varchar(40) not null,
numero_telefono varchar(20) PRIMARY KEY not null
);

Drop table if exists Ristorante;
Create table Ristorante(
nome_locale varchar(70) not null,
CAP int not null,
via varchar(40) not null,
provincia varchar(3) not null,
citta varchar(20) not null,
numero_telefono varchar(20) PRIMARY KEY not null,
numero_telefono_gestore varchar(20) not null,
FOREIGN KEY (numero_telefono_gestore) REFERENCES Ristoratore(numero_telefono)
ON UPDATE CASCADE
);

Drop table if exists Ordine;
Create table Ordine(
numero_univoco int auto_increment PRIMARY KEY not null,
CAP_ritiro int not null,
via_ritiro varchar(40) not null,
provincia_ritiro varchar(3) not null,
citta_ritiro varchar(20) not null,
cliente varchar(20) not null,
rider_numero varchar(20),
IBAN_rider varchar(27),
ristorante varchar(40) not null,

FOREIGN KEY (cliente) REFERENCES Cliente(numero_telefono)
ON UPDATE CASCADE,
FOREIGN KEY (rider_numero, IBAN_rider) REFERENCES Rider(numero_telefono,IBAN)
ON UPDATE CASCADE,
FOREIGN KEY (ristorante) REFERENCES Ristorante(numero_telefono)
ON UPDATE CASCADE
);

Drop table if exists Piatto;
Create table Piatto(
nome_piatto varchar(40) not null,
percentuale_sconto int not null,
prezzo double not null,
ristorante varchar(20) not null,

PRIMARY KEY (nome_piatto, ristorante),
FOREIGN KEY (ristorante) REFERENCES Ristorante(numero_telefono)
ON UPDATE CASCADE
);

Drop table if exists Inclusione;
Create table Inclusione(
ordine int not null,
piatto_nome varchar(40) not null,
piatto_ristorante varchar(20) not null,

FOREIGN KEY (ordine) REFERENCES Ordine(numero_univoco),
FOREIGN KEY (piatto_nome, piatto_ristorante) REFERENCES Piatto(nome_piatto, ristorante)
ON UPDATE CASCADE
);

Drop table if exists Allergeno;
Create table Allergeno(
nome varchar(40) PRIMARY KEY not null,
descrizione varchar(100) not null
);

Drop table if exists Contenuto;
Create table Contenuto(
allergeno varchar(20) not null,
piatto varchar(40) not null,
piatto_ristorante varchar(40) not null,

FOREIGN KEY (allergeno) REFERENCES Allergeno(nome),
FOREIGN KEY (piatto, piatto_ristorante) REFERENCES Piatto(nome_piatto, ristorante)
);

Drop table if exists Ricevuta;
Create table Ricevuta(
numero_univoco int PRIMARY KEY not null,
totale_pagato double not null,
metodo_di_pagamento ENUM('Pagamento elettronico','Contanti') not null,
data_pagamento date not null,
orario_pagamento datetime not null,

FOREIGN KEY (numero_univoco) REFERENCES Ordine(numero_univoco)
ON UPDATE CASCADE
);