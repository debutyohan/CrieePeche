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
ALTER TABLE Lot CHANGE COLUMN idLot idLot DECIMAL(5,0) NOT NULL AFTER idBateau,
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
INSERT INTO Etat VALUES (9, 'I', 'Lot virtuel : Bac importé par le pêcheur');DROP TABLE IF EXISTS `migrations`;
CREATE TABLE IF NOT EXISTS `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
	(1, '2014_10_12_000000_create_users_table', 1),
	(2, '2014_10_12_100000_create_password_resets_table', 1),
	(3, '2016_06_01_000001_create_oauth_auth_codes_table', 1),
	(4, '2016_06_01_000002_create_oauth_access_tokens_table', 1),
	(5, '2016_06_01_000003_create_oauth_refresh_tokens_table', 1),
	(6, '2016_06_01_000004_create_oauth_clients_table', 1),
	(7, '2016_06_01_000005_create_oauth_personal_access_clients_table', 1),
	(8, '2019_08_19_000000_create_failed_jobs_table', 1),
	(9, '2019_12_14_000001_create_personal_access_tokens_table', 1),
	(10, '2021_12_15_131325_create_factures_table', 1),
	(11, '2021_12_15_132744_create_lots_table', 1),
	(12, '2021_12_15_133608_create_posters_table', 1),
	(13, '2021_12_15_134101_create_utilisateurs_table', 1),
	(14, '2021_12_15_134539_create_acheteurs_table', 1),
	(15, '2021_12_15_135326_create_directeurventes_table', 1),
	(16, '2021_12_23_182851_create_etats_table', 1),
	(17, '2022_01_10_215945_create_histoconnexions_table', 1);
DROP TABLE IF EXISTS `oauth_access_tokens`;
CREATE TABLE IF NOT EXISTS `oauth_access_tokens` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `client_id` bigint(20) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `scopes` text COLLATE utf8mb4_unicode_ci,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `expires_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_access_tokens_user_id_index` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO `oauth_access_tokens` (`id`, `user_id`, `client_id`, `name`, `scopes`, `revoked`, `created_at`, `updated_at`, `expires_at`) VALUES
	('4fad80d7b6db9353232eba2ac5a9e69bf5a1f340f308ae00a78f4ab2bbd87831d658485abf919c89', 2, 1, 'API Token', '[]', 0, '2022-04-20 09:39:01', '2022-04-20 09:39:01', '2023-04-20 09:39:01'),
	('6f87fdfa72d00d02b8bde0765ae3f0e437ffac3fc1eb4b081882bbf61f04931500b52ccfe61ae958', 2, 1, 'API Token', '[]', 0, '2022-04-20 14:07:11', '2022-04-20 14:07:11', '2023-04-20 14:07:11'),
	('88a6c051a0e1d2b75d4e15863ef1f961d1999171309c0bcd5c9ea1d35f4e81ff3ff1c5352b723082', 14, 7, 'API Token', '[]', 0, '2022-04-20 23:44:48', '2022-04-20 23:44:48', '2023-04-20 23:44:48'),
	('925edbab73d9bcaf354b14754f75e9ed178149de287b88eccc962c879dc3d0263caaf8113c4c2431', 24, 7, 'API Token', '[]', 0, '2022-05-01 22:32:51', '2022-05-01 22:32:51', '2023-05-01 22:32:51');
DROP TABLE IF EXISTS `oauth_auth_codes`;
CREATE TABLE IF NOT EXISTS `oauth_auth_codes` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `client_id` bigint(20) unsigned NOT NULL,
  `scopes` text COLLATE utf8mb4_unicode_ci,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_auth_codes_user_id_index` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `oauth_clients`;
CREATE TABLE IF NOT EXISTS `oauth_clients` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `secret` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `provider` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `redirect` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `personal_access_client` tinyint(1) NOT NULL,
  `password_client` tinyint(1) NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_clients_user_id_index` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO `oauth_clients` (`id`, `user_id`, `name`, `secret`, `provider`, `redirect`, `personal_access_client`, `password_client`, `revoked`, `created_at`, `updated_at`) VALUES
	(1, NULL, 'Laravel Personal Access Client', 'AvCQVM2xOM82b7fE3tOe1BgcODP1QwroMLyRw3XA', NULL, 'http://localhost', 1, 0, 0, '2022-04-19 23:07:52', '2022-04-19 23:07:52'),
	(2, NULL, 'Laravel Password Grant Client', 'Ic69YbU56yk51lSL3SYrGMCf2pE6W2Wuu4M8wWpS', 'users', 'http://localhost', 0, 1, 0, '2022-04-19 23:07:52', '2022-04-19 23:07:52'),
	(3, NULL, 'Laravel Personal Access Client', 'FxkYIIpwd9CrrGEnbRxu4WXOmJHKSC9A7lMuKuRe', NULL, 'http://localhost', 1, 0, 0, '2022-04-20 19:00:44', '2022-04-20 19:00:44'),
	(4, NULL, 'Laravel Password Grant Client', 'evsRCRCdCGYaGcOLrkpbjfqZoy6B48Fdaj21LCP9', 'users', 'http://localhost', 0, 1, 0, '2022-04-20 19:00:44', '2022-04-20 19:00:44'),
	(5, NULL, 'Laravel Personal Access Client', 'Wvkt6Evbp1zTd1tHCgBZrn4cAZlS55IEtmPo1Cmj', NULL, 'http://localhost', 1, 0, 0, '2022-04-20 21:12:06', '2022-04-20 21:12:06'),
	(6, NULL, 'Laravel Password Grant Client', 'PgpToUxIChCOXZcsDbxMbz47zLGMJTzMDp0pqPhf', 'users', 'http://localhost', 0, 1, 0, '2022-04-20 21:12:06', '2022-04-20 21:12:06'),
	(7, NULL, 'Laravel Personal Access Client', 'CFKpjp456HEq1C1KxPGyC2hC4LoWXvEbQfg3HUjd', NULL, 'http://localhost', 1, 0, 0, '2022-04-20 23:35:14', '2022-04-20 23:35:14'),
	(8, NULL, 'Laravel Password Grant Client', 'xmBZCOwP8A0Kw2RPtDrLZuTwLtItloEbCvPQT9cb', 'users', 'http://localhost', 0, 1, 0, '2022-04-20 23:35:14', '2022-04-20 23:35:14');
DROP TABLE IF EXISTS `oauth_personal_access_clients`;
CREATE TABLE IF NOT EXISTS `oauth_personal_access_clients` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `client_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO `oauth_personal_access_clients` (`id`, `client_id`, `created_at`, `updated_at`) VALUES
	(1, 1, '2022-04-19 23:07:52', '2022-04-19 23:07:52'),
	(2, 3, '2022-04-20 19:00:44', '2022-04-20 19:00:44'),
	(3, 5, '2022-04-20 21:12:06', '2022-04-20 21:12:06'),
	(4, 7, '2022-04-20 23:35:14', '2022-04-20 23:35:14');
DROP TABLE IF EXISTS `oauth_refresh_tokens`;
CREATE TABLE IF NOT EXISTS `oauth_refresh_tokens` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `access_token_id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_refresh_tokens_access_token_id_index` (`access_token_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `password_resets`;
CREATE TABLE IF NOT EXISTS `password_resets` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  KEY `password_resets_email_index` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `personal_access_tokens`;
CREATE TABLE IF NOT EXISTS `personal_access_tokens` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint(20) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
SET FOREIGN_KEY_CHECKS = 1;