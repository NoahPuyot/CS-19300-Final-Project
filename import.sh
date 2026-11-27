#!/usr/bin/env bash

#This is for getting data about decks (CURRENTLY A DECK).

#Runs common.sh in import.sh in order for checks and other things to be ran before the actual code is ran.
source "$(dirname "${BASH_SOURCE[0]}")/lib/common.sh"

DECK_ID="$1"

# -s only shows the JSON when curl is ran; -r shows plaintext instead of quoted strings
curl -s "https://archidekt.com/api/decks/$DECK_ID/" | jq -r '.cards[].card.oracleCard.name'
