USE ProgettoCorriera;

DELIMITER $$

DROP TRIGGER IF EXISTS controllo_percentuale $$
CREATE TRIGGER controllo_percentuale 
BEFORE INSERT
ON Piatto
FOR EACH ROW
BEGIN
	IF NEW.percentuale_sconto > 100 THEN
		SET NEW.percentuale_sconto = 100;
	ELSEIF NEW.percentuale_sconto < 0 THEN
		SET NEW.percentuale_sconto = 0;
    END IF;
END; $$

DROP TRIGGER IF EXISTS controllo_aggiornamento_percentuale $$
CREATE TRIGGER controllo_aggiornamento_percentuale
BEFORE UPDATE
ON Piatto
FOR EACH ROW
BEGIN
	IF NEW.percentuale_sconto > 100 THEN
		SET NEW.percentuale_sconto = 100;
	ELSEIF NEW.percentuale_sconto < 0 THEN
		SET NEW.percentuale_sconto = 0;
    END IF;
END; $$


DROP TRIGGER IF EXISTS controllo_consegna $$
CREATE TRIGGER controllo_consegna
BEFORE INSERT
ON Ordine
FOR EACH ROW
BEGIN
	IF NEW.rider_numero = null THEN
		SET @cap_ristorante = (SELECT CAP FROM Ristorante WHERE numero_telefono = NEW.ristorante);
        SET @via_ristorante = (SELECT via FROM Ristorante WHERE numero_telefono = NEW.ristorante);
        SET @provincia_ristorante = (SELECT provincia FROM Ristorante WHERE numero_telefono = NEW.ristorante);
        SET @citta_ristorante = (SELECT citta FROM Ristorante WHERE numero_telefono = NEW.ristorante);
        IF NOT (NEW.CAP_ritiro = @cap_ristorante AND NEW.via_ritiro = @via_ristorante AND NEW.provincia_ritiro = @provincia_ristorante AND NEW.citta_ritiro = @citta_ristorante) THEN
			SIGNAL SQLSTATE "45000"
            SET MESSAGE_TEXT = "INDIRIZZO CONSEGNA A RITIRO NON UGUALE A RISTORANTE.";
        END IF;
	END IF;
END;