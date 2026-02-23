#!/bin/bash

search_task() {

validate_file_structure || return

while true; do
    echo
    read -p "Enter title prefix (or press Enter to return): " word

    [[ -z "$word" ]] && { echo "Returning to main menu..."; break; }

    word=$(echo "$word" | xargs)

    if [[ -z "$word" ]]; then
        echo "❌ Invalid input."
        continue
    fi

    echo
    echo "===== SEARCH RESULTS ====="

    found=$(awk -F'|' -v w="$word" '
    BEGIN {IGNORECASE=1}
    $2 ~ "(^|[[:space:]])" w
    ' "$FILE")

    if [[ -z "$found" ]]; then
        echo "No matching tasks found."
    else
        print_table_header
        echo "$found" | awk -F'|' '{printf "| %-4s | %-30s | %-8s | %-10s | %-12s |\n",$1,$2,$3,$4,$5}'
        print_table_footer
    fi

    echo
    read -p "Do you want to search again? (y/n): " again
    [[ $again != y ]] && break

done

}