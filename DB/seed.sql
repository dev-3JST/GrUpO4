USE grupo4_db;

INSERT INTO users (name, email, password_hash, role) 
VALUES ('Ing. Carlos Pérez', 'carlos@pozos.com', 'hash_seguro_123', 'engineer');

INSERT INTO wells (user_id, name, location, depth_meters, static_level_meters, dynamic_level_meters, diameter_inches, status) 
VALUES 
(1, 'Pozo Norte-01', 'Sector Rural Norte, Km 12', 80.50, 15.20, 35.40, 6.00, 'active'),
(1, 'Pozo Sur-02', 'Finca La Esperanza', 120.00, 20.00, 45.00, 8.00, 'active');

INSERT INTO equipment (brand, model, type, power_hp, max_flow_lpm, max_head_meters, price_usd, energy_consumption_kw) 
VALUES 
('Grundfos', 'SP 5A-15', 'submersible', 2.50, 80.00, 95.00, 1250.00, 1.85),
('Franklin', '4ST 3.0', 'submersible', 3.00, 95.00, 110.00, 1450.00, 2.20),
('Pedrollo', '4SR 2.5', 'submersible', 2.00, 70.00, 80.00, 980.00, 1.50);

INSERT INTO simulations (
    well_id, equipment_id, user_id, flow_rate_lpm, hours_per_day, 
    calculated_flow, total_dynamic_head, daily_energy_kwh, monthly_cost_usd, efficiency_percentage, notes
) VALUES (
    1, 1, 1, 80.00, 12.00, 
    80.00, 85.50, 22.20, 66.60, 78.50, 
    'Simulacion inicial para el Pozo Norte. El equipo opera en su punto optimo.'
);.
