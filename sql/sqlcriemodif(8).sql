Use bddCrie2;
create table TypeUtilisateur
(
    id                    INTEGER   UNSIGNED    not null,
    libelle                VARCHAR(50) not null,
    constraint PK_TYPEUSER primary key (id)
    
) ENGINE = INNODB;
INSERT INTO TypeUtilisateur (id,libelle) VALUES (1,'Peseur'),(2,'Vétérinaire'),(3,'Alternant'),(4,'Directeur de vente');
create table Utilisateur
(
    id                    INTEGER   UNSIGNED    not null,
    login                   VARCHAR(100)                   not null,
    pwd       VARCHAR(256)                   not null,
    nomuser     VARCHAR(100)        NOT NULL,
    prenomuser  VARCHAR(100)        NOT NULL,
    idtypeuser            INTEGER UNSIGNED not null,
    constraint PK_BUTILISATEUR primary key (id),
    constraint FK_BAC_TYPEUTILISATEUR foreign key  (idtypeuser) references TypeUtilisateur (id)
    
) ENGINE = INNODB;

ALTER TABLE Lot DROP FOREIGN KEY FK_LOT_BAC;
ALTER TABLE Bac rename to TypeBac;

create table Bac
(
    id                    NUMERIC(3) UNSIGNED   not null default 1,
    idDatePeche           DATE                  not null,
    idBateau              INTEGER   UNSIGNED    not null,
    idLot                 NUMERIC(3) UNSIGNED   not null,
    idTypeBac             CHAR(1)                not null,
    poidsbrutBac          DECIMAL(6,2)	       not null,
    constraint PK_POSTER primary key (id,idDatePeche,idBateau,idLot), 
    constraint FK_BAC_TYPEBAC foreign key  (idTypeBac) references TypeBac (id),
    constraint FK_BAC_LOT foreign key  (idDatePeche,idBateau,idLot) references Lot (idDatePeche,idBateau,id)
)
 ENGINE = INNODB;
ALTER TABLE Bac ALTER poidsbrutBac SET DEFAULT 0.00;
INSERT INTO Bac (idDatePeche, idBateau, idLot, idTypeBac)
SELECT Lot.idDatePeche, Lot.idBateau, Lot.id, Lot.idBac
FROM Lot ORDER BY idDatePeche;

ALTER TABLE Lot DROP idBac;
ALTER TABLE Lot DROP poidsBrutLot;

INSERT INTO TypeUtilisateur VALUES (0, 'Administrateur');
UPDATE TypeUtilisateur SET libelle='Directeur des ventes' WHERE id=4;

DELIMITER $
CREATE PROCEDURE Auth(
    IN val1 VARCHAR(100),
  IN val2 VARCHAR(100)
)
BEGIN
    SELECT count(utilisateur.id) as nbUser, utilisateur.id as iduser, login, nomuser, prenomuser, idtypeuser, libelle, adrMail
    FROM utilisateur INNER JOIN typeutilisateur ON utilisateur.idtypeuser = typeutilisateur.id
    WHERE login=val1 AND pwd=val2;
END$
Delimiter ;

ALTER TABLE Utilisateur ADD adrMail VARCHAR(300);
ALTER TABLE Utilisateur MODIFY COLUMN prenomuser VARCHAR(100) NULL;
ALTER TABLE Utilisateur MODIFY COLUMN nomuser VARCHAR(100) NULL;