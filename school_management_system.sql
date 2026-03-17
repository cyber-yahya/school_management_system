create database school_management_system;
use school_management_system;

-- Create Stagiaire table
CREATE TABLE stagiaire (
    id_stg INT PRIMARY KEY AUTO_INCREMENT,
    nom_stg VARCHAR(50) NOT NULL,
    prenom_stg VARCHAR(50) NOT NULL,
    telephone_stg VARCHAR(15),
    login_stg VARCHAR(30) UNIQUE NOT NULL,
    mot_de_passe_stg VARCHAR(255) NOT NULL
);
-- Create Module table
CREATE TABLE module (
    id_module INT PRIMARY KEY AUTO_INCREMENT,
    nom_module VARCHAR(100) NOT NULL,
    type_module VARCHAR(50),
    masse_horraire_module INT NOT NULL
);

-- Create Examen table
CREATE TABLE examen (
    id_examen INT PRIMARY KEY AUTO_INCREMENT,
    type_examen VARCHAR(50) NOT NULL,
    date_examen DATE NOT NULL,
    salle_examen VARCHAR(20),
    id_module INT,
    FOREIGN KEY (id_module) REFERENCES module(id_module)
);

-- Create Notes table (junction table)
CREATE TABLE notes (
    id_stg INT,
    id_examen INT,
    note DECIMAL(4,2) CHECK (note >= 0 AND note <= 20),
    PRIMARY KEY (id_stg, id_examen),
    FOREIGN KEY (id_stg) REFERENCES stagiaire(id_stg),
    FOREIGN KEY (id_examen) REFERENCES examen(id_examen)
);



create table administrateur(
	login_admin varchar(50) unique not null,
    mot_de_passe_admin varchar(50) not null
);

insert into administrateur values
("yahyadakhir","yahyadakhir"),("mohammedrida","mohammedrida"),
("ali","ali"),("salma","salma"),("zineb","zineb"),("ayoub","ayoub");


-- Insertion des stagiaires marocains
INSERT INTO stagiaire (nom_stg, prenom_stg, telephone_stg, login_stg, mot_de_passe_stg) VALUES
('El Amrani', 'Karim', '0612345678', 'k.elamrani', 'Karim123'),
('Benjelloun', 'Fatima', '0623456789', 'f.benjelloun', 'Fatima2024'),
('Alaoui', 'Mehdi', '0634567890', 'm.alaoui', 'Mehdi@123'),
('Chraibi', 'Layla', '0645678901', 'l.chraibi', 'Layla789'),
('Bennis', 'Youssef', '0656789012', 'y.bennis', 'YoussefPass'),
('Zouhair', 'Nadia', '0667890123', 'n.zouhair', 'Nadia2024'),
('Idrissi', 'Hamza', '0678901234', 'h.idrissi', 'Hamza123'),
('Mourad', 'Amina', '0689012345', 'a.mourad', 'Amina789'),
('Rachidi', 'Omar', '0690123456', 'o.rachidi', 'OmarPass2024'),
('Tazi', 'Sara', '0601234567', 's.tazi', 'Sara@123'),
('Berrada', 'Khalid', '0619876543', 'k.berrada', 'Khalid789'),
('Lahlou', 'Salma', '0628765432', 's.lahlou', 'Salma2024'),
('Sbihi', 'Adil', '0637654321', 'a.sbihi', 'Adil123'),
('Cherkaoui', 'Hind', '0646543210', 'h.cherkaoui', 'Hind@789'),
('Fassi', 'Rachid', '0655432109', 'r.fassi', 'RachidPass');

-- Insertion des modules
INSERT INTO module (nom_module, type_module, masse_horraire_module) VALUES
('Développement Web Frontend', 'Pratique', 60),
('Base de Données MySQL', 'Mixte', 45),
('Programmation Java Avancée', 'Pratique', 70),
('Réseaux et Sécurité', 'Théorique', 50),
('Framework Laravel', 'Pratique', 65),
('Gestion de Projet Agile', 'Mixte', 40),
('Intelligence Artificielle', 'Théorique', 55),
('Mobile Development Flutter', 'Pratique', 60),
('Cloud Computing AWS', 'Mixte', 50),
('UX/UI Design', 'Pratique', 45),
('DevOps et CI/CD', 'Mixte', 55),
('Big Data et Analytics', 'Théorique', 60),
('Cybersécurité', 'Mixte', 50),
('Blockchain Basics', 'Théorique', 40),
('IoT et Embedded Systems', 'Pratique', 55);

