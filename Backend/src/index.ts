import express from 'express';
import cors from 'cors';
import 'dotenv/config';
import { testConnection, pool } from './db.js';

const app = express();
const PORT = process.env.PORT || 3000;

// Middlewares
app.use(cors());
app.use(express.json());

// Probar conexión al iniciar
testConnection();

// RUTA: Obtener todos los pozos
app.get('/api/wells', async (req, res) => {
  try {
    const [rows] = await pool.query('SELECT * FROM wells');
    res.json(rows);
  } catch (error) {
    console.error('Error en /api/wells:', error);
    res.status(500).json({ error: 'Error al obtener los pozos' });
  }
});

// RUTA: Obtener equipos
app.get('/api/equipment', async (req, res) => {
  try {
    const [rows] = await pool.query('SELECT * FROM equipment');
    res.json(rows);
  } catch (error) {
    console.error('Error en /api/equipment:', error);
    res.status(500).json({ error: 'Error al obtener los equipos' });
  }
});

// RUTA raíz para verificar que el servidor vive
app.get('/', (req, res) => {
  res.send('Backend de Pozos funcionando. Prueba /api/wells');
});

// Iniciar el servidor
app.listen(PORT, () => {
  console.log(`🚀 Backend corriendo en http://localhost:${PORT}`);
});
