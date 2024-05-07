# YAKI local data base data

## How to create a postgres database with docker :

```
docker run --name postgres-database -e POSTGRES_PASSWORD=password -d -p 5432:5432 postgres
```

The POSTGRES_PASSWORD variable is the password for the postgres user. The -p 5432:5432 option maps the port 5432 of the container to the port 5432 of the host machine.

## how to use :

run

```
sh db_reset.sh
```

Terminal indicates the progress of the script:

- clear the entier yaki db
- create user if needed
- set all table
- set test data

Comment unwanted docker exec command in "sh db_reset.sh" script if a step isnt needed.
Replace variables in the script according to your own postgres docker configuration or .sql files names if changes.

## window user

with git bash use

```
sh db_reset_window.sh
```

## starting data karate :

replace the value of the variable "CREATE_TEST_DATA" in the script "sh db_reset.sh" with the path to the karate.sql file.
Thoses data are used for karate testing and have a database without data.
