-- phpMyAdmin SQL Dump
-- version 4.6.4
-- https://www.phpmyadmin.net/
--
-- Client :  127.0.0.1
-- Généré le :  Mar 15 Décembre 2020 à 16:51
-- Version du serveur :  5.7.14
-- Version de PHP :  7.0.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données :  `jo`
--

-- --------------------------------------------------------

--
-- Structure de la table `athletes`
--

CREATE TABLE `athletes` (
  `id` int(8) UNSIGNED NOT NULL,
  `nom` varchar(255) NOT NULL,
  `sexe` char(1) NOT NULL,
  `age` tinyint(3) UNSIGNED NOT NULL,
  `taille` tinyint(3) UNSIGNED DEFAULT NULL,
  `poids` tinyint(3) UNSIGNED DEFAULT NULL,
  `equipe` varchar(255) NOT NULL,
  `NOC_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `ath_epr`
--

CREATE TABLE `ath_epr` (
  `id` int(11) UNSIGNED NOT NULL,
  `ath_id` int(8) UNSIGNED NOT NULL,
  `epr_id` int(10) UNSIGNED NOT NULL,
  `medaille` varchar(26) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `epreuves`
--

CREATE TABLE `epreuves` (
  `id` int(11) UNSIGNED NOT NULL,
  `sport` varchar(26) NOT NULL,
  `evenement` varchar(26) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `jeux`
--

CREATE TABLE `jeux` (
  `id` int(11) UNSIGNED NOT NULL,
  `jeu` varchar(26) NOT NULL,
  `an` year(4) NOT NULL,
  `saison` varchar(26) NOT NULL,
  `ville` varchar(26) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `nations`
--

CREATE TABLE `nations` (
  `id` int(11) UNSIGNED NOT NULL,
  `NOC` char(3) NOT NULL,
  `region` varchar(26) NOT NULL,
  `notes` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Index pour les tables exportées
--

--
-- Index pour la table `athletes`
--
ALTER TABLE `athletes`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nom` (`nom`),
  ADD KEY `fk_nation_ath` (`NOC_id`);

--
-- Index pour la table `ath_epr`
--
ALTER TABLE `ath_epr`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_ae_ath` (`ath_id`),
  ADD KEY `epr_id` (`epr_id`);

--
-- Index pour la table `epreuves`
--
ALTER TABLE `epreuves`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `jeux`
--
ALTER TABLE `jeux`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `nations`
--
ALTER TABLE `nations`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `NOC` (`NOC`);

--
-- AUTO_INCREMENT pour les tables exportées
--

--
-- AUTO_INCREMENT pour la table `athletes`
--
ALTER TABLE `athletes`
  MODIFY `id` int(8) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `ath_epr`
--
ALTER TABLE `ath_epr`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `epreuves`
--
ALTER TABLE `epreuves`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `jeux`
--
ALTER TABLE `jeux`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `nations`
--
ALTER TABLE `nations`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- Contraintes pour les tables exportées
--

--
-- Contraintes pour la table `athletes`
--
ALTER TABLE `athletes`
  ADD CONSTRAINT `fk_nation_ath` FOREIGN KEY (`NOC_id`) REFERENCES `nations` (`id`);

--
-- Contraintes pour la table `ath_epr`
--
ALTER TABLE `ath_epr`
  ADD CONSTRAINT `fk_ae_ath` FOREIGN KEY (`ath_id`) REFERENCES `athletes` (`id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
