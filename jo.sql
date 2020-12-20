-- phpMyAdmin SQL Dump
-- version 4.9.5
-- https://www.phpmyadmin.net/
--
-- Hôte : localhost:8081
-- Généré le : Dim 20 déc. 2020 à 16:17
-- Version du serveur :  5.7.24
-- Version de PHP : 7.4.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `jo`
--

-- --------------------------------------------------------

--
-- Structure de la table `athletes`
--

CREATE TABLE `athletes` (
  `id_athlete` int(11) NOT NULL,
  `nom` varchar(255) NOT NULL,
  `sexe` char(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `athletes_epreuves`
--

CREATE TABLE `athletes_epreuves` (
  `id_athlete` int(11) NOT NULL,
  `id_epreuve` int(11) NOT NULL,
  `medaille` varchar(26) DEFAULT 'aucune',
  `age` int(11) NOT NULL,
  `poids` int(11) NOT NULL,
  `taille` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `athletes_sports`
--

CREATE TABLE `athletes_sports` (
  `id_athlete` int(11) NOT NULL,
  `id_sport` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `epreuves`
--

CREATE TABLE `epreuves` (
  `id_epreuve` int(11) NOT NULL,
  `id_sport` int(11) NOT NULL,
  `epreuve` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `epreuves_jeux`
--

CREATE TABLE `epreuves_jeux` (
  `id_epreuve` int(11) NOT NULL,
  `id_jeu` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `equipes`
--

CREATE TABLE `equipes` (
  `id_equipe` int(11) NOT NULL,
  `equipe` varchar(255) NOT NULL,
  `id_noc` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `equipes_athletes`
--

CREATE TABLE `equipes_athletes` (
  `id_equipe` int(11) DEFAULT NULL,
  `id_athlete` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `jeux`
--

CREATE TABLE `jeux` (
  `id_jeu` int(11) NOT NULL,
  `jeu` varchar(255) NOT NULL,
  `annee` smallint(6) NOT NULL,
  `saison` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `jeux_villes`
--

CREATE TABLE `jeux_villes` (
  `id_jeu` int(11) NOT NULL,
  `id_ville` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `nocs`
--

CREATE TABLE `nocs` (
  `id_noc` int(11) NOT NULL,
  `NOC` char(3) NOT NULL,
  `region` varchar(255) NOT NULL,
  `note` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `sports`
--

CREATE TABLE `sports` (
  `id_sport` int(11) NOT NULL,
  `sport` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `villes`
--

CREATE TABLE `villes` (
  `id_ville` int(11) NOT NULL,
  `ville` varchar(256) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `athletes`
--
ALTER TABLE `athletes`
  ADD PRIMARY KEY (`id_athlete`);

--
-- Index pour la table `athletes_epreuves`
--
ALTER TABLE `athletes_epreuves`
  ADD KEY `id_athlete` (`id_athlete`),
  ADD KEY `id_epreuve` (`id_epreuve`);

--
-- Index pour la table `athletes_sports`
--
ALTER TABLE `athletes_sports`
  ADD KEY `id_sport` (`id_sport`),
  ADD KEY `id_athlete` (`id_athlete`);

--
-- Index pour la table `epreuves`
--
ALTER TABLE `epreuves`
  ADD PRIMARY KEY (`id_epreuve`),
  ADD KEY `id_sport` (`id_sport`);

--
-- Index pour la table `epreuves_jeux`
--
ALTER TABLE `epreuves_jeux`
  ADD KEY `id_epreuve` (`id_epreuve`),
  ADD KEY `id_jeu` (`id_jeu`);

--
-- Index pour la table `equipes`
--
ALTER TABLE `equipes`
  ADD PRIMARY KEY (`id_equipe`);

--
-- Index pour la table `equipes_athletes`
--
ALTER TABLE `equipes_athletes`
  ADD KEY `id_equipe` (`id_equipe`),
  ADD KEY `id_athlete` (`id_athlete`);

--
-- Index pour la table `jeux`
--
ALTER TABLE `jeux`
  ADD PRIMARY KEY (`id_jeu`);

--
-- Index pour la table `nocs`
--
ALTER TABLE `nocs`
  ADD PRIMARY KEY (`id_noc`);

--
-- Index pour la table `sports`
--
ALTER TABLE `sports`
  ADD PRIMARY KEY (`id_sport`);

--
-- Index pour la table `villes`
--
ALTER TABLE `villes`
  ADD PRIMARY KEY (`id_ville`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `athletes`
--
ALTER TABLE `athletes`
  MODIFY `id_athlete` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `epreuves`
--
ALTER TABLE `epreuves`
  MODIFY `id_epreuve` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `equipes`
--
ALTER TABLE `equipes`
  MODIFY `id_equipe` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `jeux`
--
ALTER TABLE `jeux`
  MODIFY `id_jeu` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `nocs`
--
ALTER TABLE `nocs`
  MODIFY `id_noc` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `sports`
--
ALTER TABLE `sports`
  MODIFY `id_sport` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `villes`
--
ALTER TABLE `villes`
  MODIFY `id_ville` int(11) NOT NULL AUTO_INCREMENT;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `athletes_epreuves`
--
ALTER TABLE `athletes_epreuves`
  ADD CONSTRAINT `athletes_epreuves_ibfk_1` FOREIGN KEY (`id_athlete`) REFERENCES `athletes` (`id_athlete`),
  ADD CONSTRAINT `athletes_epreuves_ibfk_2` FOREIGN KEY (`id_epreuve`) REFERENCES `epreuves` (`id_epreuve`);

--
-- Contraintes pour la table `athletes_sports`
--
ALTER TABLE `athletes_sports`
  ADD CONSTRAINT `athletes_sports_ibfk_1` FOREIGN KEY (`id_sport`) REFERENCES `sports` (`id_sport`),
  ADD CONSTRAINT `athletes_sports_ibfk_2` FOREIGN KEY (`id_athlete`) REFERENCES `athletes` (`id_athlete`);

--
-- Contraintes pour la table `epreuves`
--
ALTER TABLE `epreuves`
  ADD CONSTRAINT `epreuves_ibfk_2` FOREIGN KEY (`id_sport`) REFERENCES `sports` (`id_sport`);

--
-- Contraintes pour la table `epreuves_jeux`
--
ALTER TABLE `epreuves_jeux`
  ADD CONSTRAINT `epreuves_jeux_ibfk_1` FOREIGN KEY (`id_epreuve`) REFERENCES `epreuves` (`id_epreuve`),
  ADD CONSTRAINT `epreuves_jeux_ibfk_2` FOREIGN KEY (`id_jeu`) REFERENCES `jeux` (`id_jeu`);

--
-- Contraintes pour la table `equipes_athletes`
--
ALTER TABLE `equipes_athletes`
  ADD CONSTRAINT `equipes_athletes_ibfk_1` FOREIGN KEY (`id_equipe`) REFERENCES `equipes` (`id_equipe`),
  ADD CONSTRAINT `equipes_athletes_ibfk_2` FOREIGN KEY (`id_athlete`) REFERENCES `athletes` (`id_athlete`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
