CREATE DATABASE bddCrie2 DEFAULT CHARACTER SET latin1 COLLATE latin1_general_ci;

Use bddCrie2;

-- ============================================================
--   Table : Bateau                                            
-- ============================================================
create table Bateau 
(
    id                    INTEGER   UNSIGNED    not null,
    nom                   VARCHAR(32)                   ,
    immatriculation       VARCHAR(10)                   ,
    constraint PK_BATEAU primary key (id)
    
) ENGINE = INNODB;


-- ============================================================
--   Table : Espece                                           
-- ============================================================
create table Espece
(
    id                    INTEGER   UNSIGNED    not null,
    nom                   VarCHAR(32)                   ,
    nomScientifique       VarCHAR(32)                   ,
    nomCourt              CHAR(5)                      ,
    constraint PK_ESPECE primary key (id)
) ENGINE = INNODB;

-- ============================================================
--   Table : Taille                                            
-- ============================================================
create table Taille
(
    id                    NUMERIC(2)            not null,
    specification         VarCHAR(30)                      ,
    constraint PK_TAILLE primary key (id) 
) ENGINE = INNODB;

-- ============================================================
--   Table : Presentation                                      
-- ============================================================
create table Presentation
(
    id                    CHAR(3)               not null,
    libelle       		  CHAR(10)                      ,
    constraint PK_PRESENTATION primary key (id) 
) ENGINE = INNODB;

-- ============================================================
--   Table : BAC                                               
-- ============================================================
create table Bac
(
    id                    CHAR(1)               not null,
    tare                  DECIMAL(6,2)                  ,
    constraint PK_BAC primary key (id) 
) ENGINE = INNODB;

-- ============================================================
--   Table : Acheteur                                          
-- ============================================================
create table Acheteur
(
    id                    INTEGER   UNSIGNED    not null AUTO_INCREMENT,
    login                 VarCHAR(32)  Unique              ,
    pwd                   CHAR(10)                      ,
    raisonSociale         VarCHAR(32)                   ,
    adresse               VarCHAR(32)                   ,
    numHabilitation       CHAR(10)                      ,
    constraint PK_ACHETEUR primary key (id) 
) ENGINE = INNODB;

-- ============================================================
--   Table : Facture                                          
-- ============================================================
create table Facture
(
    id                    INTEGER   UNSIGNED    not null,
    etatPaiement          SMALLINT                      ,
    constraint PK_FACTURE primary key (id) 
) ENGINE = INNODB;


-- ============================================================
--   Table : Qualite                                          
-- ============================================================
create table Qualite
(
    id                    CHAR(1)               not null,
    libelle               CHAR(10)                      ,
    constraint PK_QUALITE primary key (id) 
) ENGINE = INNODB;

-- ============================================================

-- ============================================================
--   Table : Peche                                             
-- ============================================================
create table Peche
(
    datePeche             DATE                  not null,
    idBateau              INTEGER   UNSIGNED    not null,
    constraint PK_PECHE primary key (datePeche, idBateau), 
    constraint FK_PECHE_BATEAU foreign key  (idBateau)  references Bateau (id)
) ENGINE = INNODB;

-- ============================================================
--   Table : Lot                                               
-- ============================================================
create table Lot
(
    idDatePeche           DATE                  not null, 
    idBateau              INTEGER   UNSIGNED    not null,
	id                    NUMERIC(3) UNSIGNED   not null,
    idEspece              INTEGER   UNSIGNED    not null,
    idTaille              NUMERIC(2)            not null,
    idPresentation        CHAR(3)               not null,
    idQualite             CHAR(1)               not null,
	idBac                 CHAR(1)               not null,
    poidsBrutLot          DECIMAL(6,2)                  ,
    prixEnchere           DECIMAL(6,2)                  ,
    dateEnchere           DATE                          ,
	HeureDebutEnchere	  DateTime	                    ,
    prixPlancher          DECIMAL(6,2)                  ,
    prixDepart            DECIMAL(6,2)                  ,
	codeEtat              CHAR(1)                       ,
    idAcheteur            INTEGER   UNSIGNED        null,
	idFacture             INTEGER   UNSIGNED        null,
    constraint PK_LOT primary key (idDatePeche,idBateau,id), 
    constraint FK_LOT_ESPECE foreign key  (idEspece) references Espece (id),
    constraint FK_LOT_PECHE foreign key  (idDatePeche, idBateau) references Peche (datePeche, idBateau),
    constraint FK_LOT_TAILLE foreign key  (idTaille) references Taille (id),
    constraint FK_LOT_PRESENTATION foreign key  (idPresentation) references Presentation (id),
    constraint FK_LOT_BAC foreign key  (idBac) references Bac (id),
    constraint FK_LOT_ACHETEUR foreign key  (idAcheteur) references Acheteur (id),
    constraint FK_LOT_QUALITE foreign key  (idQualite) references Qualite (id)
) ENGINE = INNODB;

