-- ============================================
-- Gym-Datenbank Prototyp
-- Wirtschaftsinfo - Datenbanken
-- ============================================

-- Tabellen erstellen
CREATE TABLE IF NOT EXISTS nutzer (
    nutzer_id INTEGER PRIMARY KEY AUTOINCREMENT,
    vorname TEXT NOT NULL,
    nachname TEXT NOT NULL,
    email TEXT UNIQUE
);

CREATE TABLE IF NOT EXISTS maschinen (
    maschine_id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    kategorie TEXT,
    max_kg INTEGER
);

CREATE TABLE IF NOT EXISTS trainingssaetze (
    satz_id INTEGER PRIMARY KEY AUTOINCREMENT,
    nutzer_id INTEGER NOT NULL,
    maschine_id INTEGER NOT NULL,
    gewicht_kg REAL NOT NULL,
    saetze INTEGER,
    datum DATE NOT NULL,
    FOREIGN KEY (nutzer_id) REFERENCES nutzer(nutzer_id),
    FOREIGN KEY (maschine_id) REFERENCES maschinen(maschine_id)
);

-- ============================================
-- TESTDATEN EINFÜGEN
-- ============================================

-- 10 Nutzer
INSERT INTO nutzer (vorname, nachname, email) VALUES
('Max', 'Mustermann', 'max@email.de'),
('Anna', 'Schmidt', 'anna@email.de'),
('Thomas', 'Müller', 'thomas@email.de'),
('Lisa', 'Weber', 'lisa@email.de'),
('Peter', 'Fischer', 'peter@email.de'),
('Julia', 'Schneider', 'julia@email.de'),
('Michael', 'Wagner', 'michael@email.de'),
('Sarah', 'Becker', 'sarah@email.de'),
('David', 'Schulz', 'david@email.de'),
('Laura', 'Hoffmann', 'laura@email.de');

-- 5 Maschinen
INSERT INTO maschinen (name, kategorie, max_kg) VALUES
('Beinpresse', 'Beine', 300),
('Bankdrücken', 'Oberkörper', 200),
('Latzug', 'Rücken', 150),
('Kreuzheben', 'Ganzkörper', 250),
('Bizeps-Curl', 'Arme', 50);

-- Trainingssätze (Wer hat wann was gemacht)
INSERT INTO trainingssaetze (nutzer_id, maschine_id, gewicht_kg, saetze, datum) VALUES
-- Max
(1, 1, 80, 3, '2025-03-10'), (1, 2, 40, 3, '2025-03-10'),
(1, 1, 85, 3, '2025-03-15'), (1, 5, 10, 3, '2025-03-15'),
-- Anna
(2, 2, 50, 3, '2025-03-08'), (2, 3, 40, 3, '2025-03-08'),
(2, 2, 55, 4, '2025-03-12'), (2, 4, 80, 3, '2025-03-12'), (2, 5, 12, 3, '2025-03-12'),
-- Thomas
(3, 1, 120, 4, '2025-03-05'), (3, 4, 100, 3, '2025-03-05'),
(3, 1, 140, 4, '2025-03-09'), (3, 4, 120, 3, '2025-03-09'), (3, 3, 60, 3, '2025-03-09'),
-- Lisa
(4, 2, 40, 3, '2025-03-11'), (4, 5, 12, 3, '2025-03-11'),
(4, 1, 140, 3, '2025-03-16'), (4, 3, 50, 3, '2025-03-16'), (4, 4, 90, 2, '2025-03-16'),
-- Peter
(5, 1, 100, 4, '2025-03-07'), (5, 4, 80, 3, '2025-03-07'),
(5, 2, 60, 4, '2025-03-14'), (5, 1, 160, 3, '2025-03-14'), (5, 3, 50, 4, '2025-03-14'),
-- Julia
(6, 3, 50, 3, '2025-03-06'), (6, 5, 14, 3, '2025-03-06'),
(6, 3, 60, 4, '2025-03-13'), (6, 2, 50, 3, '2025-03-13'), (6, 4, 100, 2, '2025-03-13'),
-- Michael
(7, 1, 120, 3, '2025-03-04'), (7, 2, 60, 3, '2025-03-04'),
(7, 4, 90, 3, '2025-03-18'), (7, 1, 160, 4, '2025-03-18'),
-- Sarah
(8, 5, 12, 3, '2025-03-03'), (8, 2, 50, 3, '2025-03-03'),
(8, 5, 14, 4, '2025-03-17'), (8, 4, 100, 3, '2025-03-17'), (8, 1, 160, 3, '2025-03-17'),
-- David
(9, 4, 60, 3, '2025-03-02'), (9, 3, 50, 3, '2025-03-02'),
(9, 1, 140, 3, '2025-03-19'), (9, 3, 70, 4, '2025-03-19'),
-- Laura
(10, 5, 8, 3, '2025-03-01'), (10, 2, 40, 3, '2025-03-01'),
(10, 1, 140, 3, '2025-03-20'), (10, 4, 80, 2, '2025-03-20');

-- ============================================
-- QUERIES ZUR ÜBERPRÜFUNG
-- ============================================

-- 1. Alle Nutzer anzeigen
SELECT * FROM nutzer;

-- 2. Alle Maschinen anzeigen
SELECT * FROM maschinen;

-- 3. Trainingseinheiten mit Namen (JOIN)
SELECT
    n.vorname || ' ' || n.nachname as Nutzer,
    m.name as Maschine,
    t.gewicht_kg || ' kg' as Gewicht,
    t.saetze || ' Sätze' as Saetze,
    t.datum
FROM trainingssaetze t
JOIN nutzer n ON t.nutzer_id = n.nutzer_id
JOIN maschinen m ON t.maschine_id = m.maschine_id
ORDER BY t.datum DESC;

-- 4. Persönliche Rekorde pro Maschine
SELECT
    n.vorname || ' ' || n.nachname as Nutzer,
    m.name as Maschine,
    MAX(t.gewicht_kg) as Rekord_kg
FROM trainingssaetze t
JOIN nutzer n ON t.nutzer_id = n.nutzer_id
JOIN maschinen m ON t.maschine_id = m.maschine_id
GROUP BY n.nutzer_id, m.maschine_id
ORDER BY m.name, Rekord_kg DESC;
