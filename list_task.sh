#!/bin/bash

list_tasks() {

echo -e "${YELLOW}--- All Tasks ---${NC}"

printf "%-5s %-25s %-10s %-12s %-12s\n" "ID" "TITLE" "PRIORITY" "DUE" "STATUS"
echo "---------------------------------------------------------------------"

awk -F'|' '{
printf "%-5s %-25s %-10s %-12s %-12s\n",$1,$2,$3,$4,$5
}' "$FILE"

}
