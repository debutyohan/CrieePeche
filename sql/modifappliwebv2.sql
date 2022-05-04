Use bddCrie2;
SET FOREIGN_KEY_CHECKS = 0;
ALTER TABLE `lot` DROP FOREIGN KEY `FK_LOT_ACHETEUR`;
ALTER TABLE `lot` DROP INDEX `FK_LOT_ACHETEUR`;
drop table poster;
drop table acheteur;
create table acheteur
(
    idUser                    INTEGER   UNSIGNED    not null,
    raisonSocial     VARCHAR(100)        NULL,
    adrAcheteur  VARCHAR(100)        NULL,
    villeAcheteur  VARCHAR(100)        NULL,
    cpAcheteur  VARCHAR(100)        NULL,
    numHabilitation VARCHAR(100)    NULL,
    dateinsert DATETIME NOT NULL DEFAULT NOW(),
    datemodif DATETIME NOT NULL DEFAULT NOW(),
    clesession VARCHAR(256) NULL,
    constraint PK_ACHETEUR primary key (idUser),
  	constraint FK_ACHETEUR_UTILISATEUR foreign key  (idUser) references utilisateur (id)
    
) ENGINE = INNODB;
INSERT INTO TypeUtilisateur VALUES (5, 'Acheteur');
SET @maxid=(SELECT IFNULL(max(id),-1) FROM Utilisateur)+1;
insert into Utilisateur (id,login,pwd,nomuser,prenomuser,idtypeuser) values(@maxid,'Treant_Marcel',SHA2('TM',256),'Treant','Marcel',5);
insert into acheteur (idUser,raisonSocial, cpAcheteur, villeAcheteur,numHabilitation) VALUES (@maxid,'Audierne Marée','29780','PLOUHINEC','CP40001000');
SET @maxid=@maxid+1;
insert into Utilisateur (id,login,pwd,nomuser,prenomuser,idtypeuser) values(@maxid,'Peren_Stephanie',SHA2('PS',256),'Peren','Stephanie',5);
insert into acheteur (idUser,raisonSocial, cpAcheteur, villeAcheteur,numHabilitation) VALUES (@maxid,'Rosatlantic','29780','PLOUHINEC','CP30002222');
SET @maxid=@maxid+1;
insert into Utilisateur (id,login,pwd,nomuser,prenomuser,idtypeuser) values(@maxid,'Lapez_Johan',SHA2('LJ',256),'Lapez','Johan',5);
insert into acheteur (idUser,raisonSocial, cpAcheteur, villeAcheteur,numHabilitation) VALUES (@maxid,'Viviers d Audierne','29770','AUDIERNE','CP10001111');
SET @maxid=@maxid+1;
insert into Utilisateur (id,login,pwd,nomuser,prenomuser,idtypeuser) values(@maxid,'Lamou_Gerard',SHA2('LG',256),'Lamou','Gerard',5);
insert into acheteur (idUser,raisonSocial, cpAcheteur, villeAcheteur,numHabilitation) VALUES (@maxid,'Conserverie d Audierne','29780','PLOUHINEC','CP45003232');
SET @maxid=@maxid+1;
insert into Utilisateur (id,login,pwd,nomuser,prenomuser,idtypeuser) values(@maxid,'Daniel_Jean',SHA2('DJ',256),'Daniel','Jean',5);
insert into acheteur (idUser,raisonSocial, cpAcheteur, villeAcheteur,numHabilitation) VALUES (@maxid,'La Criee Le Guilvinec','29730','LE GUILVINEC','CP45006786');
SET @maxid=@maxid+1;
insert into Utilisateur (id,login,pwd,nomuser,prenomuser,idtypeuser) values(@maxid,'Louarn_Annie',SHA2('LA',256),'Louarn','Annie',5);
insert into acheteur (idUser,raisonSocial, cpAcheteur, villeAcheteur,numHabilitation) VALUES (@maxid,'Fumoir de la Pointe du Raz','29770','PLOGOFF','CP44004343');
SET @maxid=@maxid+1;
insert into Utilisateur (id,login,pwd,nomuser,prenomuser,idtypeuser) values(@maxid,'Claquin_Jean',SHA2('CJ',256),'Claquin','Jean',5);
insert into acheteur (idUser,raisonSocial, cpAcheteur, villeAcheteur,numHabilitation) VALUES (@maxid,'FURIC MAREE SA','29760','LE GUILVINEC','CP44003236');
SET @maxid=@maxid+1;
insert into Utilisateur (id,login,pwd,nomuser,prenomuser,idtypeuser) values(@maxid,'Doare_Clet',SHA2('DC',256),'Doare','Clet',5);
insert into acheteur (idUser,raisonSocial, cpAcheteur, villeAcheteur,numHabilitation) VALUES (@maxid,'Halios Marée SA','29760','SAINT GUENOLE','CP45003333');
SET @maxid=@maxid+1;
insert into Utilisateur (id,login,pwd,nomuser,prenomuser,idtypeuser) values(@maxid,'Lozach_Hery',SHA2('LH',256),'Lozach','Hery',5);
insert into acheteur (idUser,raisonSocial, cpAcheteur, villeAcheteur,numHabilitation) VALUES (@maxid,'Poissonnerie LEROY','29770','ESQUIBIEN','CP45005656');
SET @maxid=@maxid+1;
insert into Utilisateur (id,login,pwd,nomuser,prenomuser,idtypeuser) values(@maxid,'Quenet_Claude',SHA2('QC',256),'Quenet','Claude',5);
insert into acheteur (idUser,raisonSocial, cpAcheteur, villeAcheteur,numHabilitation) VALUES (@maxid,'Poissonnerie QUENET','29172','DOUARNENEZ','CP46007777');
SET @maxid=@maxid+1;
insert into Utilisateur (id,login,pwd,nomuser,prenomuser,idtypeuser) values(@maxid,'Moan_Mickael',SHA2('MM',256),'Moan','Mickael',5);
insert into acheteur (idUser,raisonSocial, cpAcheteur, villeAcheteur,numHabilitation) VALUES (@maxid,'Aigue Marine','29750','LOCTUDY','CP45008787');
SET @maxid=@maxid+1;
insert into Utilisateur (id,login,pwd,nomuser,prenomuser,idtypeuser) values(@maxid,'Gornes_Bernard',SHA2('BG',256),'Gornes','Bernard',5);
insert into acheteur (idUser,raisonSocial, cpAcheteur, villeAcheteur,numHabilitation) VALUES (@maxid,'Poissonnerie des Halles','29770','AUDIERNE','CP45006666');
alter table lot add constraint FK_LOT_ACHETEUR foreign key  (idAcheteur) references Acheteur (idUser) ON DELETE RESTRICT ON UPDATE RESTRICT;
alter table lot add constraint FK_LOT_FACTURE foreign key  (idFacture) references Facture (id) ON DELETE RESTRICT ON UPDATE RESTRICT;
create table Poster
(
    idDatePeche           DATE                  not null,
    idBateau              INTEGER   UNSIGNED    not null,
    idLot                 NUMERIC(3) UNSIGNED   not null,
    idAcheteur            INTEGER   UNSIGNED    not null,
    prixEnchere       	  DECIMAL(6,2)                  ,
	  HeureEnchere    	  DateTime	                       ,
    constraint PK_POSTER primary key (idDatePeche,idBateau,idLot, idAcheteur), 
    constraint FK_POSTER_LOT foreign key  (idDatePeche,idBateau,idLot) references Lot (idDatePeche,idBateau,id),
    constraint FK_POSTER_ACHETEUR foreign key  (idAcheteur) references Acheteur (idUser))
 ENGINE = INNODB;
 INSERT INTO `Poster` VALUES ('2020-07-18', 11, 1, 6, 7.45, '2020-07-18 10:17:08');
