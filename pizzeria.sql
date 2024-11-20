-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : localhost
-- Généré le : mer. 20 nov. 2024 à 19:26
-- Version du serveur : 8.0.31
-- Version de PHP : 7.4.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `pizzeria`
--

-- --------------------------------------------------------

--
-- Structure de la table `clients`
--

CREATE TABLE `clients` (
  `id_client` int NOT NULL,
  `nom` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `telephone` varchar(15) COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `commandes`
--

CREATE TABLE `commandes` (
  `id` int NOT NULL,
  `client_id` int DEFAULT NULL,
  `sauce` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `croute` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `garniture1` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `garniture2` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `garniture3` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `garniture4` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `addresse` varchar(150) COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déclencheurs `commandes`
--
DELIMITER $$
CREATE TRIGGER `commande_livraison` AFTER INSERT ON `commandes` FOR EACH ROW BEGIN
	DECLARE client_nom VARCHAR(100);
    
    SET client_nom = (SELECT clients.nom FROM clients 
    INNER JOIN commandes ON clients.id_client = commandes.client_id
    WHERE commandes.id = NEW.id);
    
    INSERT INTO livraisons (commande_id, status, nom_client)
    VALUES (NEW.id, 'En attente', client_nom);
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `croutes`
--

CREATE TABLE `croutes` (
  `id_croute` int NOT NULL,
  `type_croute` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `croutes`
--

INSERT INTO `croutes` (`id_croute`, `type_croute`) VALUES
(1, 'Classique'),
(2, 'Mince'),
(3, 'Épaisse');

-- --------------------------------------------------------

--
-- Structure de la table `garnitures`
--

CREATE TABLE `garnitures` (
  `id_garniture` int NOT NULL,
  `type_garniture` varchar(50) COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `garnitures`
--

INSERT INTO `garnitures` (`id_garniture`, `type_garniture`) VALUES
(1, 'Aucune'),
(2, 'Pepperoni'),
(3, 'Champignons'),
(4, 'Oignons'),
(5, 'Poivrons'),
(6, 'Olives'),
(7, 'Anchois'),
(8, 'Bacon'),
(9, 'Poulet'),
(10, 'Maïs'),
(11, 'Fromage'),
(12, 'Piments forts');

-- --------------------------------------------------------

--
-- Structure de la table `livraisons`
--

CREATE TABLE `livraisons` (
  `id` int NOT NULL,
  `commande_id` int DEFAULT NULL,
  `status` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `nom_client` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `sauces`
--

CREATE TABLE `sauces` (
  `id_sauce` int NOT NULL,
  `type_sauce` varchar(50) COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `sauces`
--

INSERT INTO `sauces` (`id_sauce`, `type_sauce`) VALUES
(1, 'Tomate'),
(2, 'Spaghetti'),
(3, 'Alfredo');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `clients`
--
ALTER TABLE `clients`
  ADD PRIMARY KEY (`id_client`);

--
-- Index pour la table `commandes`
--
ALTER TABLE `commandes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `client_id` (`client_id`);

--
-- Index pour la table `croutes`
--
ALTER TABLE `croutes`
  ADD PRIMARY KEY (`id_croute`);

--
-- Index pour la table `garnitures`
--
ALTER TABLE `garnitures`
  ADD PRIMARY KEY (`id_garniture`);

--
-- Index pour la table `livraisons`
--
ALTER TABLE `livraisons`
  ADD PRIMARY KEY (`id`),
  ADD KEY `commande_id` (`commande_id`);

--
-- Index pour la table `sauces`
--
ALTER TABLE `sauces`
  ADD PRIMARY KEY (`id_sauce`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `clients`
--
ALTER TABLE `clients`
  MODIFY `id_client` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT pour la table `commandes`
--
ALTER TABLE `commandes`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT pour la table `croutes`
--
ALTER TABLE `croutes`
  MODIFY `id_croute` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `garnitures`
--
ALTER TABLE `garnitures`
  MODIFY `id_garniture` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT pour la table `livraisons`
--
ALTER TABLE `livraisons`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT pour la table `sauces`
--
ALTER TABLE `sauces`
  MODIFY `id_sauce` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `commandes`
--
ALTER TABLE `commandes`
  ADD CONSTRAINT `commandes_ibfk_1` FOREIGN KEY (`client_id`) REFERENCES `clients` (`id_client`);

--
-- Contraintes pour la table `livraisons`
--
ALTER TABLE `livraisons`
  ADD CONSTRAINT `livraisons_ibfk_1` FOREIGN KEY (`commande_id`) REFERENCES `commandes` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
