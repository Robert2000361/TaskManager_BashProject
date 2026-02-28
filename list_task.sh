#!/bin/bash

list_tasks() {

validate_file_structure || return

print_table_header

awk -F'|' '
BEGIN {
    yellow="\033[33m"
    green="\033[32m"
    blue="\033[34m"
    reset="\033[0m"
}

{
    color=reset

    if ($5=="pending")      color=yellow
    else if ($5=="in-progress") color=blue
    else if ($5=="done")    color=green

    printf color "| %-4s | %-30s | %-8s | %-10s | %-12s |\n" reset,
           $1,$2,$3,$4,$5
}
' "$FILE"

#print_table_footer
}