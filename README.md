# CS-19300-Final-Project
Final project repo for CS 193

Project Overview: Ideally, will be a way for a user to input their commander and current cards within their deck for a commander deck. Then, will go through a bunch of decks and then give back cards that appear the most within decks pertaining to the commander.

Eisenhower Matrix:

DO: Get user input, download decklists for testing, then from those decklists and user input, return cards that appear in decks with the exact same cards and commander.

SCHEDULE: If no deck contains all cards the user inputted, go through all decks that contain atleast X amount of cards. Similarly, maybe decks with the same color identity as inputted 
commander and contains cards user inputted (or some of them for when necessary), it also becomes included in the count.

DELEGATE: curl and jq for JSON related things, uniq for counting amount of times cards appear for decks that are allowed and sort (maybe) for sorting through top results and then lesser results to the bottom.

DELETE: A full on website/webpage, Postgres.
