SELECT n.vorname, t.datum, t.gewicht_kg, t.saetze, m.name, m.max_kg FROM nutzer as n 
JOIN trainingssaetze as t
ON t.nutzer_id = n.nutzer_id
JOIN maschinen as m
ON m.maschine_id = t.maschine_id;
