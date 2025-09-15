-- Seed data for excursions
INSERT INTO excursions (id, name, description, location, price, duration, max_participants)
VALUES
  (1, 'Catamaran Whale and Dolphin Watching', 'Boat trip along Tenerife''s west coast to spot dolphins and whales.', 'Costa Adeje, Los Cristianos, Playa de Las Américas, Los Gigantes, El Médano', 17.5, 3, 50),
  (2, 'Catamaran Trip to Los Gigantes', 'Boat tour to view the Los Gigantes Cliffs and whales.', 'Los Gigantes, Costa Adeje, Las Américas, Los Cristianos', 35, 4.5, 50),
  (3, 'VIP Luxury Catamaran Trip', 'Whale and dolphin watching from a luxury catamaran.', 'Puerto Colón', 62, 3, 12),
  (4, 'Luxury Catamaran Sunset Cruise', 'Sunset sailing with possible cetacean sightings.', 'Puerto Colón', 65, 3, 12),
  (5, 'Jeep Tour to La Gomera', 'Jeep route across La Gomera island with spectacular landscapes.', 'Puerto de la Cruz, Santa Ursula, Santa Cruz, Los Gigantes, Costa Adeje', 60, 10, 20),
  (6, 'Jeep Tour to Teide and Masca', 'Journey through Teide National Park and the picturesque village of Masca.', 'Las Américas, Los Cristianos', 27, 7, 20),
  (7, 'Bus Tour to Teide and Masca', 'Guided tour of two of Tenerife''s most emblematic locations.', 'Puerto de la Cruz, Santa Ursula, Santa Cruz, Los Gigantes, Costa Adeje', 55, 9, 50),
  (8, 'Teide Tour with Optional Cable Car', 'Visit to Teide National Park with optional cable car ride.', 'Los Gigantes, Costa Adeje, Las Américas, Los Cristianos', 87, 6, 50)
ON CONFLICT (id) DO NOTHING;

-- Align sequence
SELECT setval(pg_get_serial_sequence('excursions','id'), (SELECT MAX(id) FROM excursions));
