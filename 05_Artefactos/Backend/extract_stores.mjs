import fs from 'fs/promises';
import path from 'path';

const country = 'Portugal';
const pastaDestino = './data_stores';
const nomeFicheiro = `${country}_overpass_result.json`;

const caminhoCompleto = path.join(pastaDestino, nomeFicheiro);

const queryOverpass = `
  [out:json][timeout:70];
  area[name="${country}"]->.searchArea;
  (
    node["shop"="games"](area.searchArea);
    way["shop"="games"](area.searchArea);
    relation["shop"="games"](area.searchArea);
  );
  out body center;
`;

async function fetchEGuardarDados() {
  const url = 'https://overpass-api.de/api/interpreter';

  try {
    console.log('A consultar a API do Overpass...');
    
    const response = await fetch(url, {
      method: 'POST',
      headers: { 
        'Content-Type': 'application/x-www-form-urlencoded',
        // Adicionando um User-Agent para cumprir as políticas da API do Overpass
        'User-Agent': 'TCMatcherApp/1.0 (Contact: matheus@tcmatcher.local)' 
      },
      body: new URLSearchParams({ data: queryOverpass })
    });

    if (!response.ok) {
      throw new Error(`Erro na requisição: ${response.status} ${response.statusText}`);
    }

    const data = await response.json();

    // Garante que a pasta de destino existe
    await fs.mkdir(pastaDestino, { recursive: true });

    // Guarda o ficheiro no path especificado
    await fs.writeFile(caminhoCompleto, JSON.stringify(data, null, 2), 'utf-8');
    
    console.log(`Dados guardados com sucesso no path: ${path.resolve(caminhoCompleto)}`);

  } catch (error) {
    console.error('Erro ao extrair ou guardar os dados:', error.message);
  }
}

fetchEGuardarDados();