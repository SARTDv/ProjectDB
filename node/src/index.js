const { Client } = require('pg');

const client = new Client({
  host: 'db', // El nombre del contenedor PostgreSQL
  user: 'user',
  password: 'password',
  database: 'mydatabase',
  port: 5432
});

client.connect()
  .then(() => console.log('Connected to PostgreSQL'))
  .catch(err => console.error('Connection error', err.stack));

// Tu lógica de la aplicación aquí

client.end();
