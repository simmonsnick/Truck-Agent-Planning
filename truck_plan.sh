#!/bin/bash

# Prompt user for input
read -p "Enter the Domain PDDL file: " DOMAIN
read -p "Enter the number of maps (0-10): " MAP_INDEX


ALL_MAPS=("p00_map.pddl" "p01_map.pddl" "p02_map.pddl" "p03_map.pddl" "p04_map.pddl" "p05_map.pddl" "p06_map.pddl" "p07_map.pddl" "p08_map.pddl" "p09_map.pddl" "p10_map.pddl")
CSV_FILE="compute_actions.csv"
LABEL_FILE=".test_count"
MAX_LINES=15

# map count input
if ! [[ "$MAP_INDEX" =~ ^[0-9]+$ ]] || [ "$MAP_INDEX" -lt 0 ] || [ "$MAP_INDEX" -gt 10 ]; then
    echo " Map index must be a number between 0 and 10."
    exit 1
fi

# Reset the test count and CSV if MAX_LINES exceeded
if [ -f "$CSV_FILE" ]; then
    TOTAL_LINES=$(wc -l < "$CSV_FILE")
    if [[ "$TOTAL_LINES" =~ ^[0-9]+$ ]] && [ "$TOTAL_LINES" -gt "$MAX_LINES" ]; then
        echo "CSV has more than $MAX_LINES lines."
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


# loop through the selected maps
for ((i=0; i<=MAP_INDEX; i++)); do
    PROBLEM="${ALL_MAPS[$i]}"

    echo "=============================="
    echo "A: $PROBLEM"
    echo "=============================="


    if [ ! -f "$PROBLEM" ]; then
        echo "Skipping $PROBLEM: File not found."
        continue
    fi

    ./fast-downward.py "$DOMAIN" "$PROBLEM" --search "lazy_greedy([ff()], preferred=[ff()])" > plan.txt

    if [ ! -f sas_plan ]; then
        echo "No plan generated for $PROBLEM"
        continue
    fi

    echo "Plan for $PROBLEM:"
    cat sas_plan
    echo ""

    python3 detect_anomalies.py plan.txt

    SCORE=$(python3 compute_actions.py sas_plan)

    echo "${PROBLEM%.pddl},$SCORE" >> "$CSV_FILE"
done
