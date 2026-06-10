USE ProgettoCorriera;

DROP VIEW IF EXISTS piattiPerOrdine;
CREATE VIEW piattiPerOrdine(numero_ordine, ciente, nome_piatto, prezzo) AS
SELECT Ordine.numero_univoco as numero_ordine, Cliente.numero_telefono as cliente, Piatto.nome_piatto as piatto, Piatto.prezzo as prezzo
FROM Ordine INNER JOIN Inclusione ON Ordine.numero_univoco = Inclusione.ordine
INNER JOIN Piatto ON Piatto.nome_piatto = Inclusione.piatto_nome AND Piatto.ristorante = Inclusione.piatto_ristorante
INNER JOIN Cliente ON Cliente.numero_telefono = Ordine.cliente
ORDER BY numero_ordine, cliente;

DROP VIEW IF EXISTS totaleSpesoClienti;
CREATE VIEW totaleSpesoClienti(numero_telefono, nome, cognome, totale) AS
SELECT Cliente.numero_telefono as numero_telefono, Cliente.nome as nome, Cliente.cognome as cognome, SUM(Piatto.prezzo)
FROM Cliente INNER JOIN Ordine ON Ordine.cliente = Cliente.numero_telefono
INNER JOIN Inclusione ON Ordine.numero_univoco = Inclusione.ordine
INNER JOIN Piatto ON Inclusione.piatto_nome = Piatto.nome_piatto AND Inclusione.piatto_ristorante = Piatto.ristorante
GROUP BY numero_telefono;

SELECT * FROM piattiPerOrdine;
SELECT * FROM totaleSpesoClienti;