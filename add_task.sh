#!/bin/bash

add_task() {

while true; do
    echo "===== Add Task ====="


# =========================
# Title validation (Smart)
# =========================
while true; do
    read -p "Enter Title: " title

    # إزالة المسافات من البداية والنهاية
    title=$(echo "$title" | xargs)

    # 1️⃣ فارغ
    if [[ -z "$title" ]]; then
        echo "❌ Title cannot be empty or spaces only."
        echo "👉 Example: Study Bash"
        continue
    fi

    # 2️⃣ يبدأ برقم أو رمز
    if [[ ! "$title" =~ ^[a-zA-Z] ]]; then
        echo "❌ Title must start with a letter."
        echo "👉 Example: Fix bug"
        continue
    fi

    # 3️⃣ يحتوي رموز غير مسموح بها
    if [[ ! "$title" =~ ^[a-zA-Z0-9\ -]+$ ]]; then
        echo "❌ Title contains invalid characters."
        echo "👉 Allowed: letters, numbers, spaces, -"
        echo "👉 Example: Write report"
        continue
    fi

    # 4️⃣ أرقام فقط بعد الحرف (مثلاً A123 فقط)
    if [[ "$title" =~ ^[a-zA-Z]+[0-9]*$ ]] && [[ ! "$title" =~ [a-zA-Z]{2,} ]]; then
        echo "❌ Title should be meaningful, not just letters with numbers."
        echo "👉 Example: Task 1"
        continue
    fi

    break
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