-- ============================================================
--   Table : Poster                                            
-- ============================================================
create table Poster
(
    idDatePeche           DATE                  not null,
    idBateau              INTEGER   UNSIGNED    not null,
    idLot                 NUMERIC(3) UNSIGNED   not null,
    idAcheteur            INTEGER   UNSIGNED    not null,
    prixEnchere       	  DECIMAL(6,2)                  ,
	HeureEnchere    	  DateTime	                        ,
    constraint PK_POSTER primary key (idDatePeche,idBateau,idLot, idAcheteur), 
    constraint FK_POSTER_LOT foreign key  (idDatePeche,idBateau,idLot) references Lot (idDatePeche,idBateau,id),
    constraint FK_POSTER_ACHETEUR foreign key  (idAcheteur) references Acheteur (id))
 ENGINE = INNODB;
 
 -- ============================================================
--   Table : Parametre temps d'enchere exprim�e en Minutes                                            
-- ============================================================
 CREATE TABLE Parametre(
  id INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  tempsEnchere integer NOT NULL,
  PRIMARY KEY (id)
)
ENGINE = INNODB;
set names 'latin1';
 
insert into Qualite values('A','glac�');
insert into Qualite values('B','d�class�');
insert into Qualite values('E','extra');

insert into Presentation values('ET','Et�t�');
insert into Presentation values('ENT','Entier');
insert into Presentation values('VID','Vid�');

insert into Taille values(10,'Taille de 10');
insert into Taille values(15,'Taille de 15');
insert into Taille values(20,'Taille de 20');
insert into Taille values(25,'Taille de 25');
insert into Taille values(30,'Taille de 30');
insert into Taille values(35,'Taille de 35');
insert into Taille values(40,'Taille de 40');
insert into Taille values(45,'Taille de 45');
insert into Taille values(50,'Taille de 50');
insert into Taille values(55,'Taille de 55');
insert into Taille values(60,'Taille de 60');
insert into Taille values(65,'Taille de 65');
insert into Taille values(70,'Taille de 70');
insert into Taille values(75,'Taille de 75');
insert into Taille values(80,'Taille de 80');
insert into Taille values(85,'Taille de 85');
insert into Taille values(90,'Taille de 90');
insert into Taille values(95,'Taille de 95');

insert into Bac values('B',2.50);
insert into Bac values('F',4);

insert into Acheteur values(1,'Treant_Marcel','TM','Audierne Mar�e','29780 PLOUHINEC','CP40001000');
insert into Acheteur values(2,'Peren_Stephanie','PS','Rosatlantic','29780 PLOUHINEC','CP30002222');
insert into Acheteur values(3,'Lapez_Johan','LJ','Viviers d�Audierne','29770 AUDIERNE','CP10001111');
insert into Acheteur values(4,'Lamou_Gerard','LG','Conserverie d�Audierne','29780 PLOUHINEC','CP45003232');
insert into Acheteur values(5,'Daniel_Jean','DJ','La Criee Le Guilvinec','29730 LE GUILVINEC','CP45006786');
insert into Acheteur values(6,'Louarn_Annie','LA','Fumoir de la Pointe du Raz','29770 PLOGOFF','CP44004343');
insert into Acheteur values(7,'Claquin_Jean','CJ','FURIC MAREE SA','29760 LE GUILVINEC','CP44003236');
insert into Acheteur values(8,'Doare_Clet','DC','Halios Mar�e SA','29760 SAINT GUENOLE','CP45003333');
insert into Acheteur values(9,'Lozach_Hery','LH','Poissonnerie LEROY','29770 ESQUIBIEN','CP45005656');
insert into Acheteur values(10,'Quenet_Claude','QC','Poissonnerie QUENET','29172 DOUARNENEZ','CP46007777');
insert into Acheteur values(11,'Moan_Mickael','MM','Aigue Marine','29750 LOCTUDY','CP45008787');
insert into Acheteur values(12,'Gornes_Bernard','BG','Poissonnerie des Halles','29770 AUDIERNE','CP45006666');





