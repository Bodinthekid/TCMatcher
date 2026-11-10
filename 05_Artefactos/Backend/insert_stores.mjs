import fs from 'fs/promises';
import path from 'path';
import mysql from 'mysql2/promise';
import dotenv from 'dotenv';

// Carrega as variáveis do ficheiro .env
dotenv.config();

const country = 'Portugal';
const jsonPath = path.join('./data_stores', `${country}_overpass_result.json`);

async function importarParaMySQL() {
  // Configuração da ligação ao MySQL utilizando o .env
  const connection = await mysql.createConnection({
    host: process.env.DB_HOST || 'localhost',
    user: process.env.DB_USER || 'root',
    password: process.env.DB_PASSWORD || '',
    database: process.env.DB_NAME || 'tcmatcher_db'
  });

  try {
    console.log('📖 A ler o ficheiro JSON gerado pelo Overpass...');
    const rawData = await fs.readFile(jsonPath, 'utf-8');
    const data = JSON.parse(rawData);

    const paisDoJson = data.country || country;
    const lojas = data.elements.filter(elem => elem.tags && elem.tags.name);

    console.log(`🔍 Encontradas ${lojas.length} lojas com nome para importar.`);

    const query = `
      INSERT INTO stores_map 
      (id, country, element_type, name, city, address, postal_code, phone, website, opening_hours, lat, lon)
      VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
      ON DUPLICATE KEY UPDATE
        name = VALUES(name),
        city = VALUES(city),
        address = VALUES(address),
        postal_code = VALUES(postal_code),
        phone = VALUES(phone),
        website = VALUES(website),
        opening_hours = VALUES(opening_hours),
        lat = VALUES(lat),
        lon = VALUES(lon)
    `;

    await connection.beginTransaction();

    let inseridas = 0;
    for (const elem of lojas) {
      const idStr = `${elem.type}/${elem.id}`;
      const tags = elem.tags;
      
      const lat = elem.lat || (elem.center && elem.center.lat);
      const lon = elem.lon || (elem.center && elem.center.lon);

      if (!lat || !lon) continue;

      const name = tags.name;
      const city = tags['addr:city'] || tags['addr:place'] || 'N/A';
      const address = `${tags['addr:street'] || ''} ${tags['addr:housenumber'] ? ', ' + tags['addr:housenumber'] : ''}`.trim() || 'N/A';
      const postalCode = tags['addr:postcode'] || 'N/A';
      const phone = tags.phone || tags['contact:phone'] || null;
      const website = tags.website || tags['contact:website'] || null;
      const openingHours = tags.opening_hours || null;

      await connection.execute(query, [
        idStr,
        paisDoJson,
        elem.type,
        name,
        city,
        address,
        postalCode,
        phone,
        website,
        openingHours,
        lat,
        lon
      ]);

      inseridas++;
    }

    await connection.commit();
    console.log(`✅ Sucesso! ${inseridas} lojas de ${paisDoJson} foram inseridas/atualizadas na tabela stores_map.`);

  } catch (error) {
    await connection.rollback();
    console.error('❌ Erro ao importar para o MySQL:', error.message);
  } finally {
    await connection.end();
  }
}

importarParaMySQL();