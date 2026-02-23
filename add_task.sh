#!/bin/bash

# add_task() {

# echo "===== Add Task ====="

# read -p "Title: " title
# validate_title "$title" || return

# read -p "Priority (high/medium/low): " priority
# validate_priority "$priority" || return

# read -p "Due Date (YYYY-MM-DD / today / tomorrow): " due
# validate_date "$due" || return
# due=$(normalize_date "$due")

# id=$(generate_id)

# echo "$id|$title|$priority|$due|pending" >> "$FILE"

# success "Task added successfully"
# }

# add_task() {
# while true; do
#     echo "===== Add Task ====="

#     # # Title validation
#     # while true; do
#     #     read -p "Enter Title: " title
#     #     [[ -z "$title" ]] && echo "❌ Title cannot be empty." || break
#     # done

#     # Title validation
# while true; do
#     read -p "Enter Title: " title
#     if [[ -z "$title" ]]; then
#         echo "❌ Title cannot be empty."
#     elif [[ ! "$title" =~ [a-zA-Z] ]]; then
#         echo "❌ Title must contain at least one letter, not numbers only."
#     else
#         break
#     fi
# done

#     # Priority validation
#     while true; do
#         read -p "Priority (high / medium / low): " priority
#         case $priority in
#             high|medium|low) break ;;
#             *) echo "❌ Invalid priority." ;;
#         esac
#     done

#     # Date validation
#     while true; do
#         read -p "Due Date (Example: 2026-02-02): " due

#         if [[ ! $due =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2}$ ]]; then
#             echo "❌ Invalid format."
#             continue
#         fi

#         date -d "$due" >/dev/null 2>&1 || { echo "❌ Invalid date."; continue; }

#         year=$(date -d "$due" +%Y)
#         [[ $year -gt 2100 ]] && { echo "❌ Date too far in future."; continue; }

#         break
#     done

#     id=$(date +%s)
#     echo "$id|$title|$priority|$due|pending" >> "$FILE"
#     echo "✅ Task added."

#     read -p "Add another task? (y/n): " again
#     [[ $again != y ]] && break
# done
# Date validation


# }



add_task() {

while true; do
    echo "===== Add Task ====="

    # =========================
    # Title validation
    # =========================
    while true; do
        read -p "Enter Title: " title

        if [[ -z "$title" ]]; then
            echo "❌ Title cannot be empty."
        elif [[ ! "$title" =~ [a-zA-Z] ]]; then
            echo "❌ Title must contain at least one letter, not numbers only."
        else
            break
        fi
    done

    # =========================
    # Priority validation
    # =========================
    while true; do
        read -p "Priority (high / medium / low): " priority
        case $priority in
            high|medium|low) break ;;
            *) echo "❌ Invalid priority." ;;
        esac
    done

    # =========================
    # Date validation
    # =========================
    while true; do
        read -p "Due Date (Example: 2026-02-02 or today/tomorrow/yesterday): " due

        # Normalize relative dates
        case "$due" in
            today)     due=$(date +%F) ;;
            tomorrow)  due=$(date -d "+1 day" +%F) ;;
            yesterday) due=$(date -d "-1 day" +%F) ;;
        esac

        # Regex format check
        if [[ ! $due =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2}$ ]]; then
            echo "❌ Invalid format."
            continue
        fi

        # Real date validation
        date -d "$due" >/dev/null 2>&1 || {
            echo "❌ Invalid calendar date."
            continue
        }

        # Prevent unrealistic future
        year=$(date -d "$due" +%Y)
        [[ $year -gt 2100 ]] && {
            echo "❌ Date too far in future."
            continue
        }

        break
    done

    # =========================
    # Generate incremental ID
    # =========================
    if [[ ! -s "$FILE" ]]; then
        id=1
    else
        last_id=$(awk -F'|' 'END {print $1}' "$FILE")
        id=$((last_id + 1))
    fi

    # =========================
    # Save task
    # =========================
    echo "$id|$title|$priority|$due|pending" >> "$FILE"

    echo "✅ Task added successfully."

    # =========================
    # Repeat option
    # =========================
    read -p "Add another task? (y/n): " again
    [[ $again != y ]] && break

done

}