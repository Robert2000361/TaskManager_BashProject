#!/bin/bash

delete_task() {

validate_file_structure || return

while true; do

    echo
    read -p "Enter ID to delete (or press Enter to return): " id

    # السماح بالرجوع للقائمة
    [[ -z "$id" ]] && break

    validate_existing_id "$id" || continue

    # عرض التاسك قبل الحذف
    task=$(grep "^$id|" "$FILE")
    echo "Selected Task:"
    echo "$task"

    read -p "Confirm delete (y/n): " confirm
    validate_confirmation "$confirm" || continue

    if [[ $confirm == "y" ]]; then
        sed -i "/^$id|/d" "$FILE"
        success "Task deleted successfully"
    else
        echo "Delete cancelled"
    fi

    echo
    read -p "Do you want to delete another task? (y/n): " again

    [[ $again != "y" ]] && break

done

}