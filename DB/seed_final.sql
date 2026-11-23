USE grupo4_db;

-- 1. Usuario (INSERT IGNORE evita el error si el correo ya existe)
INSERT IGNORE INTO users (id, name, email, password_hash, role) 
VALUES (1, 'Ing. Carlos Perez', 'carlos@pozos.com', 'hash_seguro_123', 'engineer');

-- 2. Pozos (Verificamos que no existan por nombre)
INSERT INTO wells (user_id, name, location, depth_meters, static_level_meters, dynamic_level_meters, diameter_inches, status)
SELECT 1, 'Pozo Norte-01', 'Sector Rural Norte, Km 12', 80.50, 15.20, 35.40, 6.00, 'active'
WHERE NOT EXISTS (SELECT 1 FROM wells WHERE name = 'Pozo Norte-01');

INSERT INTO wells (user_id, name, location, depth_meters, static_level_meters, dynamic_level_meters, diameter_inches, status)
SELECT 1, 'Pozo Sur-02', 'Finca La Esperanza', 120.00, 20.00, 45.00, 8.00, 'active'
WHERE NOT EXISTS (SELECT 1 FROM wells WHERE name = 'Pozo Sur-02');

-- 3. Equipos (Verificamos que no existan por marca y modelo)
INSERT INTO equipment (brand, model, type, power_hp, max_flow_lpm, max_head_meters, price_usd, energy_consumption_kw)
SELECT 'Grundfos', 'SP 5A-15', 'submersible', 2.50, 80.00, 95.00, 1250.00, 1.85
WHERE NOT EXISTS (SELECT 1 FROM equipment WHERE brand = 'Grundfos' AND model = 'SP 5A-15');

INSERT INTO equipment (brand, model, type, power_hp, max_flow_lpm, max_head_meters, price_usd, energy_consumption_kw)
SELECT 'Franklin', '4ST 3.0', 'submersible', 3.00, 95.00, 110.00, 1450.00, 2.20
WHERE NOT EXISTS (SELECT 1 FROM equipment WHERE brand = 'Franklin' AND model = '4ST 3.0');

INSERT INTO equipment (brand, model, type, power_hp, max_flow_lpm, max_head_meters, price_usd, energy_consumption_kw)
SELECT 'Pedrollo', '4SR 2.5', 'submersible', 2.00, 70.00, 80.00, 980.00, 1.50
WHERE NOT EXISTS (SELECT 1 FROM equipment WHERE brand = 'Pedrollo' AND model = '4SR 2.5');

-- 4. Simulacion (Insertamos sin tildes para evitar errores de sintaxis)
INSERT INTO simulations (
    well_id, equipment_id, user_id, flow_rate_lpm, hours_per_day, 
    calculated_flow, total_dynamic_head, daily_energy_kwh, monthly_cost_usd, efficiency_percentage, notes
) 
SELECT 1, 1, 1, 80.00, 12.00, 80.00, 85.50, 22.20, 66.60, 78.50, 'Simulacion inicial para el Pozo Norte. Equipo en punto optimo.'
WHERE NOT EXISTS (SELECT 1 FROM simulations WHERE notes LIKE 'Simulacion inicial%');
