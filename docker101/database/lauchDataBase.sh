#!/bin/bash

# Datos Generales
DOCKER_IMAGEN="mariadb:10.9.3"
HOST="docker101"
MYSQL_ROOT_PASSWORD="prueba"
MYSQL_DATABASE="taskdb"
MYSQL_SOURCE_PATH="/var/lib/mysql"

# Datos del Volumen
VOLUMEN_NAME="taskdb-vol"
HOST_VOLUME_PATH="/a/b/c"

# Base de datos 01, BIND Volume == BV
BV_PUERTO=3039
BV_NOMBRE="dbtask_bv"

# Base de datos 02, DOCKER Volume == DV
DV_PUERTO=3040
DV_NOMBRE="dbtask_dv"

echo "\nCreacion del primer contenedor de BD: ${BV_NOMBRE}\n" && \
docker run -d \
    --name $BV_NOMBRE \
    -h $HOST \
    -e "MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD}" \
    -e "MYSQL_DATABASE=${MYSQL_DATABASE}" \
    -p $BV_PUERTO:3306 \
    -v $HOST_VOLUME_PATH:$MYSQL_SOURCE_PATH \
    $DOCKER_IMAGEN && \

echo "\nCreacion del Volumen-Docker: ${VOLUMEN_NAME}\n" && \
docker volume create $VOLUMEN_NAME && \

echo "\nCreacion del segundo contenedor de BD: ${DV_NOMBRE}\n" && \
docker run -d \
    --name $DV_NOMBRE \
    -h $HOST \
    -e "MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD}" \
    -e "MYSQL_DATABASE=${MYSQL_DATABASE}" \
    -p $DV_PUERTO:3306 \
    --mount source=$VOLUMEN_NAME,target=$MYSQL_SOURCE_PATH:rw \
    $DOCKER_IMAGEN;