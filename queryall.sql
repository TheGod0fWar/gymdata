-- Alle Übungen pro User (nach Datum sortiert)
SELECT
    n.vorname,
    GROUP_CONCAT(uebungen.uebung, '
') as uebungen
FROM nutzer n
JOIN (
    SELECT
        t.nutzer_id,
        t.datum || ' - ' || m.name || ' (' || t.gewicht_kg || 'kg, ' || t.saetze || ' Sätze)' as uebung
    FROM trainingssaetze t
    JOIN maschinen m ON m.maschine_id = t.maschine_id
    ORDER BY t.datum
) uebungen ON n.nutzer_id = uebungen.nutzer_id
GROUP BY n.nutzer_id
ORDER BY n.vorname;

-- Wählt alle Trainings und Übungen einzeln
SELECT n.vorname, t.datum, t.gewicht_kg, t.saetze, m.name, m.max_kg FROM nutzer as n 
JOIN trainingssaetze as t
ON t.nutzer_id = n.nutzer_id
JOIN maschinen as m
ON m.maschine_id = t.maschine_id;


