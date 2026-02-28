#!/bin/bash

add_task() {

while true; do
    echo "===== Add Task ====="


    # =========================
    # Title validation
    # =========================
    while true; do
        read -p "Enter Title: " title

    # إزالة المسافات من البداية والنهاية
        title=$(echo "$title" | xargs)

        if [[ -z "$title" ]]; then
            echo "❌ Title cannot be empty."

        elif [[ ! "$title" =~ ^[a-zA-Z0-9][a-zA-Z0-9\ -]*$ ]]; then
            echo "❌ Invalid title. Use letters, numbers, spaces or '-' only, and do not start with symbols."

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