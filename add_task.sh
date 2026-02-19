#!/bin/bash

add_task() {

echo -e "${CYAN}--- Add Task ---${NC}"

read -p "Title: " title
[ -z "$title" ] && echo "Empty title" && return

read -p "Priority (high/medium/low): " priority
validate_priority "$priority" || { echo "Invalid priority"; return; }

read -p "Due Date (YYYY-MM-DD / today / tomorrow): " due
validate_date "$due" || { echo "Invalid date"; return; }

due=$(normalize_date "$due")

id=$(generate_id)
echo "$id|$title|$priority|$due|pending" >> "$FILE"

echo -e "${GREEN}Task Added${NC}"
}
