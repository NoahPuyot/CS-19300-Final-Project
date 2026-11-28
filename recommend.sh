#!/usr/bin/env bash
#What will go through decks, then find cards that are in all decks that contain cards and the commander a user inputs.

#Runs common.sh and import.sh in this script (RIGHT NOW USEFUL FOR GAINING ACCESS TO import.sh FUNCTIONS)
source "$(dirname "${BASH_SOURCE[0]}")/lib/common.sh"
source "$(dirname "${BASH_SOURCE[0]}")/import.sh"

#Can set other max values for fun!
max=50

#Fixed Commander (FOR NOW)
ids=$(get_decks_ids "Krenko, Mob Boss" "$max")

#Same trick as before, prints id's to be counted by grep -c . to see how many ids there actually are.
#|| true runs if no deck is found (If grep -c . found zero lines it would instead see it as a success instead of an
#error, resulting in count being 0).
count=$(echo -n "$ids" | grep -c . || true)

#Prints how many decks were found and the ids for the deck.
echo "Found $count decks for Krenko, Mob Boss:"
echo "$ids"
