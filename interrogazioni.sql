USE ProgettoCorriera;

# ORDINI NON CONSEGNATI -- non dovrebbe restituire niente
SELECT Ordine.numero_univoco
FROM Ordine
WHERE Ordine.IBAN_rider = NULL;

# CLIENTE CON ACQUISTI TOTALI PIU' ALTI 
SELECT Cliente.*
FROM Cliente 
INNER JOIN Ordine ON Ordine.cliente = Cliente