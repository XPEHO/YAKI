#!/bin/bash

# Variables to change depending of your configuration
DB_PASSWORD="dbpassword"
DB_USER="postgres"
DB_NAME="postgres"
CONTAINER_NAME="postgres-database"


CLEAR_ALL_DB="clear_dataBase.sql"
CREATE_YAKI_USER="create_yaki_user.sql"
CREATE_TABLES="create_tables.sql"
CREATE_TEST_DATA="starting_data_karate.sql"

#Clear database first
docker exec -i $CONTAINER_NAME //bin//bash -c "password=$DB_PASSWORD psql --username $DB_USER $DB_NAME" < ./$CLEAR_ALL_DB
echo '$DB_NAME DB cleared'
echo ''
echo ''

# create user if not exist
docker exec -i $CONTAINER_NAME //bin//bash -c "password=$DB_PASSWORD psql --username $DB_USER $DB_NAME" < ./$CREATE_YAKI_USER
echo '$DB_NAME DB user created'
echo ''
echo ''

# reCreate all if not exist tables
docker exec -i $CONTAINER_NAME //bin//bash -c "password=$DB_PASSWORD psql --username $DB_USER $DB_NAME" < ./$CREATE_TABLES
echo '$DB_NAME DB tables created'
echo ''
echo ''

# insert test Data. IF NOT NEEDED COMMENT : 
docker exec -i $CONTAINER_NAME //bin//bash -c "password=$DB_PASSWORD psql --username $DB_USER $DB_NAME" < ./$CREATE_TEST_DATA
echo '$DB_NAME DB test data inserted'

