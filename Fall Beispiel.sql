SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

DROP DATABASE if exists ComputerVerkauf;
CREATE DATABASE if not exists ComputerVerkauf;
Use ComputerVerkauf;

DROP TABLE if exists `Abteilung`;
create TABLE `Abteilung` (
    `Abteilungs_ID`int NOT NULL,
    `Name` varchar(50) not null,
    `Leiter` int(50) not null
);
insert into `Abteilung` (`Abteilungs_ID`, `Name`) values
    (1, 'CEO' ),
    (2, 'Verkeufer'),
    (3, 'Logistiker'),
    (4, 'Liferant');

DROP TABLE if exists `Verkauf`;
CREATE TABLE `Verkauf` (
    `Verkauf_id` int(50) NOT NULL,
    `Kunde_ID` int(50) NOT NULL,
    `Produke_ID` int(50) NOT NULL
);
insert into `Verkauf` (`Verkauf_id`) values
    (1),
    (2),
    (3);

DROP table if exists `Produkte`;
CREATE TABLE `Produkte` (
    `Produkt_id` int(50) NOT NULL,
    `Name` varchar(50) NOT NULL,
    `Preis` decimal(15, 2) Not Null,
    `Lager_ID` int(50) Not Null
);
INSERT into `Produkte`(`Produkt_id`, `Name`,`Preis`) values
    (1, 'Pc 650', 899.95),
    (2, 'Pc 890XK', 1899.90),
    (3, 'Pc 730XK', 3890.65),
    (4, 'Pc 973XP', 3999.90);

Drop table if exists `Angestelt`;
CREATE TABLE `Angestelt` (
    `Mittarbeiter_ID` int(50) NOT NULL,
    `Name` varchar(50) NOT NULL,
    `Nachname` varchar(50) NOT NULL,

    `Lohn` decimal(15, 2) NOT NULL
);
INSERT INTO `Angestelt` (`Mittarbeiter_ID`,`Name`,`Nachname`,`Lohn`)values
    (1,'Max','Musterman', 50000),
    (2, 'Alex','Müller', 7000),
    (3, 'Leon','Peter', 6000),
    (4, 'Paul','Günter', 5000);

DROP TABLE if exists `Kunde`;
create table `Kunde` (
    `Kunde_ID` int(50) NOT NULL ,
    `Username` varchar(50) NOT NULL ,
    `Name` varchar(50) NOT NULL ,
    `Nachname`  varchar(50) NOT NULL ,
    `Email` varchar(50) NOT NULL ,
    `Passwort` varchar(50) NOT NULL ,
    `Adresse` varchar(50) NOT NULL ,
    `Zahlungsinformationen` varchar(50) NOT NULL
);
INSERT INTO `Kunde`(`Kunde_ID`,`Username`,`Name`,`Nachname`,`Email`,`Passwort`,`Adresse`, `Zahlungsinformationen`) values
    (1,'LuckyStrike','Fritz','Muster','fritz@muster.com','q3cLyO1G','Zürich','Kreditkarte'),
    (2,'H@ck0r','Hans','Jakob','hans.j@example.com','Xj5Tf7d4','Buchs','Twint'),
    (3, 'FreeZah','Anna','Anna Fries','anfri@example.com','9x6EwsiQ','Tessin','Rechnung'),
    (4, '2TheMAXX','Max','Max Beispiel','mabei@example.com','IeTAYydr','Soloturn','Kreditkarte');

DROP table if exists `Lager`;
create table `lager`(
    `Lager_ID` int(50) NOT NULL,
    `verfügbarkeit` int(50) NOT NULL,
    `Produkt_ID` int(50) NOT NULL
);
insert into `lager`(`Lager_ID`,`verfügbarkeit`) values
    (1,5),
    (2,6),
    (3,3),
    (4,4);

DROP TABLE if exists `Lieferung`;
create table `Lieferung`(
    `Adresse` varchar(50) NOT NULL,
    `verkaufs_ID` int(50) NOT NULL,
    `Kunde_ID` int(50) NOT NULL
);


ALTER table `Abteilung`
    add PRIMARY KEY (`Abteilungs_ID`),
    add key `fk_Leiter_Mittarbeiter_ID` (`Leiter`);

Alter TABLE `Verkauf`
    add Primary Key (`Verkauf_id`),
    add key `fk_Kunde_ID_Kunde_ID` (`Kunde_ID`),
    add key `fk_Produkt_ID_Produkt_ID` (`Produke_ID`);

