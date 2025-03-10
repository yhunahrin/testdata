CREATE TABLE Customer (
/*utiliser primary key pour unique id*/
id_customer VARCHAR(50) PRIMARY KEY,
name VARCHAR(50) NOT NULL,
email VARCHAR(50) NOT NULL,
/* Vrifier la condition de l’ID qui satisfait les critres suivants :
- les 2 premiers caractres sont des lettres,
- le 3 me caractre est un tiret (-)
- les caractres restants sont des chiffres.*/
CONSTRAINT check_id_customer CHECK (id_customer ~ '^[a-zA-Z][a-zA-Z]-[0-9]*$')
);
CREATE TABLE Matter (
id INT PRIMARY KEY,
name VARCHAR(50) NOT NULL
);
CREATE TABLE Color (
id INT PRIMARY KEY,
name VARCHAR(50) NOT NULL,
id_matter INT,
/*La couleur dpend des matriaux .*/
FOREIGN KEY(id_matter) REFERENCES Matter(id)
);
CREATE TABLE Dimension (
id INT PRIMARY KEY,
length FLOAT NOT NULL,
height FLOAT NOT NULL,
width FLOAT NOT NULL,
/* Vrifier que la dimension ne dpasse pas 1 mtre.*/
CONSTRAINT check_max_dimension CHECK (length*height*width*0.001 <= 1)
  );
/*les discounts sont diffrents selon nombre bote et prix*/
CREATE TABLE Action_discount (
id INT PRIMARY KEY,
nb_box INT NOT NULL,
price float NOT NULL,
discount_rate FLOAT NOT NULL
);
/*Chaque bote aura des matriaux, des couleurs, des dimensions et des prixs diffrents.*/
CREATE TABLE Box (
id_box VARCHAR(50) PRIMARY KEY,
id_matter INT,
id_color INT,
id_dimension INT,
price FLOAT NOT NULL,
id_discount INT,
FOREIGN KEY(id_matter) REFERENCES Matter(id),
FOREIGN KEY(id_color) REFERENCES Color(id),
FOREIGN KEY(id_dimension) REFERENCES Dimension(id),
FOREIGN KEY(id_discount) REFERENCES Action_discount(id)
);
/*Cette classe est utilise pour les dtails de la commande avec les botes*/
CREATE TABLE Order_box (
id_order_box VARCHAR(50) PRIMARY KEY,
id_box VARCHAR(50),
id_discount INT,
nb_box INT NOT NULL,
price FLOAT NOT NULL,
FOREIGN KEY(id_box) REFERENCES Box(id_box),
FOREIGN KEY(id_discount) REFERENCES Action_discount(id)
);
/*le client passe les commandes.*/
CREATE TABLE Order_(
id_order VARCHAR(50) PRIMARY KEY,
  id_order_box VARCHAR(50),
id_customer VARCHAR(50),
total_price FLOAT NOT NULL,
FOREIGN KEY(id_order_box) REFERENCES Order_box(id_order_box),
FOREIGN KEY(id_customer ) REFERENCES Customer(id_customer )
);