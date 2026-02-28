#!/bin/bash
echoblue() { echo -e "\033[0;34m$*\033[0m"; }; echogreen() { echo -e "\033[0;32m$*\033[0m"; }; echoyellow() { echo -e "\033[0;33m$*\033[0m"; }; echopurple() { echo -e "\033[0;35m$*\033[0m"; }
echored() { echo -e "\033[0;31m$*\033[0m"; }

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
        # echo "❌ Please enter a number."
        echo -e "\033[0;31m❌ Please enter a number.\033[0m"

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
        # *) echo "❌ Invalid choice." ;;
        *) echo -e "\033[0;31m❌ Invalid choice.\033[0m" ;;

    esac
done
}
show_menu

