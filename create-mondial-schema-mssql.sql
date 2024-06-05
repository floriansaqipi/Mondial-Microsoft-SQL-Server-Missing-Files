SET ANSI_NULLS ON;
SET ANSI_PADDING ON;
SET ANSI_WARNINGS ON;
SET ARITHABORT ON;
SET CONCAT_NULL_YIELDS_NULL ON;
SET QUOTED_IDENTIFIER ON;
SET NUMERIC_ROUNDABORT OFF;

IF EXISTS (SELECT * FROM sys.databases WHERE name = 'Mondial')
BEGIN
    ALTER DATABASE Mondial SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE Mondial;
END

CREATE DATABASE Mondial;
GO

USE Mondial;
GO

CREATE TABLE country (
    Name VARCHAR(35) NOT NULL UNIQUE,
    Code VARCHAR(4) PRIMARY KEY,
    Capital VARCHAR(35),
    Province VARCHAR(35),
    Area FLOAT CHECK (Area >= 0),
    Population INT CHECK (Population >= 0)
);

CREATE TABLE city (
    Name VARCHAR(35),
    Country VARCHAR(4),
    Province VARCHAR(35),
    Population INT CHECK (Population >= 0),
    Longitude FLOAT CHECK (Longitude >= -180 AND Longitude <= 180),
    Latitude FLOAT CHECK (Latitude >= -90 AND Latitude <= 90),
    PRIMARY KEY (Name, Country, Province)
);

CREATE TABLE province (
    Name VARCHAR(35) NOT NULL,
    Country VARCHAR(4) NOT NULL,
    Population INT CHECK (Population >= 0),
    Area FLOAT CHECK (Area >= 0),
    Capital VARCHAR(35),
    CapProv VARCHAR(35),
    PRIMARY KEY (Name, Country)
);

CREATE TABLE economy (
    Country VARCHAR(4) PRIMARY KEY,
    GDP FLOAT CHECK (GDP >= 0),
    Agriculture FLOAT,
    Service FLOAT,
    Industry FLOAT,
    Inflation FLOAT
);

CREATE TABLE population (
    Country VARCHAR(4) PRIMARY KEY,
    Population_Growth FLOAT,
    Infant_Mortality FLOAT
);

CREATE TABLE politics (
    Country VARCHAR(4) PRIMARY KEY,
    Independence DATE,
    Dependent VARCHAR(4),
    Government VARCHAR(120)
);

CREATE TABLE language (
    Country VARCHAR(4),
    Name VARCHAR(50),
    Percentage FLOAT CHECK (Percentage > 0 AND Percentage <= 100),
    PRIMARY KEY (Name, Country)
);

CREATE TABLE religion (
    Country VARCHAR(4),
    Name VARCHAR(50),
    Percentage FLOAT CHECK (Percentage > 0 AND Percentage <= 100),
    PRIMARY KEY (Name, Country)
);

CREATE TABLE ethnicGroup (
    Country VARCHAR(4),
    Name VARCHAR(50),
    Percentage FLOAT CHECK (Percentage > 0 AND Percentage <= 100),
    PRIMARY KEY (Name, Country)
);

CREATE TABLE continent (
    Name VARCHAR(20) PRIMARY KEY,
    Area FLOAT CHECK (Area >= 0)
);

CREATE TABLE borders (
    Country1 VARCHAR(4),
    Country2 VARCHAR(4),
    Length FLOAT CHECK (Length > 0),
    PRIMARY KEY (Country1, Country2)
);

CREATE TABLE encompasses (
    Country VARCHAR(4) NOT NULL,
    Continent VARCHAR(20) NOT NULL,
    Percentage FLOAT CHECK (Percentage > 0 AND Percentage <= 100),
    PRIMARY KEY (Country, Continent)
);

CREATE TABLE organization (
    Abbreviation VARCHAR(12) PRIMARY KEY,
    Name VARCHAR(80) NOT NULL UNIQUE,
    City VARCHAR(35),
    Country VARCHAR(4),
    Province VARCHAR(35),
    Established DATE
);

CREATE TABLE isMember (
    Country VARCHAR(4),
    Organization VARCHAR(12),
    Type VARCHAR(35) DEFAULT 'member',
    PRIMARY KEY (Country, Organization)
);

CREATE TABLE mountain (
    Name VARCHAR(35) PRIMARY KEY,
    Mountains VARCHAR(35),
    Height FLOAT,
    Type VARCHAR(10),
    Longitude FLOAT CHECK (Longitude >= -180 AND Longitude <= 180),
    Latitude FLOAT CHECK (Latitude >= -90 AND Latitude <= 90)
);