INSERT INTO `Poster` VALUES ('2020-07-18', 11, 1, 8, 6.55, '2020-07-18 10:15:18');
INSERT INTO `Poster` VALUES ('2020-07-18', 11, 1, 9, 7.50, '2020-07-18 10:17:48');
INSERT INTO `Poster` VALUES ('2020-07-18', 11, 2, 6, 7.55, '2020-07-18 10:18:37');
INSERT INTO `Poster` VALUES ('2020-07-18', 11, 2, 7, 8.50, '2020-07-18 10:20:59');
INSERT INTO `Poster` VALUES ('2020-07-18', 11, 2, 8, 8.35, '2020-07-18 10:20:48');
INSERT INTO `Poster` VALUES ('2020-07-18', 11, 2, 9, 7.50, '2020-07-18 10:18:23');
INSERT INTO `Poster` VALUES ('2020-07-18', 11, 3, 7, 7.70, '2020-07-18 10:21:48');
INSERT INTO `Poster` VALUES ('2020-07-18', 11, 3, 9, 8.50, '2020-07-18 10:22:13');
INSERT INTO `Poster` VALUES ('2020-07-18', 11, 4, 6, 9.50, '2020-07-18 10:22:13');
INSERT INTO `Poster` VALUES ('2020-07-18', 11, 4, 7, 10.00, '2020-07-18 10:22:13');
INSERT INTO `Poster` VALUES ('2020-07-18', 11, 5, 9, 8.50, '2020-07-18 10:22:13');
INSERT INTO `Poster` VALUES ('2020-07-18', 11, 5, 7, 8.75, '2020-07-18 10:22:13');
INSERT INTO `Poster` VALUES ('2020-07-20', 11, 1, 6, 7.45, '2020-07-20 10:17:08');
INSERT INTO `Poster` VALUES ('2020-07-20', 11, 1, 7, 7.80, '2020-07-20 10:17:48');
INSERT INTO `Poster` VALUES ('2020-07-20', 11, 1, 8, 6.55, '2020-07-20 10:15:18');
INSERT INTO `Poster` VALUES ('2020-07-20', 11, 2, 6, 8.35, '2020-07-20 10:20:48');
INSERT INTO `Poster` VALUES ('2020-07-20', 11, 2, 7, 8.50, '2020-07-20 10:20:59');
INSERT INTO `Poster` VALUES ('2020-07-20', 11, 2, 8, 8.55, '2020-07-20 10:21:18');
INSERT INTO `Poster` VALUES ('2020-07-20', 11, 2, 9, 7.50, '2020-07-20 10:18:23');
INSERT INTO `Poster` VALUES ('2020-07-21', 11, 1, 6, 8.50, '2020-07-21 10:22:13');
INSERT INTO `Poster` VALUES ('2020-07-21', 11, 1, 7, 7.70, '2020-07-21 10:21:48');
INSERT INTO `Poster` VALUES ('2020-07-21', 11, 2, 7, 7.70, '2020-07-21 10:21:48');
INSERT INTO `Poster` VALUES ('2020-07-21', 11, 2, 8, 8.95, '2020-07-21 10:22:13');
INSERT INTO `Poster` VALUES ('2020-07-30',  7, 1, 9, 17.50, '2020-07-30 11:02:53');
INSERT INTO `Poster` VALUES ('2020-07-30',  7, 2, 8, 16.50, '2020-07-30 11:06:53');
INSERT INTO `Poster` VALUES ('2020-07-30', 11, 1, 7, 8.70, '2020-07-30 11:09:53');
INSERT INTO `Poster` VALUES ('2020-07-30',  1, 1, 7, 7.20, '2020-07-30 11:12:53');
INSERT INTO `Poster` VALUES ('2020-07-30',  1, 2, 7, 9.75, '2020-07-30 11:16:53');
INSERT INTO `Poster` VALUES ('2020-07-30',  1, 3, 6, 14.20, '2020-07-30 11:20:53');
INSERT INTO `Poster` VALUES ('2020-07-30',  3, 1, 6, 14.60, '2020-07-30 11:26:53');
INSERT INTO `Poster` VALUES ('2020-07-30',  3, 2, 6, 15.50, '2020-07-30 11:30:53');
INSERT INTO `Poster` VALUES ('2020-07-30',  7, 1, 6, 15.50, '2020-07-30 11:30:58');
INSERT INTO `Poster` VALUES ('2020-07-30',  1, 8, 6, 12.50, '2020-07-30 11:30:54');
INSERT INTO `Poster` VALUES ('2020-07-30',  3, 5, 6, 14.10, '2020-07-30 11:30:53');
INSERT INTO `Poster` VALUES ('2020-08-25',  3, 1, 9, 4.00, '2020-08-25 15:12:26');
INSERT INTO `Poster` VALUES ('2020-08-25',  3, 2, 8, 6.00, '2020-08-25 15:17:12');
INSERT INTO `Poster` VALUES ('2020-08-25',  3, 2, 9, 7.00, '2020-08-25 15:18:53');
INSERT INTO `Poster` VALUES ('2020-08-25',  3, 3, 8, 7.00, '2020-08-25 15:21:44');
INSERT INTO `Poster` VALUES ('2020-08-25',  3, 3, 9, 8.00, '2020-08-25 15:22:13');
INSERT INTO `Poster` VALUES ('2020-08-25', 11, 1, 9, 23.00, '2020-08-25 16:41:34');
ALTER TABLE facture DROP COLUMN etatPaiement;
ALTER TABLE facture ADD COLUMN montant float;
ALTER TABLE facture ADD COLUMN etatPaiement smallint(6) DEFAULT NULL;
ALTER TABLE lot ADD COLUMN dateinsert DATETIME NOT NULL DEFAULT NOW();
ALTER TABLE lot ADD COLUMN datemodif DATETIME NOT NULL DEFAULT NOW();
ALTER TABLE lot ADD COLUMN iduserinsert INTEGER UNSIGNED NOT NULL DEFAULT 0;
ALTER TABLE lot ADD COLUMN idusermodif INTEGER UNSIGNED NOT NULL DEFAULT 0;
ALTER TABLE lot ALTER COLUMN iduserinsert DROP DEFAULT;
ALTER TABLE lot ALTER COLUMN idusermodif DROP DEFAULT;
alter table lot add constraint FK_LOT_UTILISATEUR_INSERT foreign key  (iduserinsert) references Utilisateur (id) ON DELETE RESTRICT ON UPDATE RESTRICT;
alter table lot add constraint FK_LOT_UTILISATEUR_MODIF foreign key  (idusermodif) references Utilisateur (id) ON DELETE RESTRICT ON UPDATE RESTRICT;
create table directeurvente
(
    idUser                    INTEGER   UNSIGNED    not null,
    clesession VARCHAR(256) NULL,
    constraint PK_DIRECTEURVENTE primary key (idUser),
  	constraint FK_DIRECTEURVENTE_UTILISATEUR foreign key  (idUser) references utilisateur (id)
    
) ENGINE = INNODB;
INSERT INTO directeurvente(idUser) SELECT id FROM utilisateur WHERE idtypeuser=4;
create table histoconnexion
(
    dateConnexion  DATETIME    not null default NOW(),
    AdresseIP VARCHAR(50) NOT NULL,
    result BOOLEAN NOT NULL,
    idUtilisateur INTEGER UNSIGNED NULL,
    constraint PK_HISTOCONNEXION primary key (dateConnexion, AdresseIP),
  	constraint FK_HISTOCONNEXION_UTILISATEUR foreign key  (idUtilisateur) references utilisateur (id)
    
) ENGINE = INNODB;
SET FOREIGN_KEY_CHECKS = 1;
UPDATE espece SET nom='Araignée de mer casier' WHERE id=42040;
UPDATE espece SET nom='Araignée de mer chalut' WHERE id=42041;
UPDATE espece SET nom='Mérou ou cernier' WHERE id=33110;
UPDATE espece SET nom='Mérou noir' WHERE id=33120;
DROP PROCEDURE Auth;
DELIMITER $
CREATE PROCEDURE Auth(
    IN val1 VARCHAR(100),
  IN val2 VARCHAR(100)
)
BEGIN
    SELECT count(utilisateur.id) as nbUser, utilisateur.id as iduser, login, nomuser, prenomuser, idtypeuser, libelle, adrMail
    FROM utilisateur INNER JOIN typeutilisateur ON utilisateur.idtypeuser = typeutilisateur.id
    WHERE login=val1 AND pwd=val2 AND idtypeuser<5;
END$