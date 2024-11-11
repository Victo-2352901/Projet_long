DROP DATABASE pizzeria;
CREATE DATABASE pizzeria;
USE pizzeria;
-- 1. Créer la table 'clients'
CREATE TABLE clients (
    client_id INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(100),
    email VARCHAR(255) UNIQUE,
    adresse VARCHAR(255),
    telephone VARCHAR(20)
);

-- 2. Créer la table 'croutes'
CREATE TABLE croutes (
    croute_id INT AUTO_INCREMENT PRIMARY KEY,
    type VARCHAR(50)
);

-- 3. Créer la table 'sauces'
CREATE TABLE sauces (
    sauce_id INT AUTO_INCREMENT PRIMARY KEY,
    type VARCHAR(50)
);

-- 4. Créer la table 'commandes'
CREATE TABLE commandes (
    commande_id INT AUTO_INCREMENT PRIMARY KEY,
    client_id INT,
    FOREIGN KEY (client_id) REFERENCES clients(client_id)
);
-- 5. Créer la table 'pizzas'
CREATE TABLE pizzas (
    pizza_id INT AUTO_INCREMENT PRIMARY KEY,
    croute VARCHAR(50),
    sauce VARCHAR(50),
);

-- 6. Créer la table 'garnitures'
CREATE TABLE garnitures (
    garniture_id INT AUTO_INCREMENT PRIMARY KEY,
    type VARCHAR(50)
);

CREATE TABLE pizzas_garnitures (
    pizza_id INT,
    garniture_id INT,
    PRIMARY KEY (pizza_id, garniture_id),
    FOREIGN KEY (pizza_id) REFERENCES pizzas(pizza_id),
    FOREIGN KEY (garniture_id) REFERENCES garnitures(garniture_id)	
);
CREATE TABLE commandes_pizzas (
    commande_id INT,
    pizza_id INT,
    PRIMARY KEY (commande_id, pizza_id),
    FOREIGN KEY (commande_id) REFERENCES commandes(commande_id),
    FOREIGN KEY (pizza_id) REFERENCES pizzas(pizza_id)
);
