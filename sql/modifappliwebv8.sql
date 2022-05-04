USE bddCrie2;
SET FOREIGN_KEY_CHECKS = 0;
set names 'utf8';
ALTER TABLE Utilisateur MODIFY id INTEGER UNSIGNED NOT NULL AUTO_INCREMENT;
ALTER TABLE `Lot` DROP FOREIGN KEY `FK_LOT_ACHETEUR`;
ALTER TABLE `Lot` DROP INDEX `FK_LOT_ACHETEUR`;
DROP TABLE Poster;
DROP TABLE Acheteur;
CREATE TABLE Acheteur
(
    id                    INTEGER   UNSIGNED    NOT NULL AUTO_INCREMENT,
    raisonSocial     VARCHAR(100)        NULL,
    adrAcheteur  VARCHAR(100)        NULL,
    villeAcheteur  VARCHAR(100)        NULL,
    cpAcheteur  VARCHAR(100)        NULL,
    numHabilitation VARCHAR(100)    NULL,
    dateinsert DATETIME NOT NULL DEFAULT NOW(),
    datemodif DATETIME NOT NULL DEFAULT NOW(),
    clesession VARCHAR(256) NULL,
    CONSTRAINT PK_ACHETEUR PRIMARY KEY (id),
  	CONSTRAINT FK_ACHETEUR_UTILISATEUR FOREIGN KEY  (id) references Utilisateur (id)
    
) ENGINE = INNODB;
INSERT INTO TypeUtilisateur VALUES (5, 'Acheteur');
SET @maxid=(SELECT IFNULL(max(id),0) FROM Utilisateur)+1;
INSERT INTO Utilisateur (id,login,pwd,nomuser,prenomuser,idtypeuser) VALUES(@maxid,'Treant_Marcel',SHA2('TM',256),'Treant','Marcel',5);
INSERT INTO Acheteur (id,raisonSocial, cpAcheteur, villeAcheteur,numHabilitation) VALUES (@maxid,'Audierne Marée','29780','PLOUHINEC','CP40001000');
SET @maxid=@maxid+1;
INSERT INTO Utilisateur (id,login,pwd,nomuser,prenomuser,idtypeuser) VALUES(@maxid,'Peren_Stephanie',SHA2('PS',256),'Peren','Stephanie',5);
INSERT INTO Acheteur (id,raisonSocial, cpAcheteur, villeAcheteur,numHabilitation) VALUES (@maxid,'Rosatlantic','29780','PLOUHINEC','CP30002222');
SET @maxid=@maxid+1;
INSERT INTO Utilisateur (id,login,pwd,nomuser,prenomuser,idtypeuser) VALUES(@maxid,'Lapez_Johan',SHA2('LJ',256),'Lapez','Johan',5);
INSERT INTO Acheteur (id,raisonSocial, cpAcheteur, villeAcheteur,numHabilitation) VALUES (@maxid,'Viviers d Audierne','29770','AUDIERNE','CP10001111');
SET @maxid=@maxid+1;
INSERT INTO Utilisateur (id,login,pwd,nomuser,prenomuser,idtypeuser) VALUES(@maxid,'Lamou_Gerard',SHA2('LG',256),'Lamou','Gerard',5);
INSERT INTO Acheteur (id,raisonSocial, cpAcheteur, villeAcheteur,numHabilitation) VALUES (@maxid,'Conserverie d Audierne','29780','PLOUHINEC','CP45003232');
SET @maxid=@maxid+1;
INSERT INTO Utilisateur (id,login,pwd,nomuser,prenomuser,idtypeuser) VALUES(@maxid,'Daniel_Jean',SHA2('DJ',256),'Daniel','Jean',5);
INSERT INTO Acheteur (id,raisonSocial, cpAcheteur, villeAcheteur,numHabilitation) VALUES (@maxid,'La Criee Le Guilvinec','29730','LE GUILVINEC','CP45006786');
SET @maxid=@maxid+1;
INSERT INTO Utilisateur (id,login,pwd,nomuser,prenomuser,idtypeuser) VALUES(@maxid,'Louarn_Annie',SHA2('LA',256),'Louarn','Annie',5);
INSERT INTO Acheteur (id,raisonSocial, cpAcheteur, villeAcheteur,numHabilitation) VALUES (@maxid,'Fumoir de la Pointe du Raz','29770','PLOGOFF','CP44004343');
SET @maxid=@maxid+1;
INSERT INTO Utilisateur (id,login,pwd,nomuser,prenomuser,idtypeuser) VALUES(@maxid,'Claquin_Jean',SHA2('CJ',256),'Claquin','Jean',5);
INSERT INTO Acheteur (id,raisonSocial, cpAcheteur, villeAcheteur,numHabilitation) VALUES (@maxid,'FURIC MAREE SA','29760','LE GUILVINEC','CP44003236');
SET @maxid=@maxid+1;
INSERT INTO Utilisateur (id,login,pwd,nomuser,prenomuser,idtypeuser) VALUES(@maxid,'Doare_Clet',SHA2('DC',256),'Doare','Clet',5);
INSERT INTO Acheteur (id,raisonSocial, cpAcheteur, villeAcheteur,numHabilitation) VALUES (@maxid,'Halios Marée SA','29760','SAINT GUENOLE','CP45003333');
SET @maxid=@maxid+1;
INSERT INTO Utilisateur (id,login,pwd,nomuser,prenomuser,idtypeuser) VALUES(@maxid,'Lozach_Hery',SHA2('LH',256),'Lozach','Hery',5);
INSERT INTO Acheteur (id,raisonSocial, cpAcheteur, villeAcheteur,numHabilitation) VALUES (@maxid,'Poissonnerie LEROY','29770','ESQUIBIEN','CP45005656');
SET @maxid=@maxid+1;
INSERT INTO Utilisateur (id,login,pwd,nomuser,prenomuser,idtypeuser) VALUES(@maxid,'Quenet_Claude',SHA2('QC',256),'Quenet','Claude',5);
INSERT INTO Acheteur (id,raisonSocial, cpAcheteur, villeAcheteur,numHabilitation) VALUES (@maxid,'Poissonnerie QUENET','29172','DOUARNENEZ','CP46007777');
SET @maxid=@maxid+1;
INSERT INTO Utilisateur (id,login,pwd,nomuser,prenomuser,idtypeuser) VALUES(@maxid,'Moan_Mickael',SHA2('MM',256),'Moan','Mickael',5);
INSERT INTO Acheteur (id,raisonSocial, cpAcheteur, villeAcheteur,numHabilitation) VALUES (@maxid,'Aigue Marine','29750','LOCTUDY','CP45008787');
SET @maxid=@maxid+1;
INSERT INTO Utilisateur (id,login,pwd,nomuser,prenomuser,idtypeuser) VALUES(@maxid,'Gornes_Bernard',SHA2('BG',256),'Gornes','Bernard',5);
INSERT INTO Acheteur (id,raisonSocial, cpAcheteur, villeAcheteur,numHabilitation) VALUES (@maxid,'Poissonnerie des Halles','29770','AUDIERNE','CP45006666');
ALTER TABLE Lot add CONSTRAINT FK_LOT_ACHETEUR FOREIGN KEY  (idAcheteur) references Acheteur (id) ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE Lot add CONSTRAINT FK_LOT_FACTURE FOREIGN KEY  (idFacture) references Facture (id) ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE Facture DROP COLUMN etatPaiement;
ALTER TABLE Facture ADD COLUMN montant float;
ALTER TABLE Facture ADD COLUMN etatPaiement smallint(6) DEFAULT NULL;
ALTER TABLE Lot ADD COLUMN dateinsert DATETIME NOT NULL DEFAULT NOW();
ALTER TABLE Lot ADD COLUMN datemodif DATETIME NOT NULL DEFAULT NOW();
ALTER TABLE Lot ADD COLUMN iduserinsert INTEGER UNSIGNED NOT NULL DEFAULT 0;
ALTER TABLE Lot ADD COLUMN idusermodif INTEGER UNSIGNED NOT NULL DEFAULT 0;
ALTER TABLE Lot ALTER COLUMN iduserinsert DROP DEFAULT;
ALTER TABLE Lot ALTER COLUMN idusermodif DROP DEFAULT;
ALTER TABLE Lot add CONSTRAINT FK_LOT_UTILISATEUR_INSERT FOREIGN KEY  (iduserinsert) references Utilisateur (id) ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE Lot add CONSTRAINT FK_LOT_UTILISATEUR_MODIF FOREIGN KEY  (idusermodif) references Utilisateur (id) ON DELETE RESTRICT ON UPDATE RESTRICT;
CREATE TABLE Directeurvente
(
    id                    INTEGER   UNSIGNED    NOT NULL,
    clesession VARCHAR(256) NULL,
    CONSTRAINT PK_Directeurvente PRIMARY KEY (id),
  	CONSTRAINT FK_Directeurvente_UTILISATEUR FOREIGN KEY  (id) references Utilisateur (id)
    
) ENGINE = INNODB;
INSERT INTO Directeurvente(id) SELECT id FROM Utilisateur WHERE idtypeuser=4;
CREATE TABLE Histoconnexion
(
    id  INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    dateConnexion  DATETIME(3)    NOT NULL default NOW(),
    AdresseIP VARCHAR(50) NOT NULL,
    result BOOLEAN NOT NULL,
    idUtilisateur INTEGER UNSIGNED NULL,
    CONSTRAINT PK_HISTOCONNEXION PRIMARY KEY (id),
  	CONSTRAINT FK_HISTOCONNEXION_UTILISATEUR FOREIGN KEY  (idUtilisateur) references Utilisateur (id),
    CONSTRAINT INDEX_HISTOCONNEXION UNIQUE INDEX (dateConnexion, AdresseIP)
    
) ENGINE = INNODB;
UPDATE Espece SET nom='Araignée de mer casier' WHERE id=42040;
UPDATE Espece SET nom='Araignée de mer chalut' WHERE id=42041;
UPDATE Espece SET nom='Mérou ou cernier' WHERE id=33110;
UPDATE Espece SET nom='Mérou noir' WHERE id=33120;
DROP PROCEDURE Auth;
DELIMITER $
CREATE PROCEDURE Auth(
    IN val1 VARCHAR(100),
  IN val2 VARCHAR(100)
)
BEGIN
    SET GLOBAL sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));
    SET SESSION sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));
    SELECT count(Utilisateur.id) as nbUser, Utilisateur.id as iduser, login, nomuser, prenomuser, idtypeuser, libelle, adrMail
    FROM Utilisateur INNER JOIN TypeUtilisateur ON Utilisateur.idtypeuser = TypeUtilisateur.id
    WHERE login=val1 AND pwd=val2 AND idtypeuser<5;