Alter table `Produkte`
    add primary key (`Produkt_id`),
    add key `fk_Lager_ID_Lager_ID` (`Lager_ID`);

Alter table `Angestelt`
    add primary key (`Mittarbeiter_ID`);

Alter table `Kunde`
    add primary key (`Kunde_ID`),
    add key `fk_Adresse_Adresse` (`Adresse`);

Alter table `lager`
    add primary key (`Lager_ID`),
    add key `fk_produkt_ID_Produkt_ID_2` (`Produkt_ID`);

Alter table `Lieferung`
    add primary key (`Adresse`),
    add key `fk_Verkaufs_ID_Verkauf_ID` (`verkaufs_ID`),
    add key `fk_Kunden_ID_Kunden_ID` (`Kunde_ID`);
SET FOREIGN_KEY_CHECKS=0;

    Alter table `Abteilung`
        ADD CONSTRAINT `fk_Leiter_Mittarbeiter_ID` FOREIGN KEY (`Leiter`) REFERENCES `Angestelt` (`Mittarbeiter_ID`);

Alter table `Verkauf`
    add CONSTRAINT `fk_Kunde_ID_Kunde_ID` FOREIGN KEY (`Kunde_ID`) REFERENCES `Kunde` (`Kunde_ID`),
    add CONSTRAINT `fk_Produkt_ID_Produkt_ID` FOREIGN KEY (`Produke_ID`) REFERENCES  `Produkte` (`Produkt_id`);

ALTER table `Produkte`
    add CONSTRAINT `fk_Lager_ID_Lager_ID` FOREIGN KEY (`Lager_ID`) REFERENCES `lager` (`Lager_ID`);

Alter table `lager`
    add CONSTRAINT `fk_produkt_ID_Produkt_ID_2` FOREIGN KEY  (`Produkt_ID`) REFERENCES `Produkte` (`Produkt_id`);

Alter table `Kunde`
    add CONSTRAINT `fk_Adresse_Adresse` FOREIGN KEY (`Adresse`) REFERENCES `Lieferung` (`Adresse`);

Alter table `Lieferung`
    add CONSTRAINT `fk_Verkaufs_ID_Verkauf_ID` FOREIGN KEY (`verkaufs_ID`) REFERENCES `Verkauf` (`Verkauf_id`),
    add CONSTRAINT `fk_Kunden_ID_Kunden_ID` FOREIGN KEY (`Kunde_ID`) REFERENCES `Kunde` (`Kunde_ID`);
SET FOREIGN_KEY_CHECKS=1;

Drop role if exists 'ceo'@'localhost';
CREATE ROLE 'ceo'@'localhost';
GRANT all on ComputerVerkauf.* to 'ceo'@'localhost';

Drop USER if exists 'Max'@'localhost';
CREATE USER 'Max'@'localhost' IDENTIFIED BY '1234';
GRANT 'ceo'@'localhost' to 'Max'@'localhost';

Drop role if exists 'verkauf'@'localhost';
CREATE role 'verkauf'@'localhost';
GRANT SELECT, INSERT, DELETE, UPDATE ON ComputerVerkauf.Verkauf TO 'verkauf'@'localhost';

Drop USER if exists 'Alex'@'localhost';
CREATE USER 'Alex'@'localhost' IDENTIFIED by '1234';
 GRANT 'verkauf'@'localhost' to 'Alex'@'localhost';

Drop role if exists 'Logistik'@'localhost';
create ROLE 'Logistik'@'localhost';
GRANT SELECT, INSERT, DELETE, UPDATE ON ComputerVerkauf.Lager TO 'Logistik'@'localhost';

Drop USER if exists 'Leon'@'localhost';
CREATE USER 'Leon'@'localhost' IDENTIFIED by '1234';
GRANT 'Logistik'@'localhost' to 'Leon'@'localhost';

Drop role if exists 'it'@'localhost';
CREATE role 'it'@'localhost';
grant all on ComputerVerkauf.* to 'it'@'localhost';

Drop USER if exists 'Alexander'@'localhost';
CREATE user 'Alexander'@'localhost';
Grant 'it'@'Localhost' to 'Alexander'@'localhost';

SET DEFAULT ROLE ALL
to
'Max'@'localhost',
'Alex'@'localhost',
'Leon'@'localhost',
'Alexander'@'localhost';