CREATE TABLE desert (
    Name VARCHAR(35) PRIMARY KEY,
    Area FLOAT CHECK (Area >= 0),
    Longitude FLOAT CHECK (Longitude >= -180 AND Longitude <= 180),
    Latitude FLOAT CHECK (Latitude >= -90 AND Latitude <= 90)
);

CREATE TABLE island (
    Name VARCHAR(35) PRIMARY KEY,
    Islands VARCHAR(35),
    Area FLOAT CHECK (Area >= 0),
    Height FLOAT,
    Type VARCHAR(10),
    Longitude FLOAT CHECK (Longitude >= -180 AND Longitude <= 180),
    Latitude FLOAT CHECK (Latitude >= -90 AND Latitude <= 90)
);

CREATE TABLE lake (
    Name VARCHAR(35) PRIMARY KEY,
    Area FLOAT CHECK (Area >= 0),
    Depth FLOAT CHECK (Depth >= 0),
    Altitude FLOAT,
    Type VARCHAR(10),
    River VARCHAR(35),
    Longitude FLOAT CHECK (Longitude >= -180 AND Longitude <= 180),
    Latitude FLOAT CHECK (Latitude >= -90 AND Latitude <= 90)
);

CREATE TABLE sea (
    Name VARCHAR(35) PRIMARY KEY,
    Depth FLOAT CHECK (Depth >= 0)
);

CREATE TABLE river (
    Name VARCHAR(35) PRIMARY KEY,
    River VARCHAR(35),
    Lake VARCHAR(35),
    Sea VARCHAR(35),
    Length FLOAT CHECK (Length >= 0),
    SourceLongitude FLOAT CHECK (SourceLongitude >= -180 AND SourceLongitude <= 180),
    SourceLatitude FLOAT CHECK (SourceLatitude >= -90 AND SourceLatitude <= 90),
    Mountains VARCHAR(35),
    SourceAltitude FLOAT,
    EstuaryLongitude FLOAT CHECK (EstuaryLongitude >= -180 AND EstuaryLongitude <= 180),
    EstuaryLatitude FLOAT CHECK (EstuaryLatitude >= -90 AND EstuaryLatitude <= 90)
);

CREATE TABLE geo_mountain (
    Mountain VARCHAR(35),
    Country VARCHAR(4),
    Province VARCHAR(35),
    PRIMARY KEY (Province, Country, Mountain)
);

CREATE TABLE geo_desert (
    Desert VARCHAR(35),
    Country VARCHAR(4),
    Province VARCHAR(35),
    PRIMARY KEY (Province, Country, Desert)
);

CREATE TABLE geo_island (
    Island VARCHAR(35),
    Country VARCHAR(4),
    Province VARCHAR(35),
    PRIMARY KEY (Province, Country, Island)
);

CREATE TABLE geo_river (
    River VARCHAR(35),
    Country VARCHAR(4),
    Province VARCHAR(35),
    PRIMARY KEY (Province, Country, River)
);

CREATE TABLE geo_sea (
    Sea VARCHAR(35),
    Country VARCHAR(4),
    Province VARCHAR(35),
    PRIMARY KEY (Province, Country, Sea)
);

CREATE TABLE geo_lake (
    Lake VARCHAR(35),
    Country VARCHAR(4),
    Province VARCHAR(35),
    PRIMARY KEY (Province, Country, Lake)
);

CREATE TABLE geo_source (
    River VARCHAR(35),
    Country VARCHAR(4),
    Province VARCHAR(35),
    PRIMARY KEY (Province, Country, River)
);

CREATE TABLE geo_estuary (
    River VARCHAR(35),
    Country VARCHAR(4),
    Province VARCHAR(35),
    PRIMARY KEY (Province, Country, River)
);

CREATE TABLE mergesWith (
    Sea1 VARCHAR(35),
    Sea2 VARCHAR(35),
    PRIMARY KEY (Sea1, Sea2)
);

CREATE TABLE located (
    City VARCHAR(35),
    Province VARCHAR(35),
    Country VARCHAR(4),
    River VARCHAR(35),
    Lake VARCHAR(35),
    Sea VARCHAR(35)
);

CREATE TABLE locatedOn (
    City VARCHAR(35),
    Province VARCHAR(35),
    Country VARCHAR(4),
    Island VARCHAR(35),
    PRIMARY KEY (City, Province, Country, Island)
);

CREATE TABLE islandIn (
    Island VARCHAR(35),
    Sea VARCHAR(35),
    Lake VARCHAR(35),
    River VARCHAR(35)
);

CREATE TABLE mountainOnIsland (
    Mountain VARCHAR(35),
    Island VARCHAR(35),
    PRIMARY KEY (Mountain, Island)
);
