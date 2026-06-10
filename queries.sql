USE ProgettoCorriera;

# ORDINI NON CONSEGNATI -- non dovrebbe restituire niente
SELECT Ordine.numero_univoco
FROM Ordine
WHERE Ordine.IBAN_rider = NULL;

# CLIENTE CON ACQUISTI TOTALI PIU' ALTI 
SELECT Cliente.*, SUM(Piatto.prezzo) as totale
FROM Cliente 
INNER JOIN Ordine ON Ordine.cliente = Cliente.numero_telefono
INNER JOIN Inclusione ON Inclusione.ordine = Ordine.numero_univoco
INNER JOIN Piatto ON Piatto.nome_piatto = Inclusione.piatto_nome AND Piatto.ristorante = Inclusione.piatto_ristorante
GROUP BY Cliente.numero_telefono
ORDER BY totale DESC
LIMIT 1;

# RISTORANTI ORDINATI PER ORDINI EFFETUATI -- sono 1 ordine per ristorante 
SELECT Ristorante.numero_telefono, Ristorante.nome_locale, COUNT(T.piatto_ristorante)
FROM Ristorante
INNER JOIN (
	SELECT piatto_ristorante FROM Inclusione GROUP BY Inclusione.ordine, Inclusione.piatto_ristorante
) AS T ON T.piatto_ristorante = Ristorante.numero_telefono
GROUP BY Ristorante.numero_telefono;

# RISTORATORI CON RISTORANTE CHE NON HANNO PIATTI CON GLUTINE -- possibile anche senza sub-query
SELECT Ristoratore.numero_telefono, Ristoratore.nome, Ristoratore.cognome
FROM Ristoratore
WHERE Ristoratore.numero_telefono IN (
	SELECT Ristorante.numero_telefono_gestore
	FROM Ristorante
	INNER JOIN Piatto ON Piatto.ristorante = Ristorante.numero_telefono
	INNER JOIN Contenuto ON Contenuto.piatto = Piatto.nome_piatto AND Piatto.ristorante = Contenuto.piatto_ristorante
	WHERE NOT Contenuto.allergeno = "Glutine"
);

