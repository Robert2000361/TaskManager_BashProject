#!/bin/bash

source config.sh
source validation.sh
source add_task.sh
source list_task.sh
source update_task.sh
source delete_task.sh
source search_task.sh
source reports.sh

PS3="Choose option: "

while true; do
echo -e "${CYAN}
========================
     TASK MANAGER
========================
${NC}"

select opt in "Add" "List" "Update" "Delete" "Search" "Reports" "Exit"
do
case $REPLY in
1) add_task ; break ;;
2) list_tasks ; break ;;
3) update_task ; break ;;
4) delete_task ; break ;;
5) search_task ; break ;;
6)
   select r in "Summary" "Overdue" "Priority" "Back"
   do
     case $REPLY in
       1) summary_report ;;
       2) overdue_report ;;
       3) priority_report ;;
       4) break ;;
     esac
   done
   break ;;
7) exit 0 ;;
*) echo "Invalid" ;;
esac
done
done
