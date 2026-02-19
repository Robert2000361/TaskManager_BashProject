#!/bin/bash

update_task() {

read -p "Enter ID: " id
id_exists "$id" || { echo "ID not found"; return; }

read -p "New Title: " title
read -p "Priority: " priority
validate_priority "$priority" || { echo "Invalid priority"; return; }

read -p "Due Date: " due
validate_date "$due" || { echo "Invalid date"; return; }
due=$(normalize_date "$due")

read -p "Status (pending/in-progress/done): " status

sed -i "s/^$id|.*/$id|$title|$priority|$due|$status/" "$FILE"

echo "Updated"
}
