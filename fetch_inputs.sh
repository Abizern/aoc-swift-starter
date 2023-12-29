#!/usr/bin/env sh

# Fetches all the inputs from 2022 and puts them in the relevant directory with the correct name

for day in $(seq -w 1 25)
do
    year="2000"
    aocd "$year" "$day" >| Sources/Challenges/Inputs/day"$day".txt
    echo "Fetched input for $year day$day"
done
