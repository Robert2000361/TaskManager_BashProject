#!/bin/bash

FILE="tasks.txt"
DELIM="|"

[ -f "$FILE" ] || touch "$FILE"

# ===============================
# Dynamic Table Engine + Coloring
# ===============================

TABLE_BUFFER="/tmp/task_table_buffer_$$"

print_table_header() {

    # Reset buffer
    : > "$TABLE_BUFFER"

    # Add header row (pipe format)
    echo "ID|TITLE|PRIORITY|DUE DATE|STATUS" >> "$TABLE_BUFFER"
    

        # Format dynamically then colorize
    column -t -s "$DELIM" "$TABLE_BUFFER" | while IFS= read -r line
    do
        case "$line" in
            *pending*)      echo -e "\e[33m$line\e[0m" ;;      # Yellow
            *in-progress*)  echo -e "\e[36m$line\e[0m" ;;      # Cyan
            *done*)         echo -e "\e[32m$line\e[0m" ;;      # Green
            *)              echo "$line" ;;                    # Header / others
        esac
    done

    rm -f "$TABLE_BUFFER"

}

print_table_footer() {
    :
}

# ===============================
# Helper to Add File Data to Table
# ===============================

print_table_body() {

    while IFS="$DELIM" read -r id title priority due status
    do
        echo "$id|$title|$priority|$due|$status" >> "$TABLE_BUFFER"
    done < "$FILE"

}