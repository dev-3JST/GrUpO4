import mysql from 'mysql2/promise';
import 'dotenv/config';

// Usamos valores por defecto con || para evitar errores de 'undefined' en TypeScript
export const pool = mysql.createPool({
  host: process.env.DB_HOST || 'localhost',
  user: process.env.DB_USER || 'grupo4_user',
  password: process.env.DB_PASSWORD || '',
  database: process.env.DB_NAME || 'grupo4_db',
  port: Number(process.env.DB_PORT) || 3306,
  waitForConnections: true,
  connectionLimit: 10,
  queueLimit: 0
});

export async function testConnection() {
  try {
    const [rows] = await pool.query('SELECT 1 + 1 AS result');
    console.log('✅ Conexión exitosa a MySQL (Base de Datos de Pozos)');
  } catch (error) {
    console.error('❌ Error de conexión a MySQL:', error);
  }
}
