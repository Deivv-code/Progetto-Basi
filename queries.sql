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

# RISTORANTI ORDINATI PER ORDINI EFFETUATI -- sono 1 ordine per ristorante, quindi non dovrebbero 
SELECT Ristorante.nome_locale, Ristorante.numero_telefono, COUNT(Ordine.numero_univoco) as ordini_effetuati
FROM Ristorante
INNER JOIN Ordine ON Ordine.ristorante = Ristorante.numero_telefono
GROUP BY Ristorante.numero_telefono
ORDER BY ordini_effetuati DESC;

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

