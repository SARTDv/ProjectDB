# Usa una imagen base de Node.js
FROM node:14

# Establece el directorio de trabajo
WORKDIR /usr/src/app

# Copia los archivos package.json y package-lock.json
COPY package*.json ./

# Instala las dependencias
RUN npm install

# Copia el código fuente de la aplicación
COPY . .

# Copia el script wait-for-it.sh
COPY ../wait-for-it.sh .

# Asegúrate de que wait-for-it.sh sea ejecutable
RUN chmod +x wait-for-it.sh

# Expone el puerto en el que la aplicación se ejecutará
EXPOSE 3000

# Comando para ejecutar la aplicación, esperando a que la base de datos esté lista
CMD ["./wait-for-it.sh", "db:5432", "--timeout=60", "--", "node", "src/index.js"]
