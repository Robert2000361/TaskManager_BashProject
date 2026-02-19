#!/bin/bash

search_task() {

read -p "Keyword: " key

printf "%-5s %-25s %-10s %-12s %-12s\n" "ID" "TITLE" "PRIORITY" "DUE" "STATUS"

awk -F'|' -v k="$key" '
tolower($2) ~ tolower(k) {
printf "%-5s %-25s %-10s %-12s %-12s\n",$1,$2,$3,$4,$5
}' "$FILE"

}
