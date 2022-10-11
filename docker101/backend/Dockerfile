# Seleccion de la imagen
FROM python:3.10-rc-alpine

# Definicion de Argumentos
ARG ARG_VERSION_API="No Versionado!!!"

# Definicion de variables de entorno
ENV VERSION_API=$ARG_VERSION_API

# Creacion del area de trabajo
WORKDIR /app

# Ingesta del Souce code
COPY app/ .

# Instalacion de dependencias
RUN pip install -r requirements.txt

# Exposicion del puerto
EXPOSE 80

# Comando de iniciio
CMD ["python", "app.py"]