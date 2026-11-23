-- 1. Crear la base de datos
CREATE DATABASE IF NOT EXISTS grupo4_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE grupo4_db;

-- 2. Usuarios
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    role ENUM('admin', 'engineer', 'viewer') DEFAULT 'engineer',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 3. Pozos
CREATE TABLE IF NOT EXISTS wells (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    name VARCHAR(150) NOT NULL,
    location VARCHAR(255),
    depth_meters DECIMAL(8,2) NOT NULL,
    static_level_meters DECIMAL(8,2),
    dynamic_level_meters DECIMAL(8,2),
    diameter_inches DECIMAL(5,2),
    status ENUM('active', 'inactive', 'maintenance') DEFAULT 'active',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- 4. Equipos
CREATE TABLE IF NOT EXISTS equipment (
    id INT AUTO_INCREMENT PRIMARY KEY,
    brand VARCHAR(100) NOT NULL,
    model VARCHAR(100) NOT NULL,
    type ENUM('submersible', 'centrifugal', 'jet') NOT NULL,
    power_hp DECIMAL(6,2) NOT NULL,
    max_flow_lpm DECIMAL(8,2) NOT NULL,
    max_head_meters DECIMAL(8,2) NOT NULL,
    price_usd DECIMAL(10,2) NOT NULL,
    energy_consumption_kw DECIMAL(8,2)
);

-- 5. Simulaciones
CREATE TABLE IF NOT EXISTS simulations (
    id INT AUTO_INCREMENT PRIMARY KEY,
    well_id INT NOT NULL,
    equipment_id INT NOT NULL,
    user_id INT NOT NULL,
    flow_rate_lpm DECIMAL(8,2) NOT NULL,
    hours_per_day DECIMAL(5,2) DEFAULT 24.00,
    calculated_flow DECIMAL(8,2),
    total_dynamic_head DECIMAL(8,2),
    daily_energy_kwh DECIMAL(10,2),
    monthly_cost_usd DECIMAL(10,2),
    efficiency_percentage DECIMAL(5,2),
    simulation_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    notes TEXT,
    FOREIGN KEY (well_id) REFERENCES wells(id) ON DELETE CASCADE,
    FOREIGN KEY (equipment_id) REFERENCES equipment(id),
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- 6. Índices
CREATE INDEX idx_wells_user ON wells(user_id);
CREATE INDEX idx_simulations_well ON simulations(well_id);
CREATE INDEX idx_simulations_equipment ON simulations(equipment_id);
