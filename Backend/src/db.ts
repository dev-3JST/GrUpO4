-import mysql from 'mysql2/promise';
import 'dotenv/config';

export const pool = mysql.createPool({
  host: process.env.DB_HOST,
  user: process.env.DB_USER as string,         // <-- Agregado as string
  password: process.env.DB_PASSWORD as string, // <-- Agregado as string
  database: process.env.DB_NAME as string,     // <-- Agregado as string
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
