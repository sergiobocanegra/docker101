#!/bin/bash

# Configuracion Imagen/Build
NOMBRE_IMAGEN="backend-demo"
VERSION="0.0.1"

# Configuracion Ejecucion de los contenedores
BASE_PATH="/demo/serch"
MSJ_CONTENEDOR="Hola by SERCH!!!"
PUERTO_CONTENEDOR=80
## Contenedor 1
PUERTO_HOST1=2020
NOMBRE_CONTENEDOR1="backend-demo-desacoplado"
## Contenedor 1
PUERTO_HOST2=2021
NOMBRE_CONTENEDOR2="backend-demo-anclado"

# Creacion de la imagen
 echo "\nCreacion de la imagen\n" && \
docker build -t ${NOMBRE_IMAGEN}:${VERSION} . --build-arg ARG_VERSION_API=$VERSION && \
echo "\nEliminando contenedores previos\n" && \
docker rm -f backend-demo-desacoplado && \
 echo "\nEjecucion del contenedor 1: Desacoplado \n" && \
docker run -d \
    --rm \
    -e CUSTOM_PATH=$BASE_PATH \
    -e MENSAJE="${MSJ_CONTENEDOR}" \
    -p $PUERTO_HOST1:$PUERTO_CONTENEDOR \
    --name $NOMBRE_CONTENEDOR1 \
    ${NOMBRE_IMAGEN}:${VERSION} && \
echo "\nEjecucion del contenedor 2: Anclado a la terminal \n" && \
docker run -it \
    --rm \
    -e CUSTOM_PATH=$BASE_PATH \
    -e MENSAJE="${MSJ_CONTENEDOR}" \
    -p $PUERTO_HOST2:$PUERTO_CONTENEDOR \
    --name $NOMBRE_CONTENEDOR2 \
    ${NOMBRE_IMAGEN}:${VERSION};