-- Insertion des examens
INSERT INTO examen (type_examen, date_examen, salle_examen, id_module) VALUES
('Examen Final', '2024-06-15', 'Salle A101', 1),
('Projet Pratique', '2024-06-18', 'Labo B201', 2),
('Contrôle Continu', '2024-06-10', 'Salle C102', 3),
('QCM', '2024-06-12', 'Salle D103', 4),
('Soutenance', '2024-06-20', 'Salle E104', 5),
('Examen Écrit', '2024-06-22', 'Salle A101', 6),
('Projet de Fin', '2024-06-25', 'Labo B202', 7),
('Test Pratique', '2024-06-14', 'Labo C201', 8),
('Rattrapage', '2024-06-28', 'Salle F105', 1),
('Examen Final', '2024-06-16', 'Salle A102', 2),
('Contrôle', '2024-06-11', 'Salle C103', 3),
('QCM Avancé', '2024-06-13', 'Salle D104', 4),
('Soutenance Projet', '2024-06-21', 'Salle E105', 5),
('Examen Théorique', '2024-06-23', 'Salle A103', 6),
('Projet IoT', '2024-06-26', 'Labo B203', 7),
('Test Mobile', '2024-06-15', 'Labo C202', 8),
('Examen Cloud', '2024-06-17', 'Salle G106', 9),
('Projet Design', '2024-06-19', 'Salle H107', 10),
('Test DevOps', '2024-06-24', 'Labo D204', 11),
('Examen Big Data', '2024-06-27', 'Salle I108', 12);

-- Insertion des notes (notes entre 5 et 20)
INSERT INTO notes (id_stg, id_examen, note) VALUES
-- Stagiaire 1 (Karim El Amrani)
(1, 1, 16.50), (1, 2, 18.00), (1, 3, 14.75), (1, 4, 17.25),
(1, 5, 15.50), (1, 6, 16.00),

-- Stagiaire 2 (Fatima Benjelloun)
(2, 1, 18.25), (2, 2, 19.00), (2, 3, 16.50), (2, 4, 15.75),
(2, 7, 17.50), (2, 8, 18.25),

-- Stagiaire 3 (Mehdi Alaoui)
(3, 3, 14.00), (3, 4, 13.50), (3, 5, 16.25), (3, 6, 15.00),
(3, 9, 12.75), (3, 10, 14.50),

-- Stagiaire 4 (Layla Chraibi)
(4, 1, 19.25), (4, 2, 18.75), (4, 3, 19.00), (4, 4, 18.50),
(4, 11, 17.75), (4, 12, 19.25),

-- Stagiaire 5 (Youssef Bennis)
(5, 5, 15.25), (5, 6, 14.50), (5, 7, 16.00), (5, 8, 15.75),
(5, 13, 13.25), (5, 14, 14.00),

-- Stagiaire 6 (Nadia Zouhair)
(6, 1, 17.00), (6, 3, 18.25), (6, 5, 16.75), (6, 7, 17.50),
(6, 9, 15.25), (6, 11, 16.00),

-- Stagiaire 7 (Hamza Idrissi)
(7, 2, 12.50), (7, 4, 11.75), (7, 6, 13.00), (7, 8, 12.25),
(7, 10, 10.50), (7, 12, 11.00),

-- Stagiaire 8 (Amina Mourad)
(8, 3, 18.75), (8, 5, 19.50), (8, 7, 18.25), (8, 9, 17.75),
(8, 13, 19.00), (8, 15, 18.50),

-- Stagiaire 9 (Omar Rachidi)
(9, 4, 16.25), (9, 6, 15.50), (9, 8, 17.00), (9, 10, 16.75),
(9, 14, 15.25), (9, 16, 16.50),

-- Stagiaire 10 (Sara Tazi)
(10, 1, 14.50), (10, 3, 15.25), (10, 5, 13.75), (10, 7, 14.00),
(10, 9, 12.50), (10, 11, 13.25),

-- Stagiaire 11 (Khalid Berrada)
(11, 2, 17.75), (11, 4, 18.50), (11, 6, 16.25), (11, 8, 17.00),
(11, 12, 15.75), (11, 14, 16.50),

-- Stagiaire 12 (Salma Lahlou)
(12, 3, 19.75), (12, 5, 20.00), (12, 7, 19.25), (12, 9, 18.75),
(12, 13, 19.50), (12, 15, 20.00),

-- Stagiaire 13 (Adil Sbihi)
(13, 4, 11.25), (13, 6, 10.50), (13, 8, 12.00), (13, 10, 11.75),
(13, 14, 9.50), (13, 16, 10.25),

-- Stagiaire 14 (Hind Cherkaoui)
(14, 1, 16.00), (14, 2, 17.25), (14, 3, 15.50), (14, 4, 16.75),
(14, 5, 14.25), (14, 6, 15.00),

-- Stagiaire 15 (Rachid Fassi)
(15, 7, 18.50), (15, 8, 19.25), (15, 9, 17.75), (15, 10, 18.00),
(15, 11, 16.50), (15, 12, 17.25),

-- Notes supplémentaires pour couvrir tous les examens
(1, 13, 16.75), (2, 14, 17.00), (3, 15, 14.25),
(4, 16, 18.00), (5, 17, 15.50), (6, 18, 16.25),
(7, 19, 12.75), (8, 20, 19.00), (9, 17, 16.75),
(10, 18, 14.50), (11, 19, 17.25), (12, 20, 19.75),
(13, 17, 11.50), (14, 18, 15.75), (15, 19, 18.25);