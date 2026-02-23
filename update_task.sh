#!/bin/bash

update_task() {

validate_file_structure || return

read -p "Enter ID: " id
validate_existing_id "$id" || return

# عرض التاسك المختارة أولاً
task=$(grep "^$id|" "$FILE")
echo "Selected Task:"
echo "$task"

while true; do
    echo
    echo "Which part do you want to update?"
    echo "1) Title"
    echo "2) Priority (high / medium / low)"
    echo "3) Due Date (Example: 2026-02-02)"
    echo "4) Status (pending / in-progress / done)"
    echo "5) Exit update"

    read -p "Choose option: " choice

    case $choice in

        1)
            read -p "New Title: " new_title
            validate_title "$new_title" || continue

            # استخراج باقي القيم الحالية
            priority=$(echo "$task" | cut -d'|' -f3)
            due=$(echo "$task" | cut -d'|' -f4)
            status=$(echo "$task" | cut -d'|' -f5)

            sed -i "s/^$id|.*/$id|$new_title|$priority|$due|$status/" "$FILE"
            field="Title"
            ;;

        2)
            read -p "Priority (high / medium / low): " new_priority
            validate_priority "$new_priority" || continue

            title=$(echo "$task" | cut -d'|' -f2)
            due=$(echo "$task" | cut -d'|' -f4)
            status=$(echo "$task" | cut -d'|' -f5)

            sed -i "s/^$id|.*/$id|$title|$new_priority|$due|$status/" "$FILE"
            field="Priority"
            ;;

        3)
            read -p "Due Date (Example: 2026-02-02): " new_due
            validate_date "$new_due" || continue
            new_due=$(normalize_date "$new_due")

            title=$(echo "$task" | cut -d'|' -f2)
            priority=$(echo "$task" | cut -d'|' -f3)
            status=$(echo "$task" | cut -d'|' -f5)

            sed -i "s/^$id|.*/$id|$title|$priority|$new_due|$status/" "$FILE"
            field="Due Date"
            ;;

        4)
            read -p "Status (pending / in-progress / done): " new_status
            validate_status "$new_status" || continue

            title=$(echo "$task" | cut -d'|' -f2)
            priority=$(echo "$task" | cut -d'|' -f3)
            due=$(echo "$task" | cut -d'|' -f4)

            sed -i "s/^$id|.*/$id|$title|$priority|$due|$new_status/" "$FILE"
            field="Status"
            ;;

        5)
            echo "Returning to main menu..."
            break
            ;;

        *)
            echo "Invalid option."
            continue
            ;;
    esac

    # تحديث نسخة التاسك بعد التعديل
    task=$(grep "^$id|" "$FILE")

    echo
    echo "Updated part: $field"
    echo "Updated Task:"
    echo "$task"

    echo
    read -p "Do you want to update another field? (y/n): " again
    [[ $again != y ]] && break

done

}