USE bddCrie2;
SET FOREIGN_KEY_CHECKS = 0;
SET NAMES 'utf8';
INSERT INTO TypeUtilisateur(id, libelle) VALUES (6, 'Pêcheur');
CREATE TABLE Pecheur
(
    id      INTEGER   UNSIGNED  NOT NULL,
    idBateau     INTEGER  UNSIGNED      NOT NULL,
    CONSTRAINT PK_PECHEUR PRIMARY KEY (id),
  	CONSTRAINT FK_PECHEUR_UTILISATEUR FOREIGN KEY  (id) references Utilisateur (id),
  	CONSTRAINT FK_PECHEUR_BATEAU FOREIGN KEY  (idBateau) references Bateau (id),
  	CONSTRAINT INDEX_PECHEUR_BATEAU UNIQUE INDEX (idBateau)
    
) ENGINE = INNODB;
ALTER TABLE Bac CHANGE COLUMN idLot idLot DECIMAL(5,0) NOT NULL AFTER idBateau;
ALTER TABLE Lot CHANGE COLUMN idLot idLot DECIMAL(5,0) NOT NULL AFTER idBateau;
  CHANGE COLUMN idTaille idTaille DECIMAL(2,0) NULL AFTER idEspece,
	CHANGE COLUMN idQualite idQualite CHAR(1) NULL COLLATE latin1_general_ci AFTER idPresentation;
DROP PROCEDURE IF EXISTS UPDATE_USER;
DELIMITER -
CREATE PROCEDURE UPDATE_USER (idusr INT, loginusr VARCHAR(300), nomusr VARCHAR(300), prenomusr VARCHAR(300), labeltypeusr VARCHAR(300), adrMailusr VARCHAR(300), idBateauusr INT)
BEGIN
DECLARE typeusr INT;
SET typeusr = (SELECT id FROM TypeUtilisateur WHERE libelle=labeltypeusr);
IF(typeusr<4)THEN
DELETE FROM Directeurvente WHERE id=idusr;
DELETE FROM Pecheur WHERE id=idusr;
UPDATE Utilisateur SET login=loginusr, nomuser=nomusr, prenomuser=prenomusr, idtypeuser=typeusr, adrMail=adrMailusr, datemodif=NOW() WHERE id=idusr;
END IF;
IF(typeusr=4)THEN
DELETE FROM Pecheur WHERE id=idusr;
UPDATE Utilisateur SET login=loginusr, nomuser=nomusr, prenomuser=prenomusr, idtypeuser=typeusr, adrMail=adrMailusr, datemodif=NOW() WHERE id=idusr;
IF NOT EXISTS (SELECT id FROM Directeurvente WHERE id=idusr) THEN
INSERT INTO Directeurvente (id) VALUES (idusr);
END IF;
END IF;
IF(typeusr=6)THEN
DELETE FROM Directeurvente WHERE id=idusr;
UPDATE Utilisateur SET login=loginusr, nomuser=nomusr, prenomuser=prenomusr, idtypeuser=typeusr, adrMail=adrMailusr, datemodif=NOW() WHERE id=idusr;
IF NOT EXISTS (SELECT id FROM Pecheur WHERE id=idusr) THEN
INSERT INTO Pecheur (id, idBateau) VALUES (idusr, idBateauusr);
END IF;
IF EXISTS (SELECT id FROM Pecheur WHERE id=idusr) THEN
UPDATE Pecheur SET idBateau=idBateauusr;
END IF;
END IF;
END -
DELIMITER ;
DROP TRIGGER IF EXISTS IST_PECHEUR_ID;
DELIMITER //
CREATE TRIGGER IST_PECHEUR_ID BEFORE INSERT ON Pecheur
FOR EACH ROW
BEGIN
IF NOT EXISTS (SELECT id FROM Utilisateur WHERE idtypeuser=6 AND id=NEW.id) THEN
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'L''utilisateur entré n''est pas un pêcheur';
END IF;
END//
DELIMITER ;
DROP TRIGGER IF EXISTS UPD_PECHEUR_ID;
DELIMITER //
CREATE TRIGGER UPD_PECHEUR_ID BEFORE UPDATE ON Pecheur
FOR EACH ROW
BEGIN
IF NOT EXISTS (SELECT id FROM Utilisateur WHERE idtypeuser=6 AND id=NEW.id) THEN
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'L''utilisateur entré n''est pas un pêcheur';
END IF;
END//
DELIMITER ;
DROP TRIGGER IF EXISTS UPD_UTILISATEUR_IDTYPEUSER;
DELIMITER //
CREATE TRIGGER UPD_UTILISATEUR_IDTYPEUSER BEFORE UPDATE ON Utilisateur
FOR EACH ROW
BEGIN
IF NEW.idtypeuser<4 THEN
IF EXISTS (SELECT id FROM Directeurvente WHERE id=NEW.id) THEN
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Erreur de contrainte avec la table ''Directeurvente'' sur le champ ''id''';
END IF;
IF EXISTS (SELECT id FROM Acheteur WHERE id=NEW.id) THEN
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Erreur de contrainte avec la table ''Acheteur'' sur le champ ''id''';
END IF;
IF EXISTS (SELECT id FROM Pecheur WHERE id=NEW.id) THEN
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Erreur de contrainte avec la table ''Pecheur'' sur le champ ''id''';
END IF;
END IF;
IF NEW.idtypeuser=4 THEN
IF EXISTS (SELECT id FROM Acheteur WHERE id=NEW.id)THEN
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Erreur de contrainte avec la table ''Acheteur'' sur le champ ''id''';
END IF;
IF EXISTS (SELECT id FROM Pecheur WHERE id=NEW.id)THEN
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Erreur de contrainte avec la table ''Pecheur'' sur le champ ''id''';
END IF;
END IF;
IF NEW.idtypeuser=5 THEN
IF EXISTS (SELECT id FROM Directeurvente WHERE id=NEW.id)THEN
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Erreur de contrainte avec la table ''Directeurvente'' sur le champ ''id''';
END IF;
IF EXISTS (SELECT id FROM Pecheur WHERE id=NEW.id)THEN
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Erreur de contrainte avec la table ''Pecheur'' sur le champ ''id''';
END IF;
END IF;
IF NEW.idtypeuser=6 THEN
IF EXISTS (SELECT id FROM Directeurvente WHERE id=NEW.id)THEN
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Erreur de contrainte avec la table ''Directeurvente'' sur le champ ''id''';
END IF;
IF EXISTS (SELECT id FROM Acheteur WHERE id=NEW.id)THEN
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Erreur de contrainte avec la table ''Acheteur'' sur le champ ''id''';
END IF;
END IF;
END//
DELIMITER ;
DROP PROCEDURE Auth;
DELIMITER //
CREATE PROCEDURE Auth(
    IN val1 VARCHAR(100),
  IN val2 VARCHAR(250)
)
BEGIN
    SET SESSION sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));
    SELECT count(Utilisateur.id) as nbUser, Utilisateur.id as iduser, login, nomuser, prenomuser, idtypeuser, libelle, adrMail, dateinsert, datemodif
    FROM Utilisateur INNER JOIN TypeUtilisateur ON Utilisateur.idtypeuser = TypeUtilisateur.id
    WHERE login=val1 AND pwd=val2 AND idtypeuser<5;
END//
DELIMITER ;
SET FOREIGN_KEY_CHECKS = 1;