USE bddCrie2;
SET FOREIGN_KEY_CHECKS = 0;
ALTER TABLE `Lot` DROP FOREIGN KEY `FK_LOT_ACHETEUR`;
ALTER TABLE `Lot` DROP INDEX `FK_LOT_ACHETEUR`;
DROP TABLE Poster;
DROP TABLE Acheteur;
CREATE TABLE Acheteur
(
    id                    INTEGER   UNSIGNED    NOT NULL,
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
SET @maxid=(SELECT IFNULL(max(id),-1) FROM Utilisateur)+1;
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
    CONSTRAINT PK_DIRECTEURVENTE PRIMARY KEY (id),
  	CONSTRAINT FK_DIRECTEURVENTE_UTILISATEUR FOREIGN KEY  (id) references Utilisateur (id)
    
) ENGINE = INNODB;
INSERT INTO Directeurvente(id) SELECT id FROM Utilisateur WHERE idtypeuser=4;
CREATE TABLE Histoconnexion
(
    id  INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    dateConnexion  DATETIME    NOT NULL default NOW(),
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
    SELECT count(utilisateur.id) as nbUser, Utilisateur.id as iduser, login, nomuser, prenomuser, idtypeuser, libelle, adrMail
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
UPDATE acheteur SET statutCompte=1;
ALTER TABLE Peche ADD COLUMN heureArrivee TIME NULL;
SET FOREIGN_KEY_CHECKS = 1;
