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
INSERT INTO Utilisateur VALUES (1,_binary 0x376F4B63456C667776463675326B51336841474253673D3D, _binary 0x7062365444466C384F59797566436D775865355A62447869417157786D57426556736A3256324A756449373335562B592F63736772326569324E4268626C4B6B6275744179714C6F6A642F434148437A694A75684A6E555868746D744F4D3773503172644E66483265736F3D, _binary 0x6B41667765324551504F47456E3134597669666C2B673D3D, _binary 0x5A37536471366641486B38554D6849757131384357773D3D, 0, NULL);