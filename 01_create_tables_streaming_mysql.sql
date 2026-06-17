-- ============================================================
-- Script de création des tables - Projet Streaming
-- Version MySQL
-- ============================================================

-- Création de la base de données
CREATE DATABASE IF NOT EXISTS streaming
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

USE streaming;

-- ============================================================
-- Suppression des tables si elles existent déjà
-- L'ordre est important : on supprime d'abord les tables enfants
-- ============================================================

DROP TABLE IF EXISTS visionnage;
DROP TABLE IF EXISTS film_acteur;
DROP TABLE IF EXISTS film_realisateur;
DROP TABLE IF EXISTS acteur;
DROP TABLE IF EXISTS realisateur;
DROP TABLE IF EXISTS utilisateur;
DROP TABLE IF EXISTS film;

-- ============================================================
-- Table film
-- ============================================================

CREATE TABLE IF NOT EXISTS film (
    film_id INT NOT NULL AUTO_INCREMENT,
    film_titre VARCHAR(150) NOT NULL,
    film_genre VARCHAR(80) NOT NULL,
    annee_sortie INT NOT NULL,
    PRIMARY KEY (film_id)
);

-- ============================================================
-- Table realisateur
-- ============================================================

CREATE TABLE IF NOT EXISTS realisateur (
    realisateur_id INT NOT NULL AUTO_INCREMENT,
    realisateur_nom VARCHAR(120) NOT NULL,
    realisateur_pays VARCHAR(80) NOT NULL,
    PRIMARY KEY (realisateur_id)
);

-- ============================================================
-- Table film_realisateur
-- Table d'association entre les films et les réalisateurs
-- ============================================================

CREATE TABLE IF NOT EXISTS film_realisateur (
    film_id INT NOT NULL,
    realisateur_id INT NOT NULL,
    PRIMARY KEY (film_id, realisateur_id),

    CONSTRAINT fk_film_realisateur_film
        FOREIGN KEY (film_id)
        REFERENCES film(film_id)
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,

    CONSTRAINT fk_film_realisateur_realisateur
        FOREIGN KEY (realisateur_id)
        REFERENCES realisateur(realisateur_id)
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

-- ============================================================
-- Table acteur
-- ============================================================

CREATE TABLE IF NOT EXISTS acteur (
    acteur_id INT NOT NULL AUTO_INCREMENT,
    acteur_nom VARCHAR(120) NOT NULL,
    PRIMARY KEY (acteur_id)
);

-- ============================================================
-- Table film_acteur
-- Table d'association entre les films et les acteurs
-- ============================================================

CREATE TABLE IF NOT EXISTS film_acteur (
    film_id INT NOT NULL,
    acteur_id INT NOT NULL,
    nom_personnage VARCHAR(120) NOT NULL,
    role_principal VARCHAR(10) NOT NULL,
    PRIMARY KEY (film_id, acteur_id),

    CONSTRAINT fk_film_acteur_film
        FOREIGN KEY (film_id)
        REFERENCES film(film_id)
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,

    CONSTRAINT fk_film_acteur_acteur
        FOREIGN KEY (acteur_id)
        REFERENCES acteur(acteur_id)
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

-- ============================================================
-- Table utilisateur
-- ============================================================

CREATE TABLE IF NOT EXISTS utilisateur (
    utilisateur_id INT NOT NULL AUTO_INCREMENT,
    utilisateur_nom VARCHAR(120) NOT NULL,
    utilisateur_email VARCHAR(150) NOT NULL UNIQUE,
    utilisateur_ville VARCHAR(100) NOT NULL,
    PRIMARY KEY (utilisateur_id)
);

-- ============================================================
-- Table visionnage
-- ============================================================

CREATE TABLE IF NOT EXISTS visionnage (
    visionnage_id INT NOT NULL AUTO_INCREMENT,
    film_id INT NOT NULL,
    utilisateur_id INT NOT NULL,
    date_visionnage DATE NOT NULL,
    support VARCHAR(50) NOT NULL,
    progression_pourcentage INT NOT NULL,
    note INT,
    PRIMARY KEY (visionnage_id),

    CONSTRAINT fk_visionnage_film
        FOREIGN KEY (film_id)
        REFERENCES film(film_id)
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,

    CONSTRAINT fk_visionnage_utilisateur
        FOREIGN KEY (utilisateur_id)
        REFERENCES utilisateur(utilisateur_id)
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

-- ============================================================
-- Vérification
-- ============================================================

SHOW TABLES;
