
CREATE DATABASE construction_xpert;
USE construction_xpert;


CREATE TABLE projet (
                        id INT PRIMARY KEY AUTO_INCREMENT,
                        nom VARCHAR(100) NOT NULL,
                        description TEXT,
                        date_debut DATE NOT NULL,
                        date_fin DATE NOT NULL,
                        budget DECIMAL(15, 2) NOT NULL
);


CREATE TABLE tache (
                       id INT PRIMARY KEY AUTO_INCREMENT,
                       projet_id INT NOT NULL,
                       description TEXT NOT NULL,
                       date_debut DATE NOT NULL,
                       date_fin DATE NOT NULL,
                       FOREIGN KEY (projet_id) REFERENCES projet(id) ON DELETE CASCADE
);


CREATE TABLE ressource (
                           id INT PRIMARY KEY AUTO_INCREMENT,
                           nom VARCHAR(100) NOT NULL,
                           type VARCHAR(50) NOT NULL,
                           quantite INT NOT NULL,
                           info_fournisseur VARCHAR(255)
);


CREATE TABLE tache_ressource (
                                 tache_id INT NOT NULL,
                                 ressource_id INT NOT NULL,
                                 quantite_assignee INT NOT NULL,
                                 PRIMARY KEY (tache_id, ressource_id),
                                 FOREIGN KEY (tache_id) REFERENCES tache(id) ON DELETE CASCADE,
                                 FOREIGN KEY (ressource_id) REFERENCES ressource(id) ON DELETE CASCADE
);