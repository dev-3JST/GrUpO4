import { useEffect, useState } from 'react';

// Tu URL del Backend en Ubuntu A
const API_URL = 'http://10.86.89.185:3000/api';

interface Well {
  id: number;
  name: string;
  location: string;
  depth_meters: number;
  status: string;
}

interface Equipment {
  id: number;
  brand: string;
  model: string;
  price_usd: number;
}

function App() {
  const [wells, setWells] = useState<Well[]>([]);
  const [equipment, setEquipment] = useState<Equipment[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState('');

  useEffect(() => {
    const fetchData = async () => {
      try {
        const [wellsRes, equipRes] = await Promise.all([
          fetch(`${API_URL}/wells`),
          fetch(`${API_URL}/equipment`)
        ]);

        if (!wellsRes.ok || !equipRes.ok) {
          throw new Error('Error al obtener los datos del servidor');
        }

        const wellsData = await wellsRes.json();
        const equipData = await equipRes.json();

        setWells(wellsData);
        setEquipment(equipData);
      } catch (err) {
        console.error(err);
        setError('No se pudo conectar con el Backend. Verifica la IP y que el servidor esté corriendo.');
      } finally {
        setLoading(false);
      }
    };

    fetchData();
  }, []);

  if (loading) return <h2>Cargando datos de los pozos...</h2>;
  if (error) return <h2 style={{ color: 'red' }}>{error}</h2>;

  return (
    <div style={{ padding: '20px', fontFamily: 'Arial' }}>
      <h1>Simulador de Pozos de Agua - Grupo 4</h1>
      
      <h2>Pozos Registrados</h2>
      <table border={1} cellPadding={10} style={{ borderCollapse: 'collapse', marginBottom: '30px' }}>
        <thead>
          <tr style={{ backgroundColor: '#f0f0f0' }}>
            <th>ID</th>
            <th>Nombre</th>
            <th>Ubicación</th>
            <th>Profundidad (m)</th>
            <th>Estado</th>
          </tr>
        </thead>
        <tbody>
          {wells.map((well) => (
            <tr key={well.id}>
              <td>{well.id}</td>
              <td>{well.name}</td>
              <td>{well.location}</td>
              <td>{well.depth_meters}</td>
              <td>{well.status}</td>
            </tr>
          ))}
        </tbody>
      </table>

      <h2>Catálogo de Equipos (Bombas)</h2>
      <table border={1} cellPadding={10} style={{ borderCollapse: 'collapse' }}>
        <thead>
          <tr style={{ backgroundColor: '#f0f0f0' }}>
            <th>ID</th>
            <th>Marca</th>
            <th>Modelo</th>
            <th>Precio (USD)</th>
          </tr>
        </thead>
        <tbody>
          {equipment.map((eq) => (
            <tr key={eq.id}>
              <td>{eq.id}</td>
              <td>{eq.brand}</td>
              <td>{eq.model}</td>
              <td>${eq.price_usd}</td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
}

export default App;