insert into Espece values(33760,'Baudroie','Lophius Piscatorus','BAUDR');
insert into Espece values(33090,'Bar de Chalut','Dicentrarchus Labrax','BARCH');
insert into Espece values(33091,'Bar de Ligne','Dicentrarchus Labrax','BARLI');
insert into Espece values(32130,'Lieu Jaune de Ligne','Pollachius pollachius','LJAUL');
insert into Espece values(42040,'Araign�e de mer casier','Maja squinado','ARAIS');
insert into Espece values(42041,'Araign�e de mer chalut','Maja squinado','ARAIL');
insert into Espece values(43010,'Homard','Hammarus gammorus','HOMAR');
insert into Espece values(43030,'Langouste rouge','Palinurus elephas','LANGR');
insert into Espece values(32140,'Lieu Noir','Lophius Virens','LNOI');
insert into Espece values(31020,'Turbot','Psetta maxima','TURBO');
insert into Espece values(33480,'Dorade rose','Pagellus bogaraveo','DORAD');
insert into Espece values(38150,'Raie douce','Raja Montagui','RAIE');
insert into Espece values(33020,'Congre commun','Conger conger','CONGR');
insert into Espece values(32020,'Merlu','Merluccius bilinearis','MERLU');
insert into Espece values(31030,'Barbue','Scophthalmus rhombus','BARBU');
insert into Espece values(31150,'Plie ou carrelet','Pleuronectes Platessa','PLIE');
insert into Espece values(32050,'Cabillaud','Gadus Morhua Morhue','CABIL');
insert into Espece values(32230,'Lingue franche','Molva Molva','LINGU');
insert into Espece values(33080,'Saint Pierre','Zeus Faber','STPIE');
insert into Espece values(33110,'M�rou ou cernier','Polyprion Americanus','CERNI');
insert into Espece values(33120,'M�rou noir','Epinephelus Guaza','MEROU');
insert into Espece values(33410,'Rouget Barbet','Mullus SPP','ROUGT');
insert into Espece values(33450,'Dorade royale chalut','Sparus Aurata','DORAC');
insert into Espece values(33451,'Dorade royale ligne','Sparus Aurata','DORAL');
insert into Espece values(33490,'Pageot Acarne','Pagellus Acarne','PAGEO');
insert into Espece values(33500,'Pageot Commun','Pagellus Arythrinus','PAGEC');
insert into Espece values(33580,'Vieille','LabrusBergylta','VIEIL');
insert into Espece values(33730,'Grondin gris','Eutrigla Gurnadus','GRONG');
insert into Espece values(33740,'Grondin rouge','Aspitrigla Cuculus','GRONR');
insert into Espece values(33761,'Baudroie Maigre','Lophius Piscicatorius','BAUDM');
insert into Espece values(33790,'Grondin Camard','Trigloporus Lastoviza','GRONC');
insert into Espece values(33800,'Grondin Perlon','Trigla Lucerna','GRONP');
insert into Espece values(34150,'Mulet','Mugil SPP','MULET');
insert into Espece values(35040,'Sardine atlantique','Sardina Pilchardus','SARDI');
insert into Espece values(37050,'Maquereau','Scomber Scombrus','MAQUE');
insert into Espece values(38160,'Raie Pastenague commune','Dasyatis Pastinaca','RAIEP');
insert into Espece values(42020,'Crabe tourteau de casier','Cancer Pagurus','CRABS');
insert into Espece values(42021,'Crabe tourteau de chalut','Cancer Pagurus','CRABL');
insert into Espece values(44010,'Langoustine','Nephrops norvegicus','LANGT');
insert into Espece values(57010,'Seiche','Sepia SPP','SEICH');
insert into Espece values(57020,'Calmar','Loligo SPP','CALAM');
insert into Espece values(57050,'Poulpe','Octopus SPP','POULP');

insert into Bateau values(1,'Altair','Ad 895511');
insert into Bateau values(2,'Macareux','Ad 584873');
insert into Bateau values(3,'Avel Ar Mor','Ad 584930');
insert into Bateau values(4,'Plujadur','Ad 627846');
insert into Bateau values(5,'Gwaien','Ad 730414');
insert into Bateau values(6,'L Estran','Ad 815532');
insert into Bateau values(7,'Le Petit Corse','Ad 584826');
insert into Bateau values(8,'Le Vorlen','Ad 614221');
insert into Bateau values(9,'Les Copains d Abord','Ad 584846');
insert into Bateau values(10,'Tu Pe Du','Ad 584871');
insert into Bateau values(11,'Korrigan','Ad 895472');
insert into Bateau values(12,'Ar Guevel','Ad 895479');
insert into Bateau values(13,'Broceliande','Ad 895519');
insert into Bateau values(14,'L Aventurier','Ad 584865');
insert into Bateau values(15,'L Oceanide','Ad 741312');
insert into Bateau values(16,'L Arche d alliance','Ad 584830');
insert into Bateau values(17,'Sirocco','Ad 715792');
insert into Bateau values(18,'Ondine','Ad 584772');
insert into Bateau values(19,'Chimere','Ad 895516');


INSERT INTO `Peche` VALUES ('2020-07-18',1 );
INSERT INTO `Peche` VALUES ('2020-07-18',4 );
INSERT INTO `Peche` VALUES ('2020-07-18',9 );
INSERT INTO `Peche` VALUES ('2020-07-18',11);
INSERT INTO `Peche` VALUES ('2020-07-20',11);
INSERT INTO `Peche` VALUES ('2020-07-21',11);
INSERT INTO `Peche` VALUES ('2020-07-23',11);
INSERT INTO `Peche` VALUES ('2020-07-24',1 );
INSERT INTO `Peche` VALUES ('2020-07-24',11);
INSERT INTO `Peche` VALUES ('2020-07-25',1 );
INSERT INTO `Peche` VALUES ('2020-07-25',3 );
INSERT INTO `Peche` VALUES ('2020-07-25',7 );
INSERT INTO `Peche` VALUES ('2020-07-25',11);
INSERT INTO `Peche` VALUES ('2020-07-30',1 );
INSERT INTO `Peche` VALUES ('2020-07-30',3 );
INSERT INTO `Peche` VALUES ('2020-07-30',7 );
INSERT INTO `Peche` VALUES ('2020-07-30',11);
INSERT INTO `Peche` VALUES ('2020-08-12',5 );
INSERT INTO `Peche` VALUES ('2020-08-12',9 );
INSERT INTO `Peche` VALUES ('2020-08-25',3 );
INSERT INTO `Peche` VALUES ('2020-08-25',11);


