#!/bin/bash

# This script refreshes french metropolitan public holiday data 
# from https://calendrier.api.gouv.fr/jours-feries/metropole.json
# This data is used to schedule notifications and exclude public holidays

if ! command -v curl &> /dev/null
then
    echo "the curl command could not be found"
    exit
fi

curl https://calendrier.api.gouv.fr/jours-feries/metropole.json > public_holidays.json