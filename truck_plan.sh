#!/bin/bash

# Prompt user for input
read -p "Enter the Domain PDDL file: " DOMAIN
read -p "Enter the number of maps (1-10): " MAP_COUNT


ALL_MAPS=("p01_map.pddl" "p02_map.pddl" "p03_map.pddl" "p04_map.pddl" "p05_map.pddl" "p06_map.pddl" "p07_map.pddl" "p08_map.pddl" "p09_map.pddl" "p10_map.pddl")
CSV_FILE="compute_possibility.csv"
LABEL_FILE=".test_count"
MAX_LINES=15

# map count input
if ! [[ "$MAP_COUNT" =~ ^[0-9]+$ ]] || [ "$MAP_COUNT" -lt 1 ] || [ "$MAP_COUNT" -gt 10 ]; then
    echo " Map count must be a number between 1 and 10."
    exit 1
fi

# Reset the test count and CSV if MAX_LINES exceeded
if [ -f "$CSV_FILE" ]; then
    TOTAL_LINES=$(wc -l < "$CSV_FILE")
    if [[ "$TOTAL_LINES" =~ ^[0-9]+$ ]] && [ "$TOTAL_LINES" -gt "$MAX_LINES" ]; then
        echo "CSV has more than $MAX_LINES lines. Resetting..."
        > "$CSV_FILE"
        echo 1 > "$LABEL_FILE"
    fi
fi


# test count file
if [ ! -f "$LABEL_FILE" ]; then
    echo 1 > "$LABEL_FILE"
fi


# read the label file content
TEST_NUM=$(cat "$LABEL_FILE")
echo "===== Test $TEST_NUM  =====" >> "$CSV_FILE"

# save the next test number
NEXT_TEST=$((TEST_NUM + 1))
echo "$NEXT_TEST" > "$LABEL_FILE"

# check and keep only last MAX_LINES if CSV exists
#if [ -f "$CSV_FILE" ]; then
#    TOTAL_LINES=$(wc -l < "$CSV_FILE")
#    if [[ "$TOTAL_LINES" =~ ^[0-9]+$ ]] && [ "$TOTAL_LINES" -gt "$MAX_LINES" ]; then
#        tail -n "$MAX_LINES" "$CSV_FILE" > temp.csv && mv temp.csv "$CSV_FILE"
#    fi
#fi

# loop through the selected maps
for ((i=0; i<MAP_COUNT; i++)); do
    PROBLEM="${ALL_MAPS[$i]}"

    echo "=============================="
    echo "A: $PROBLEM"
    echo "=============================="

    if [ ! -f "$PROBLEM" ]; then
        echo "Skipping $PROBLEM: File not found."
        continue
    fi

    ./fast-downward.py "$DOMAIN" "$PROBLEM" --search "lazy_greedy([ff()], preferred=[ff()])" > planner_output.txt

    if [ ! -f sas_plan ]; then
        echo "No plan generated for $PROBLEM"
        continue
    fi

    echo "Plan for $PROBLEM:"
    cat sas_plan
    echo ""

    python3 detect_anomalies.py planner_output.txt results.csv

    SCORE=$(python3 compute_possibility.py sas_plan)

    echo "${PROBLEM%.pddl},$SCORE" >> "$CSV_FILE"
done

echo " Finished processing $MAP_COUNT map(s). Results are in $CSV_FILE"