INSERT INTO `Lot` VALUES ('2020-07-18', 11, 1, 32130, 40, 'VID', 'E', 'B', 8.40, 7.50, '2020-07-18', '2020-07-18 10:15:00', 6.00, 6.00, 'T', 4, NULL);
INSERT INTO `Lot` VALUES ('2020-07-18', 11, 2, 32130, 40, 'VID', 'E', 'B', 9.10, 8.90, '2020-07-18', '2020-07-18 10:18:20', 6.00, 6.00, 'T', 1, NULL);
INSERT INTO `Lot` VALUES ('2020-07-18', 11, 3, 32130, 40, 'VID', 'E', 'B', 8.40, 8.50, '2020-07-18', '2020-07-18 10:21:20', 6.00, 6.00, 'T',4, NULL);
INSERT INTO `Lot` VALUES ('2020-07-18', 11, 4, 32130, 20, 'VID', 'E', 'F', 15.10, 10.00, '2020-07-18', '2020-07-18 10:25:20', 8.50, 8.50, 'T', 2, NULL);
INSERT INTO `Lot` VALUES ('2020-07-18', 11, 5, 32130, 30, 'VID', 'E', 'F', 10.40, 16.50, '2020-07-18', '2020-07-18 10:30:20', 14.30, 13.30, 'L', NULL, NULL);
INSERT INTO `Lot` VALUES ('2020-07-20', 11, 1, 32130, 40, 'VID', 'E', 'B', 8.40, 7.50, '2020-07-20', '2020-07-20 10:15:00', 6.00, 6.00, 'T', 2, NULL);
INSERT INTO `Lot` VALUES ('2020-07-20', 11, 2, 32130, 40, 'VID', 'E', 'B', 9.10, 8.90, '2020-07-20', '2020-07-20 10:18:20', 6.00, 6.00, 'T', 3, NULL);
INSERT INTO `Lot` VALUES ('2020-07-20', 11, 3, 32130, 40, 'VID', 'E', 'B', 8.40, 8.50, '2020-07-20', '2020-07-20 10:21:20', 6.00, 6.00, 'T', NULL, NULL);
INSERT INTO `Lot` VALUES ('2020-07-20', 11, 4, 32130, 25, 'VID', 'A', 'F', 15.10, 17.00, '2020-07-20', '2020-07-20 10:25:20', 16.50, 15.50, 'T', NULL, NULL);
INSERT INTO `Lot` VALUES ('2020-07-20', 11, 5, 32130, 30, 'VID', 'E', 'F', 10.40, 16.85, '2020-07-20', '2020-07-20 10:30:20', 16.30, 15.30, 'T', NULL, NULL);
INSERT INTO `Lot` VALUES ('2020-07-21', 11, 1, 32130, 40, 'VID', 'E', 'B', 8.40, 7.50, '2020-07-21', '2020-07-21 10:15:00', 6.00, 6.00, 'T', 1, NULL);
INSERT INTO `Lot` VALUES ('2020-07-21', 11, 2, 32130, 40, 'VID', 'E', 'B', 9.10, 8.90, '2020-07-21', '2020-07-21 10:18:20', 6.00, 6.00, 'T', 3, NULL);
INSERT INTO `Lot` VALUES ('2020-07-21', 11, 3, 32130, 40, 'VID', 'E', 'B', 8.40, 8.50, '2020-07-21', '2020-07-21 10:21:20', 6.00, 6.00, 'T', 1, NULL);
INSERT INTO `Lot` VALUES ('2020-07-21', 11, 4, 32130, 20, 'VID', 'E', 'F', 15.10, 17.30, '2020-07-21', '2020-07-21 10:25:20', 16.50, 15.50, 'T', 2, NULL);
INSERT INTO `Lot` VALUES ('2020-07-21', 11, 5, 32130, 30, 'VID', 'E', 'F', 10.40, 17.00, '2020-07-21', '2020-07-21 10:30:20', 14.30, 14.30, 'T', 3, NULL);
INSERT INTO `Lot` VALUES ('2020-07-23', 11, 1, 32130, 20, 'VID', 'E', 'F', 19.20, 9.20, '2020-07-23', '2020-07-23 10:25:20', 4.80, 4.50, 'T', 4, NULL);
INSERT INTO `Lot` VALUES ('2020-07-23', 11, 2, 32130, 40, 'VID', 'E', 'F', 19.20, 19.20, '2020-07-23','2020-07-23 10:28:20', 5.50, 5.00, 'T', 1, NULL);
INSERT INTO `Lot` VALUES ('2020-07-24', 11, 1, 32130, 70, 'VID', 'E', 'B', 13.00, 14.85, '2020-07-24','2020-07-24 10:08:20', 14.00, 12.00, 'T', 2, NULL);
INSERT INTO `Lot` VALUES ('2020-07-24', 11, 2, 33091, 10, 'ENT', 'A', 'F', 8.00, 15.00, '2020-07-24','2020-07-24 10:18:20', 14.00, 13.00, 'T', 3, NULL);
INSERT INTO `Lot` VALUES ('2020-07-24', 11, 3, 33091, 30, 'ENT', 'E', 'F', 21.00, 8.75, '2020-07-24','2020-07-24 10:38:20', 8.50, 8.30, 'T', 4, NULL);
INSERT INTO `Lot` VALUES ('2020-07-24', 11, 4, 33091, 35, 'ENT', 'E', 'B', 12.00, 8.00, '2020-07-24','2020-07-24 10:48:20', 7.50, 7.00, 'T', 1, NULL);
INSERT INTO `Lot` VALUES ('2020-07-24',  1, 1, 32230, 25, 'VID', 'E', 'B', 20.00, 9.15, '2020-07-24','2020-07-24 10:58:20', 8.50, 8.00, 'T', 2, NULL);
INSERT INTO `Lot` VALUES ('2020-07-24',  1, 2, 32230, 30, 'VID', 'E', 'B', 20.00, 14.65, '2020-07-24','2020-07-24 11:08:20', 14.00, 13.00, 'T', 3, NULL);
INSERT INTO `Lot` VALUES ('2020-07-24',  1, 3, 32230, 40, 'VID', 'E', 'F', 18.00, 8.35, '2020-07-24','2020-07-24 11:18:20', 8.00, 7.50, 'T', 4, NULL);
INSERT INTO `Lot` VALUES ('2020-07-24',  1, 4, 33580, 25, 'VID', 'E', 'F', 14.00, 17.10, '2020-07-24','2020-07-24 11:28:20', 16.50, 16.00, 'T', 1, NULL);
INSERT INTO `Lot` VALUES ('2020-07-24', 11, 5, 33580, 20, 'VID', 'E', 'B', 8.00, 14.80, '2020-07-24','2020-07-24 11:38:20', 14.00, 13.50, 'T', 2, NULL);
INSERT INTO `Lot` VALUES ('2020-07-25',  7, 1, 32230, 25, 'VID', 'E', 'F', 14.50, 16.70, '2020-07-25', '2020-07-25 17:55:00', 16.00, 15.00, 'T', NULL, NULL);
INSERT INTO `Lot` VALUES ('2020-07-25',  7, 2, 32230, 35, 'VID', 'E', 'F', 17.50, 16.50, '2020-07-25', '2020-07-25 18:00:00', 15.00, 14.00, 'T', NULL, NULL);
INSERT INTO `Lot` VALUES ('2020-07-25', 11, 1, 33580, 40, 'VID', 'E', 'F', 18.50, 8.65, '2020-07-25', '2020-07-25 11:24:04', 8.00, 7.00, 'T', NULL, NULL);
INSERT INTO `Lot` VALUES ('2020-07-25',  1, 1, 33091, 10, 'ENT', 'A', 'F', 10.80, 8.85, '2020-07-25', '2020-07-25 11:00:04', 7.00, 6.00, 'T', NULL, NULL);
INSERT INTO `Lot` VALUES ('2020-07-25',  1, 2, 33580, 20, 'VID', 'E', 'B', 9.60, 9.85, '2020-07-25', '2020-07-25 11:15:53', 9.00, 8.00, 'T', NULL, NULL);
INSERT INTO `Lot` VALUES ('2020-07-25',  1, 3, 33091, 15, 'ENT', 'B', 'B', 8.00, 15.25, '2020-07-25', '2020-07-25 11:18:53', 14.00, 13.00, 'T', NULL, NULL);
INSERT INTO `Lot` VALUES ('2020-07-25',  3, 1, 33091, 30, 'ENT', 'B', 'F', 19.00, 14.80, '2020-07-25', '2020-07-25 11:22:53', 14.00, 12.00, 'T', NULL, NULL);
INSERT INTO `Lot` VALUES ('2020-07-25',  3, 2, 33091, 30, 'ENT', 'B', 'F', 19.00, 14.80, '2020-07-25', '2020-07-25 11:32:53', 14.00, 12.00, 'T', NULL, NULL);
INSERT INTO `Lot` VALUES ('2020-07-30',  7, 1, 33080, 25, 'VID', 'E', 'F', 14.50, 17.50, '2020-07-30', '2020-07-30 17:55:00', 16.00, 15.00, 'T', 4, NULL);
INSERT INTO `Lot` VALUES ('2020-07-30',  7, 2, 33080, 35, 'VID', 'E', 'F', 17.50, 16.50, '2020-07-30', '2020-07-30 18:00:00', 15.00, 14.00, 'T', 3, NULL);
INSERT INTO `Lot` VALUES ('2020-07-30', 11, 1, 33080, 40, 'VID', 'E', 'F', 18.50, 8.70, '2020-07-30', '2020-07-30 11:24:04', 8.00, 7.00, 'T', 2, NULL);
INSERT INTO `Lot` VALUES ('2020-07-30',  1, 1, 33091, 10, 'ENT', 'A', 'F', 10.80, 7.20, '2020-07-30', '2020-07-30 11:00:04', 7.00, 6.00, 'T', 2, NULL);
INSERT INTO `Lot` VALUES ('2020-07-30',  1, 2, 33080, 20, 'VID', 'E', 'B', 9.60, 9.75, '2020-07-30', '2020-07-30 11:15:53', 9.00, 8.00, 'T', 2, NULL);
INSERT INTO `Lot` VALUES ('2020-07-30',  1, 3, 33091, 15, 'ENT', 'B', 'B', 8.00, 14.20, '2020-07-30', '2020-07-30 11:18:53', 14.00, 13.00, 'T', 1, NULL);
INSERT INTO `Lot` VALUES ('2020-07-30',  3, 1, 33091, 30, 'ENT', 'B', 'F', 19.00, 14.60, '2020-07-30', '2020-07-30 11:22:53', 14.00, 12.00, 'T', 1, NULL);
INSERT INTO `Lot` VALUES ('2020-07-30',  3, 2, 33110, 30, 'ENT', 'B', 'F', 19.00, 14.15, '2020-07-30', '2020-07-30 11:32:53', 14.00, 12.00, 'T', 1, NULL);
INSERT INTO `Lot` VALUES ('2020-07-30',  7, 3, 33080, 25, 'VID', 'E', 'F', 14.50, 0.00, '2020-07-30', '2020-07-30 17:55:00', 16.00, 15.00, 'E', NULL, NULL);
INSERT INTO `Lot` VALUES ('2020-07-30',  7, 4, 33080, 35, 'VID', 'E', 'F', 17.50, 0.00, '2020-07-30', '2020-07-30 18:00:00', 15.00, 14.00, 'E', NULL, NULL);
INSERT INTO `Lot` VALUES ('2020-07-30', 11, 2, 33080, 40, 'VID', 'E', 'F', 18.50, 0.00, '2020-07-30', '2020-07-30 11:24:04', 8.00, 7.00, 'E', NULL, NULL);
INSERT INTO `Lot` VALUES ('2020-07-30',  1, 4, 33110, 10, 'ENT', 'A', 'F', 10.80, 0.00, '2020-07-30', '2020-07-30 11:00:04', 7.00, 6.00, 'E', NULL, NULL);
INSERT INTO `Lot` VALUES ('2020-07-30',  1, 5, 33080, 20, 'VID', 'E', 'B', 9.60, 0.00, '2020-07-30', '2020-07-30 11:15:53', 9.00, 8.00, 'E', NULL, NULL);
INSERT INTO `Lot` VALUES ('2020-07-30',  1, 6, 33110, 15, 'ENT', 'B', 'B', 8.00, 0.00, '2020-07-30', '2020-07-30 11:18:53', 14.00, 13.00, 'E', NULL, NULL);
INSERT INTO `Lot` VALUES ('2020-07-30',  3, 3, 33110, 30, 'ENT', 'B', 'F', 19.00, 0.00, '2020-07-30', '2020-07-30 11:22:53', 14.00, 12.00, 'E', NULL, NULL);
INSERT INTO `Lot` VALUES ('2020-07-30',  3, 4, 33451, 30, 'ENT', 'B', 'F', 19.00, 0.00, '2020-07-30', '2020-07-30 11:32:53', 14.00, 12.00, 'E', NULL, NULL);
INSERT INTO `Lot` VALUES ('2020-07-30',  7, 5, 33080, 25, 'VID', 'E', 'F', 14.50, 0.00, '2020-07-30', '2020-07-30 17:55:00', 16.00, 15.00, 'E', NULL, NULL);
INSERT INTO `Lot` VALUES ('2020-07-30',  7, 6, 33080, 35, 'VID', 'E', 'F', 17.50, 0.00, '2020-07-30', '2020-07-30 18:00:00', 15.00, 14.00, 'E', NULL, NULL);
INSERT INTO `Lot` VALUES ('2020-07-30', 11, 3, 33080, 40, 'VID', 'E', 'F', 18.50, 0.00, '2020-07-30', '2020-07-30 11:24:04', 8.00, 7.00, 'E', NULL, NULL);
INSERT INTO `Lot` VALUES ('2020-07-30',  1, 7, 33451, 10, 'ENT', 'A', 'F', 10.80, 0.00, '2020-07-30', '2020-07-30 11:00:04', 7.00, 6.00, 'E', NULL, NULL);
INSERT INTO `Lot` VALUES ('2020-07-30',  1, 8, 33080, 20, 'VID', 'E', 'B', 9.60, 0.00, '2020-07-30', '2020-07-30 11:15:53', 9.00, 8.00, 'E', NULL, NULL);
INSERT INTO `Lot` VALUES ('2020-07-30',  1, 9, 33451, 15, 'ENT', 'B', 'B', 8.00, 0.00, '2020-07-30', '2020-07-30 11:18:53', 14.00, 13.00, 'E', NULL, NULL);
INSERT INTO `Lot` VALUES ('2020-07-30',  3, 5, 33451, 30, 'ENT', 'B', 'F', 19.00, 0.00, '2020-07-30', '2020-07-30 11:22:53', 14.00, 12.00, 'E', NULL, NULL);
INSERT INTO `Lot` VALUES ('2020-07-30',  3, 6, 33451, 30, 'ENT', 'B', 'F', 19.00, 0.00, '2020-07-30', '2020-07-30 11:32:53', 14.00, 12.00, 'E', NULL, NULL);
INSERT INTO `Lot` VALUES ('2020-08-12',  5, 1, 32050, 25, 'VID', 'E', 'F', 12.00, 15.00, '2020-08-25', '2020-08-25 16:11:30', 3.00, 5.00, 'C', 4, NULL);
INSERT INTO `Lot` VALUES ('2020-08-12',  9, 1, 42040, 10, 'ENT', 'E', 'F', 15.00, NULL, '2020-08-25', '2020-08-25 16:11:30', NULL, NULL, 'C', NULL, NULL);
INSERT INTO `Lot` VALUES ('2020-08-12',  9, 2, 42040, 10, 'ENT', 'E', 'F', 20.00, NULL, '2020-08-25', '2020-08-25 16:11:30', NULL, NULL, 'C', NULL, NULL);
INSERT INTO `Lot` VALUES ('2020-08-25',  3, 1, 33090, 25, 'ENT', 'E', 'B', 13.00, 4.00, '2020-08-25', '2020-08-25 16:23:25', 2.00, 2.00, 'T', 4, NULL);
INSERT INTO `Lot` VALUES ('2020-08-25',  3, 2, 33090, 25, 'ENT', 'E', 'B', 15.00, 7.00, '2020-08-25', '2020-08-25 16:27:25', 2.00, 2.00, 'T', 4, NULL);
INSERT INTO `Lot` VALUES ('2020-08-25',  3, 3, 33090, 25, 'ENT', 'E', 'B', 15.80, 8.00, '2020-08-25', '2020-08-25 16:35:25', 2.00, 2.00, 'T', 4, NULL);
INSERT INTO `Lot` VALUES ('2020-08-25',  3, 4, 33090, 25, 'ENT', 'E', 'B', 15.80, NULL, '2020-08-25', '2020-08-25 16:11:30', NULL, NULL, 'C', NULL, NULL);
INSERT INTO `Lot` VALUES ('2020-08-25',  3, 5, 33090, 25, 'ENT', 'E', 'B', 13.80, NULL, '2020-08-25', '2020-08-25 16:11:30', NULL, NULL, 'C', NULL, NULL);
INSERT INTO `Lot` VALUES ('2020-08-25',  3, 6, 33090, 25, 'ENT', 'E', 'B', 11.80, NULL, '2020-08-25', '2020-08-25 16:11:30', NULL, NULL, 'C', NULL, NULL);
INSERT INTO `Lot` VALUES ('2020-08-25', 11, 1, 33091, 25, 'ENT', 'E', 'F', 14.60, NULL, '2020-08-25', '2020-08-25 16:39:25', 2.00, 2.00, 'E', NULL, NULL);
INSERT INTO `Lot` VALUES ('2020-08-25', 11, 2, 33091, 25, 'ENT', 'E', 'F', 15.60, NULL, '2020-08-25', '2020-08-25 16:43:25', 2.00, 2.00, 'E', NULL, NULL);
INSERT INTO `Lot` VALUES ('2020-08-25',  3, 7, 33090, 25, 'ENT', 'E', 'B', 15.80, NULL, '2020-08-25', '2020-08-25 16:47:25', 2.00, 2.00, 'E', NULL, NULL);