END$
DELIMITER ;
ALTER TABLE Peche ADD Constraint INDEX_PECHE unique index (datePeche,idBateau);
ALTER TABLE Peche DROP PRIMARY KEY, ADD COLUMN id INTEGER NOT NULL AUTO_INCREMENT FIRST, ADD CONSTRAINT PK_PECHE PRIMARY KEY(id);
ALTER TABLE Bac CHANGE id numBac NUMERIC(3) UNSIGNED;
ALTER TABLE Bac DROP FOREIGN KEY FK_BAC_LOT;
ALTER TABLE Bac DROP INDEX FK_BAC_LOT;
ALTER TABLE Bac ADD Constraint INDEX_BAC unique index (numBac,idDatePeche,idBateau, idLot);
ALTER TABLE Bac DROP PRIMARY KEY, ADD COLUMN id INTEGER NOT NULL AUTO_INCREMENT FIRST, ADD CONSTRAINT PK_BAC PRIMARY KEY(id);
ALTER TABLE Lot CHANGE id idLot decimal(3,0) UNSIGNED;
ALTER TABLE Lot ADD Constraint INDEX_LOT unique index (idDatePeche,idBateau, idLot);
ALTER TABLE Lot DROP PRIMARY KEY, ADD COLUMN id INTEGER NOT NULL AUTO_INCREMENT FIRST, ADD CONSTRAINT PK_LOT PRIMARY KEY(id);
ALTER TABLE Bac ADD CONSTRAINT FK_BAC_LOT FOREIGN KEY  (idDatePeche,idBateau,idLot) references Lot (idDatePeche,idBateau,idLot) ON DELETE RESTRICT ON UPDATE RESTRICT;
CREATE TABLE Poster
(
    id INTEGER    UNSIGNED AUTO_INCREMENT NOT NULL,
    idDatePeche           DATE                  NOT NULL,
    idBateau              INTEGER   UNSIGNED    NOT NULL,
    idLot                 NUMERIC(3) UNSIGNED   NOT NULL,
    idAcheteur            INTEGER   UNSIGNED    NOT NULL,
    prixEnchere       	  DECIMAL(6,2)                  ,
	  HeureEnchere    	  DateTime	                       ,
    CONSTRAINT PK_POSTER PRIMARY KEY (id), 
    CONSTRAINT FK_POSTER_LOT FOREIGN KEY  (idDatePeche,idBateau,idLot) references Lot (idDatePeche,idBateau,idLot),
    CONSTRAINT FK_POSTER_ACHETEUR FOREIGN KEY  (idAcheteur) references Acheteur (id)
)
ENGINE = INNODB;
ALTER TABLE Poster ADD Constraint INDEX_POSTER unique index (idDatePeche,idBateau, idLot, idAcheteur);
INSERT INTO `Poster`(idDatePeche,idBateau,idLot,idAcheteur,prixEnchere,HeureEnchere) VALUES ('2020-07-18', 11, 1, 6, 7.45, '2020-07-18 10:17:08');
INSERT INTO `Poster`(idDatePeche,idBateau,idLot,idAcheteur,prixEnchere,HeureEnchere) VALUES ('2020-07-18', 11, 1, 8, 6.55, '2020-07-18 10:15:18');
INSERT INTO `Poster`(idDatePeche,idBateau,idLot,idAcheteur,prixEnchere,HeureEnchere) VALUES ('2020-07-18', 11, 1, 9, 7.50, '2020-07-18 10:17:48');
INSERT INTO `Poster`(idDatePeche,idBateau,idLot,idAcheteur,prixEnchere,HeureEnchere) VALUES ('2020-07-18', 11, 2, 6, 7.55, '2020-07-18 10:18:37');
INSERT INTO `Poster`(idDatePeche,idBateau,idLot,idAcheteur,prixEnchere,HeureEnchere) VALUES ('2020-07-18', 11, 2, 7, 8.50, '2020-07-18 10:20:59');
INSERT INTO `Poster`(idDatePeche,idBateau,idLot,idAcheteur,prixEnchere,HeureEnchere) VALUES ('2020-07-18', 11, 2, 8, 8.35, '2020-07-18 10:20:48');
INSERT INTO `Poster`(idDatePeche,idBateau,idLot,idAcheteur,prixEnchere,HeureEnchere) VALUES ('2020-07-18', 11, 2, 9, 7.50, '2020-07-18 10:18:23');
INSERT INTO `Poster`(idDatePeche,idBateau,idLot,idAcheteur,prixEnchere,HeureEnchere) VALUES ('2020-07-18', 11, 3, 7, 7.70, '2020-07-18 10:21:48');
INSERT INTO `Poster`(idDatePeche,idBateau,idLot,idAcheteur,prixEnchere,HeureEnchere) VALUES ('2020-07-18', 11, 3, 9, 8.50, '2020-07-18 10:22:13');
INSERT INTO `Poster`(idDatePeche,idBateau,idLot,idAcheteur,prixEnchere,HeureEnchere) VALUES ('2020-07-18', 11, 4, 6, 9.50, '2020-07-18 10:22:13');
INSERT INTO `Poster`(idDatePeche,idBateau,idLot,idAcheteur,prixEnchere,HeureEnchere) VALUES ('2020-07-18', 11, 4, 7, 10.00, '2020-07-18 10:22:13');
INSERT INTO `Poster`(idDatePeche,idBateau,idLot,idAcheteur,prixEnchere,HeureEnchere) VALUES ('2020-07-18', 11, 5, 9, 8.50, '2020-07-18 10:22:13');
INSERT INTO `Poster`(idDatePeche,idBateau,idLot,idAcheteur,prixEnchere,HeureEnchere) VALUES ('2020-07-18', 11, 5, 7, 8.75, '2020-07-18 10:22:13');
INSERT INTO `Poster`(idDatePeche,idBateau,idLot,idAcheteur,prixEnchere,HeureEnchere) VALUES ('2020-07-20', 11, 1, 6, 7.45, '2020-07-20 10:17:08');
INSERT INTO `Poster`(idDatePeche,idBateau,idLot,idAcheteur,prixEnchere,HeureEnchere) VALUES ('2020-07-20', 11, 1, 7, 7.80, '2020-07-20 10:17:48');
INSERT INTO `Poster`(idDatePeche,idBateau,idLot,idAcheteur,prixEnchere,HeureEnchere) VALUES ('2020-07-20', 11, 1, 8, 6.55, '2020-07-20 10:15:18');
INSERT INTO `Poster`(idDatePeche,idBateau,idLot,idAcheteur,prixEnchere,HeureEnchere) VALUES ('2020-07-20', 11, 2, 6, 8.35, '2020-07-20 10:20:48');
INSERT INTO `Poster`(idDatePeche,idBateau,idLot,idAcheteur,prixEnchere,HeureEnchere) VALUES ('2020-07-20', 11, 2, 7, 8.50, '2020-07-20 10:20:59');
INSERT INTO `Poster`(idDatePeche,idBateau,idLot,idAcheteur,prixEnchere,HeureEnchere) VALUES ('2020-07-20', 11, 2, 8, 8.55, '2020-07-20 10:21:18');
INSERT INTO `Poster`(idDatePeche,idBateau,idLot,idAcheteur,prixEnchere,HeureEnchere) VALUES ('2020-07-20', 11, 2, 9, 7.50, '2020-07-20 10:18:23');
INSERT INTO `Poster`(idDatePeche,idBateau,idLot,idAcheteur,prixEnchere,HeureEnchere) VALUES ('2020-07-21', 11, 1, 6, 8.50, '2020-07-21 10:22:13');
INSERT INTO `Poster`(idDatePeche,idBateau,idLot,idAcheteur,prixEnchere,HeureEnchere) VALUES ('2020-07-21', 11, 1, 7, 7.70, '2020-07-21 10:21:48');
INSERT INTO `Poster`(idDatePeche,idBateau,idLot,idAcheteur,prixEnchere,HeureEnchere) VALUES ('2020-07-21', 11, 2, 7, 7.70, '2020-07-21 10:21:48');
INSERT INTO `Poster`(idDatePeche,idBateau,idLot,idAcheteur,prixEnchere,HeureEnchere) VALUES ('2020-07-21', 11, 2, 8, 8.95, '2020-07-21 10:22:13');
INSERT INTO `Poster`(idDatePeche,idBateau,idLot,idAcheteur,prixEnchere,HeureEnchere) VALUES ('2020-07-30',  7, 1, 9, 17.50, '2020-07-30 11:02:53');
INSERT INTO `Poster`(idDatePeche,idBateau,idLot,idAcheteur,prixEnchere,HeureEnchere) VALUES ('2020-07-30',  7, 2, 8, 16.50, '2020-07-30 11:06:53');
INSERT INTO `Poster`(idDatePeche,idBateau,idLot,idAcheteur,prixEnchere,HeureEnchere) VALUES ('2020-07-30', 11, 1, 7, 8.70, '2020-07-30 11:09:53');
INSERT INTO `Poster`(idDatePeche,idBateau,idLot,idAcheteur,prixEnchere,HeureEnchere) VALUES ('2020-07-30',  1, 1, 7, 7.20, '2020-07-30 11:12:53');
INSERT INTO `Poster`(idDatePeche,idBateau,idLot,idAcheteur,prixEnchere,HeureEnchere) VALUES ('2020-07-30',  1, 2, 7, 9.75, '2020-07-30 11:16:53');
INSERT INTO `Poster`(idDatePeche,idBateau,idLot,idAcheteur,prixEnchere,HeureEnchere) VALUES ('2020-07-30',  1, 3, 6, 14.20, '2020-07-30 11:20:53');
INSERT INTO `Poster`(idDatePeche,idBateau,idLot,idAcheteur,prixEnchere,HeureEnchere) VALUES ('2020-07-30',  3, 1, 6, 14.60, '2020-07-30 11:26:53');
INSERT INTO `Poster`(idDatePeche,idBateau,idLot,idAcheteur,prixEnchere,HeureEnchere) VALUES ('2020-07-30',  3, 2, 6, 15.50, '2020-07-30 11:30:53');
INSERT INTO `Poster`(idDatePeche,idBateau,idLot,idAcheteur,prixEnchere,HeureEnchere) VALUES ('2020-07-30',  7, 1, 6, 15.50, '2020-07-30 11:30:58');
INSERT INTO `Poster`(idDatePeche,idBateau,idLot,idAcheteur,prixEnchere,HeureEnchere) VALUES ('2020-07-30',  1, 8, 6, 12.50, '2020-07-30 11:30:54');
INSERT INTO `Poster`(idDatePeche,idBateau,idLot,idAcheteur,prixEnchere,HeureEnchere) VALUES ('2020-07-30',  3, 5, 6, 14.10, '2020-07-30 11:30:53');
INSERT INTO `Poster`(idDatePeche,idBateau,idLot,idAcheteur,prixEnchere,HeureEnchere) VALUES ('2020-08-25',  3, 1, 9, 4.00, '2020-08-25 15:12:26');
INSERT INTO `Poster`(idDatePeche,idBateau,idLot,idAcheteur,prixEnchere,HeureEnchere) VALUES ('2020-08-25',  3, 2, 8, 6.00, '2020-08-25 15:17:12');
INSERT INTO `Poster`(idDatePeche,idBateau,idLot,idAcheteur,prixEnchere,HeureEnchere) VALUES ('2020-08-25',  3, 2, 9, 7.00, '2020-08-25 15:18:53');
INSERT INTO `Poster`(idDatePeche,idBateau,idLot,idAcheteur,prixEnchere,HeureEnchere) VALUES ('2020-08-25',  3, 3, 8, 7.00, '2020-08-25 15:21:44');
INSERT INTO `Poster`(idDatePeche,idBateau,idLot,idAcheteur,prixEnchere,HeureEnchere) VALUES ('2020-08-25',  3, 3, 9, 8.00, '2020-08-25 15:22:13');
INSERT INTO `Poster`(idDatePeche,idBateau,idLot,idAcheteur,prixEnchere,HeureEnchere) VALUES ('2020-08-25', 11, 1, 9, 23.00, '2020-08-25 16:41:34');
ALTER TABLE Facture ADD COLUMN dateinsert DATETIME NOT NULL DEFAULT NOW();
ALTER TABLE Facture ADD COLUMN datemodif DATETIME NOT NULL DEFAULT NOW();
ALTER TABLE Acheteur DROP COLUMN clesession;
ALTER TABLE Acheteur ADD COLUMN statutCompte INT(1) DEFAULT 0 NOT NULL;
ALTER TABLE Acheteur ADD COLUMN clesession VARCHAR(256) NULL;
UPDATE Acheteur SET statutCompte=1;
ALTER TABLE Peche ADD COLUMN heureArrivee TIME NULL;
UPDATE Lot SET codeEtat = 'C' WHERE codeEtat IS NULL;
ALTER TABLE Lot MODIFY codeEtat char(1) DEFAULT 'C' NOT NULL;
ALTER TABLE Bac MODIFY poidsbrutBac DECIMAL(6,2) DEFAULT '0.00' NULL;
CREATE TABLE Etat
(
    id INTEGER    UNSIGNED AUTO_INCREMENT NOT NULL,
    codeEtat           char(1)                  NOT NULL,
    descriptionEtat              VARCHAR(500)   NULL,
    CONSTRAINT PK_ETAT PRIMARY KEY (id),
    CONSTRAINT INDEX_ETAT UNIQUE INDEX (codeEtat)
)
ENGINE = INNODB;
UPDATE Lot SET codeEtat='T' WHERE codeEtat='L';
INSERT INTO Etat(codeEtat, descriptionEtat) VALUES ('C', 'Lot crée'), ('M', 'Lot marqué et pesé'), ('E', 'Lot prêt à la vente'), ('A', 'Lot clôturé : pour équarrisage, non vendu'), ('D', 'Lot clôturé : à donner pour une association'), ('T' , 'Lot clôturé : acheté par un acheteur'), ('F' , 'Lot à clôturer : sans acheteur');
ALTER TABLE Lot ADD CONSTRAINT FK_LOT_ETAT FOREIGN KEY  (codeEtat) references Etat (codeEtat) ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE Utilisateur ADD Constraint INDEX_UTILISATEUR_LOGIN unique index (login);
UPDATE TypeUtilisateur SET libelle='Réceptionniste' WHERE id=3;
UPDATE TypeUtilisateur SET libelle='Vétérinaire' WHERE id=2;
UPDATE Qualite SET libelle='glacé' WHERE id='A';
UPDATE Qualite SET libelle='déclassé' WHERE id='B';
UPDATE Presentation SET libelle='Etété' WHERE id='ET';
UPDATE Presentation SET libelle='Vidé' WHERE id='VID';
SET FOREIGN_KEY_CHECKS = 1;
UPDATE Etat SET descriptionEtat='Lot marqué et pesé, prix à saisir' WHERE codeEtat='M'; 
INSERT INTO Etat(codeEtat, descriptionEtat) VALUES ('V', 'Lot en cours de vente');
ALTER TABLE Histoconnexion MODIFY dateConnexion DATETIME(3) NOT NULL;
ALTER TABLE Utilisateur ADD Constraint INDEX_UTILISATEUR_ADRMAIL unique index (adrMail);
DROP TRIGGER IF EXISTS UPD_DIRECTEURVENTE_ID;
DELIMITER //
CREATE TRIGGER UPD_DIRECTEURVENTE_ID BEFORE UPDATE ON Directeurvente
FOR EACH ROW
BEGIN
IF NOT EXISTS (SELECT id FROM Utilisateur WHERE idtypeuser=4 AND id=NEW.id) THEN
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'L''utilisateur entré n''est pas un directeur des ventes';
END IF;
END//
DELIMITER ;
DROP TRIGGER IF EXISTS UPD_ACHETEUR_ID;
DELIMITER //
CREATE TRIGGER UPD_ACHETEUR_ID BEFORE UPDATE ON Acheteur
FOR EACH ROW
BEGIN
IF NOT EXISTS (SELECT id FROM Utilisateur WHERE idtypeuser=5 AND id=NEW.id) THEN
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'L''utilisateur entré n''est pas un acheteur';
END IF;
END//
DELIMITER ;
DROP TRIGGER IF EXISTS IST_DIRECTEURVENTE_ID;
DELIMITER //
CREATE TRIGGER IST_DIRECTEURVENTE_ID BEFORE INSERT ON Directeurvente
FOR EACH ROW
BEGIN
IF NOT EXISTS (SELECT id FROM Utilisateur WHERE idtypeuser=4 AND id=NEW.id) THEN
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'L''utilisateur entré n''est pas un directeur des ventes';
END IF;
END//
DELIMITER ;
DROP TRIGGER IF EXISTS IST_ACHETEUR_ID;
DELIMITER //
CREATE TRIGGER IST_ACHETEUR_ID BEFORE INSERT ON Acheteur
FOR EACH ROW
BEGIN
IF NOT EXISTS (SELECT id FROM Utilisateur WHERE idtypeuser=5 AND id=NEW.id) THEN
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'L''utilisateur entré n''est pas un acheteur';
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
END IF;
IF NEW.idtypeuser=4 THEN
IF EXISTS (SELECT id FROM Acheteur WHERE id=NEW.id)THEN
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Erreur de contrainte avec la table ''Acheteur'' sur le champ ''id''';
END IF;
END IF;
IF NEW.idtypeuser=5 THEN
IF EXISTS (SELECT id FROM Directeurvente WHERE id=NEW.id)THEN
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Erreur de contrainte avec la table ''Directeurvente'' sur le champ ''id''';
END IF;
END IF;
END//
DELIMITER ;
DROP TRIGGER IF EXISTS DEL_HISTOCONNEXION;
DELIMITER //
CREATE TRIGGER DEL_HISTOCONNEXION BEFORE DELETE ON Histoconnexion
FOR EACH ROW
BEGIN
IF(abs(datediff(CURDATE(),OLD.dateConnexion))<30)THEN
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Impossible de supprimer un enregistrement de la table ''Histoconnexion'' inférieur à 30 jours';
END IF;
END//
DELIMITER ;
DROP PROCEDURE IF EXISTS UPDATE_USER;
DELIMITER -
CREATE PROCEDURE UPDATE_USER (idusr INT, loginusr VARCHAR(300), nomusr VARCHAR(300), prenomusr VARCHAR(300), labeltypeusr VARCHAR(300), adrMailusr VARCHAR(300))
BEGIN
DECLARE typeusr INT;
SET typeusr = (SELECT id FROM TypeUtilisateur WHERE libelle=labeltypeusr);
IF(typeusr<4)THEN
DELETE FROM Directeurvente WHERE id=idusr;
UPDATE Utilisateur SET login=loginusr, nomuser=nomusr, prenomuser=prenomusr, idtypeuser=typeusr, adrMail=adrMailusr WHERE id=idusr;
END IF;
IF(typeusr=4)THEN
UPDATE Utilisateur SET login=loginusr, nomuser=nomusr, prenomuser=prenomusr, idtypeuser=typeusr, adrMail=adrMailusr WHERE id=idusr;
IF NOT EXISTS (SELECT id FROM Directeurvente WHERE id=idusr) THEN
INSERT INTO Directeurvente (id) VALUES (idusr);
END IF;
END IF;
END -
DELIMITER ;
ALTER TABLE Histoconnexion DROP FOREIGN KEY FK_HISTOCONNEXION_UTILISATEUR;
ALTER TABLE Histoconnexion ADD CONSTRAINT FK_HISTOCONNEXION_UTILISATEUR FOREIGN KEY (idUtilisateur) REFERENCES bddCrie2.Utilisateur (id) ON UPDATE RESTRICT ON DELETE SET NULL;
set names 'utf8';
SET block_encryption_mode = 'aes-256-ecb';
SET @cle='vVucT9MHuTM8CxYp/owSndrLUwfbNaMiWY59hGY+tg8=';
ALTER TABLE Utilisateur CHANGE COLUMN `prenomuser` `prenomuser` VARBINARY(300) NULL DEFAULT NULL COLLATE 'binary' AFTER `nomuser`;
ALTER TABLE Utilisateur CHANGE COLUMN `adrMail` `adrMail` VARBINARY(300) NULL DEFAULT NULL COLLATE 'binary' AFTER `idtypeuser`;
ALTER TABLE Utilisateur CHANGE COLUMN `nomuser` `nomuser` VARBINARY(300) NULL DEFAULT NULL COLLATE 'binary' AFTER `pwd`;
ALTER TABLE Acheteur CHANGE COLUMN `raisonSocial` `raisonSocial` VARBINARY(512) NULL DEFAULT NULL COLLATE 'binary' AFTER `id`;
ALTER TABLE Acheteur CHANGE COLUMN `adrAcheteur` `adrAcheteur` VARBINARY(512) NULL DEFAULT NULL COLLATE 'binary' AFTER `raisonSocial`;
ALTER TABLE Acheteur CHANGE COLUMN `villeAcheteur` `villeAcheteur` VARBINARY(256) NULL DEFAULT NULL COLLATE 'binary' AFTER `adrAcheteur`;
ALTER TABLE Acheteur CHANGE COLUMN `cpAcheteur` `cpAcheteur` VARBINARY(128) NULL DEFAULT NULL COLLATE 'binary' AFTER `villeAcheteur`;
ALTER TABLE Acheteur CHANGE COLUMN `numHabilitation` `numHabilitation` VARBINARY(128) NULL DEFAULT NULL COLLATE 'binary' AFTER `cpAcheteur`;
ALTER TABLE Histoconnexion CHANGE COLUMN `AdresseIP` `AdresseIP` VARBINARY(128) NULL DEFAULT NULL COLLATE 'binary' AFTER `dateConnexion`;
ALTER TABLE Utilisateur CHANGE COLUMN `login` `login` VARBINARY(256) NULL DEFAULT NULL COLLATE 'binary' AFTER `id`;
ALTER TABLE Utilisateur CHANGE COLUMN `pwd` `pwd` VARBINARY(512) NULL DEFAULT NULL COLLATE 'binary' AFTER `login`;
UPDATE utilisateur SET prenomuser=To_BASE64(AES_ENCRYPT(prenomuser,FROM_BASE64(@cle)));
UPDATE utilisateur SET nomuser=To_BASE64(AES_ENCRYPT(nomuser,FROM_BASE64(@cle)));
UPDATE utilisateur SET adrMail=To_BASE64(AES_ENCRYPT(adrMail,FROM_BASE64(@cle)));
UPDATE Acheteur SET raisonSocial=To_BASE64(AES_ENCRYPT(raisonSocial,FROM_BASE64(@cle)));
UPDATE Acheteur SET adrAcheteur=To_BASE64(AES_ENCRYPT(adrAcheteur,FROM_BASE64(@cle)));
UPDATE Acheteur SET cpAcheteur=To_BASE64(AES_ENCRYPT(cpAcheteur,FROM_BASE64(@cle)));
UPDATE Acheteur SET villeAcheteur=To_BASE64(AES_ENCRYPT(villeAcheteur,FROM_BASE64(@cle)));
UPDATE Acheteur SET numHabilitation=To_BASE64(AES_ENCRYPT(numHabilitation,FROM_BASE64(@cle)));
UPDATE Histoconnexion SET AdresseIP =To_BASE64(AES_ENCRYPT(AdresseIP,FROM_BASE64(@cle)));
UPDATE Utilisateur SET login=To_BASE64(AES_ENCRYPT(login,FROM_BASE64(@cle)));
UPDATE Utilisateur SET pwd =To_BASE64(AES_ENCRYPT(pwd,FROM_BASE64(@cle)));
UPDATE Utilisateur SET pwd = REPLACE(REPLACE(pwd, '\r', ''), '\n', '');
UPDATE Utilisateur SET pwd = REPLACE(TRIM(TRAILING ' ' FROM pwd), TRIM(TRAILING '\r' FROM pwd), TRIM(TRAILING '\n' FROM pwd));
SET GLOBAL sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));
SET SESSION sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));
DROP TRIGGER IF EXISTS UPD_HISTOCONNEXION;
DELIMITER //
CREATE TRIGGER UPD_HISTOCONNEXION BEFORE UPDATE ON Histoconnexion
FOR EACH ROW
BEGIN
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Impossible de modifier la table ''Histoconnexion''';
END//
DELIMITER ;