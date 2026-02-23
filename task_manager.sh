#!/bin/bash

# ===== Load Environment =====
source config.sh
source ./export_csv.sh
source validation.sh
source add_task.sh
source list_task.sh
source update_task.sh
source delete_task.sh
source search_task.sh
source reports.sh

# ===== Menu =====
# PS3="Choose option: "

# while true; do

# echo "======================"
# echo "      TASK MANAGER"
# echo "======================"

# select opt in "Add" "List" "Update" "Delete" "Search" "Reports" "Exit"
# do
# case $REPLY in

# 1)
#     add_task
#     break
# ;;

# 2)
#     list_tasks
#     break
# ;;

# 3)
#     update_task
#     break
# ;;

# 4)
#     delete_task
#     break
# ;;

# 5)
#     search_task
#     break
# ;;

# 6)
#     select r in "Summary" "Overdue" "Priority" "Back"
#     do
#         case $REPLY in
#             1) summary_report ;;
#             2) overdue_report ;;
#             3) priority_report ;;
#             4) break ;;
#             *) echo "Invalid" ;;
#         esac
#     done
#     break
# ;;

# 7)
#     echo "Goodbye 👋"
#     exit 0
# ;;

# *)
#     echo "Invalid choice"
# ;;

# esac
# done
# done


show_menu() {
while true; do
    echo "===== Task Manager ====="
    echo "1) Add Task"
    echo "2) List Tasks"
    echo "3) Update Task"
    echo "4) Delete Task"
    echo "5) Search Task"
    echo "6) Reports"
    echo "7) Export to CSV"
    echo "8) Exit"
    read -p "Choose option: " choice

    if [[ -z "$choice" ]]; then
        echo "❌ Please enter a number."
        continue
    fi

    case $choice in
        1) add_task ;;
        2) list_tasks ;;
        3) update_task ;;
        4) delete_task ;;
        5) search_task ;;
        6) reports_menu ;;
        7) export_tasks_csv ;;
        8) exit 0 ;;
        *) echo "❌ Invalid choice." ;;
    esac
done
}
show_menu