INSERT INTO `Poster` VALUES ('2020-07-18', 11, 1, 1, 7.45, '2020-07-18 10:17:08');
INSERT INTO `Poster` VALUES ('2020-07-18', 11, 1, 3, 6.55, '2020-07-18 10:15:18');
INSERT INTO `Poster` VALUES ('2020-07-18', 11, 1, 4, 7.50, '2020-07-18 10:17:48');
INSERT INTO `Poster` VALUES ('2020-07-18', 11, 2, 1, 7.55, '2020-07-18 10:18:37');
INSERT INTO `Poster` VALUES ('2020-07-18', 11, 2, 2, 8.50, '2020-07-18 10:20:59');
INSERT INTO `Poster` VALUES ('2020-07-18', 11, 2, 3, 8.35, '2020-07-18 10:20:48');
INSERT INTO `Poster` VALUES ('2020-07-18', 11, 2, 4, 7.50, '2020-07-18 10:18:23');
INSERT INTO `Poster` VALUES ('2020-07-18', 11, 3, 2, 7.70, '2020-07-18 10:21:48');
INSERT INTO `Poster` VALUES ('2020-07-18', 11, 3, 4, 8.50, '2020-07-18 10:22:13');
INSERT INTO `Poster` VALUES ('2020-07-18', 11, 4, 1, 9.50, '2020-07-18 10:22:13');
INSERT INTO `Poster` VALUES ('2020-07-18', 11, 4, 2, 10.00, '2020-07-18 10:22:13');
INSERT INTO `Poster` VALUES ('2020-07-18', 11, 5, 4, 8.50, '2020-07-18 10:22:13');
INSERT INTO `Poster` VALUES ('2020-07-18', 11, 5, 2, 8.75, '2020-07-18 10:22:13');
INSERT INTO `Poster` VALUES ('2020-07-20', 11, 1, 1, 7.45, '2020-07-20 10:17:08');
INSERT INTO `Poster` VALUES ('2020-07-20', 11, 1, 2, 7.80, '2020-07-20 10:17:48');
INSERT INTO `Poster` VALUES ('2020-07-20', 11, 1, 3, 6.55, '2020-07-20 10:15:18');
INSERT INTO `Poster` VALUES ('2020-07-20', 11, 2, 1, 8.35, '2020-07-20 10:20:48');
INSERT INTO `Poster` VALUES ('2020-07-20', 11, 2, 2, 8.50, '2020-07-20 10:20:59');
INSERT INTO `Poster` VALUES ('2020-07-20', 11, 2, 3, 8.55, '2020-07-20 10:21:18');
INSERT INTO `Poster` VALUES ('2020-07-20', 11, 2, 4, 7.50, '2020-07-20 10:18:23');
INSERT INTO `Poster` VALUES ('2020-07-21', 11, 1, 1, 8.50, '2020-07-21 10:22:13');
INSERT INTO `Poster` VALUES ('2020-07-21', 11, 1, 2, 7.70, '2020-07-21 10:21:48');
INSERT INTO `Poster` VALUES ('2020-07-21', 11, 2, 2, 7.70, '2020-07-21 10:21:48');
INSERT INTO `Poster` VALUES ('2020-07-21', 11, 2, 3, 8.95, '2020-07-21 10:22:13');
INSERT INTO `Poster` VALUES ('2020-07-30',  7, 1, 4, 17.50, '2020-07-30 11:02:53');
INSERT INTO `Poster` VALUES ('2020-07-30',  7, 2, 3, 16.50, '2020-07-30 11:06:53');
INSERT INTO `Poster` VALUES ('2020-07-30', 11, 1, 2, 8.70, '2020-07-30 11:09:53');
INSERT INTO `Poster` VALUES ('2020-07-30',  1, 1, 2, 7.20, '2020-07-30 11:12:53');
INSERT INTO `Poster` VALUES ('2020-07-30',  1, 2, 2, 9.75, '2020-07-30 11:16:53');
INSERT INTO `Poster` VALUES ('2020-07-30',  1, 3, 1, 14.20, '2020-07-30 11:20:53');
INSERT INTO `Poster` VALUES ('2020-07-30',  3, 1, 1, 14.60, '2020-07-30 11:26:53');
INSERT INTO `Poster` VALUES ('2020-07-30',  3, 2, 1, 15.50, '2020-07-30 11:30:53');
INSERT INTO `Poster` VALUES ('2020-07-30',  7, 1, 1, 15.50, '2020-07-30 11:30:58');
INSERT INTO `Poster` VALUES ('2020-07-30',  1, 8, 1, 12.50, '2020-07-30 11:30:54');
INSERT INTO `Poster` VALUES ('2020-07-30',  3, 5, 1, 14.10, '2020-07-30 11:30:53');
INSERT INTO `Poster` VALUES ('2020-08-25',  3, 1, 4, 4.00, '2020-08-25 15:12:26');
INSERT INTO `Poster` VALUES ('2020-08-25',  3, 2, 3, 6.00, '2020-08-25 15:17:12');
INSERT INTO `Poster` VALUES ('2020-08-25',  3, 2, 4, 7.00, '2020-08-25 15:18:53');
INSERT INTO `Poster` VALUES ('2020-08-25',  3, 3, 3, 7.00, '2020-08-25 15:21:44');
INSERT INTO `Poster` VALUES ('2020-08-25',  3, 3, 4, 8.00, '2020-08-25 15:22:13');
INSERT INTO `Poster` VALUES ('2020-08-25', 11, 1, 4, 23.00, '2020-08-25 16:41:34');
insert into Parametre values(NULL, 3);

GRANT ALL PRIVILEGES ON bddCrie2.* to "informa" IDENTIFIED BY "ticien";
GRANT SELECT, INSERT, UPDATE, DELETE ON bddCrie2.* to "gestionCrie" IDENTIFIED BY "123xaro08";
 
