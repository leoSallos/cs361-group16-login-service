/* EECS dev team: Emery Strange */
/* Copyright 2025-2026 */

DROP SCHEMA IF EXISTS lserve;
CREATE SCHEMA lserve;
USE lserve;

DROP PROCEDURE IF EXISTS sp_create_lserveDB;
DELIMITER //
CREATE PROCEDURE sp_create_lserveDB() 
BEGIN
	SET FOREIGN_KEY_CHECKS=0;
	SET AUTOCOMMIT = 0;

	/* Users */
	DROP TABLE IF EXISTS `LS_Users`;
	CREATE TABLE `LS_Users` (
		/* */
		`userID` int(11) NOT NULL AUTO_INCREMENT,
		`username` varchar(25) NOT NULL,
		`firstName` varchar(25) NOT NULL,
		`lastName` varchar(25),
		`password` varchar(25) NOT NULL,
		`email` varchar(25),
		`allowAds` BOOLEAN DEFAULT 0,
		
		/* App data */
		`powerLevel` int(11) DEFAULT 0,
		`powerXP` int(11) DEFAULT 0,
		`comics_page` int(11) DEFAULT 0,
		`cards_collectionID` int(11), /* TODO: needs constraint */
		
		PRIMARY KEY (`userID`)
	);

	/* Friends */
	DROP TABLE IF EXISTS `LS_Friends`;
	CREATE TABLE `LS_Friends` (
		`friendID` int(11) NOT NULL AUTO_INCREMENT,
		`user1` int(11) NOT NULL,
		`user2` int(11) NOT NULL,
		
		PRIMARY KEY (`friendID`),
		CONSTRAINT FK_LS_Friends_User1 FOREIGN KEY (`user1`)
		REFERENCES LS_Users(`userID`) ON DELETE CASCADE ON UPDATE CASCADE,
		CONSTRAINT FK_LS_Friends_User2 FOREIGN KEY (`user2`)
		REFERENCES LS_Users(`userID`) ON DELETE CASCADE ON UPDATE CASCADE
	);

	/* Test */
	SHOW TABLES;
	DESCRIBE LS_Users;
	DESCRIBE LS_Friends;

	/* Populate */
	INSERT INTO LS_Users (`username`, `firstname`, `password`, `powerLevel`) 
	VALUES 
	('Admin1', 'Admin1', 'password!', -1),
	('LesFerret', 'Emery', 'SecurePassword2!', 0),
	('Leo1', 'Leo', 'SecurePassword3!', 0),
	('Neil400', 'Neil', 'SecurePassword4!', 1),
	('Giann0', 'Gianno', 'SecurePassword5!', 2),
	('EwertA', 'Adam', 'SecurePassword6!', 0);

	SET FOREIGN_KEY_CHECKS=1;
	COMMIT;
END //

DELIMITER ;