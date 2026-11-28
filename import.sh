#!/usr/bin/env bash

#This is for getting data about decks (CURRENTLY A DECK).

#Runs common.sh in import.sh in order for checks and other things to be ran before the actual code is ran.
source "$(dirname "${BASH_SOURCE[0]}")/lib/common.sh"

# Now is a function to be used in recommend.sh

# -s only shows the JSON when curl is ran; -r shows plaintext instead of quoted strings
get_deck_cards() {
	curl -s "https://archidekt.com/api/decks/$1/" | jq -r '.cards[].card.oracleCard.name'
}

#Function to be used in recommend.sh; Gets deck ids (Up to some Max value) for a specified commander.
get_decks_ids() {
	#Parameters/fields for the function
	local commander="$1"
	local max="$2"

	#Sets multiple local variables up for later use.
	local encoded page=1 count=0 url response new_ids
	
	#Takes the commander variable (which is a string), passes it through jq and puts it under a temp
	#variable c. Then converts that string to be URL safe (FOR LATER USE)
	encoded=$(jq -rn --arg c "$commander" '$c | @uri')

	#Loop that goes through decks with specified commander as commander, and saves the ids. It does this by going
	#through each page and saves all the deck ids of that page, then continues page to page until max is reached.
	while [ "$count" -lt "$max" ]; do
		url="https://archidekt.com/api/decks/v3/?commanderName=$encoded&orderBy=-updatedAt&page=$page"
		
		#Attempts to get the page as a JSON and store it; if it fails automatically ends the loop (-f fails on
		#HTTP errors).
		response=$(curl -fs "$url") || break
		
		#Gets the ids from response. If result doesn't exist, then output is nothing instead of an error.
		new_ids=$(echo "$response" | jq -r '.results[]?.id')

		#-z tests whether a string is empty or not, if it is then auto breaks the loop
		#Used to check if there are no more decks left.
		[ -z "$new_ids" ] && break

		#How it "returns" the ids found
		echo "$new_ids"

		#Goes to next page, and increments loop
		#grep -c . attempts to match every line with a singular character. At a basic level, it pretty much
		#counts how many ids there are by counting how many lines have existing characters.
		count=$((count + $(echo "$new_ids" | grep -c .)))
		page=$((page + 1))
		sleep 0.5

	#head -n "$max" limits the gotten ids to max (As in the amount of ids per page, when loop is exited, might
	#surpass max, sends/saves only max amount of ids).
	done | head -n "$max"
}
