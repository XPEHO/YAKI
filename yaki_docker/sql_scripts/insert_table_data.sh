#!bin/bash

DB_PASSWORD="password"
DB_USER="postgres"
DB_NAME="postgres"
CONTAINER_NAME="yaki_docker-bdd-1"

CREATE_YAKI_USER="create_user.sql"
CREATE_TABLES="create_tables.sql"
CREATE_TEST_DATA="create_data.sql"

# create user if not exist
docker exec -i $CONTAINER_NAME /bin/bash -c "password=$DB_PASSWORD psql --username $DB_USER $DB_NAME" < ./$CREATE_YAKI_USER
echo '$DB_NAME DB user created'

# reCreate all if not exist tables
docker exec -i $CONTAINER_NAME /bin/bash -c "password=$DB_PASSWORD psql --username $DB_USER $DB_NAME" < ./$CREATE_TABLES
echo '$DB_NAME DB tables created'

# insert test Data. IF NOT NEEDED COMMENT : 
docker exec -i $CONTAINER_NAME /bin/bash -c "password=$DB_PASSWORD psql --username $DB_USER $DB_NAME" < ./$CREATE_TEST_DATA
echo '$DB_NAME DB test data inserted'


