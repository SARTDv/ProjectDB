# Construir la imagen de PostgreSQL
docker build -t my_postgres ./db

# Construir la imagen de Node.js
docker build -t my_node_app ./node

# Ejecutar PostgreSQL
docker run -d `
  --name postgres_db `
  -e POSTGRES_USER=admin `
  -e POSTGRES_PASSWORD=1234 `
  -e POSTGRES_DB=datos `
  -v db_data:/var/lib/postgresql/data `
  -v ${PWD}/db/init.sql:/docker-entrypoint-initdb.d/init.sql `
  -p 5432:5432 `
  my_postgres


# Ejecutar Node.js
docker run -d `
  --name node `
  --link postgres_db:db `
  -v ${PWD}/node:/usr/src/app `
  -p 3000:3000 `
  my_node_app
