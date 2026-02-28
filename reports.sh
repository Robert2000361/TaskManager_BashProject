#!/bin/bash

# =========================
# Task Summary Report
# =========================
summary_report() {

validate_file_structure || return

echo "===== TASK SUMMARY ====="

awk -F'|' '
{
count[$5]++
}
END {
printf "Pending      : %d\n", count["pending"]
printf "In-Progress  : %d\n", count["in-progress"]
printf "Done         : %d\n", count["done"]
}
' "$FILE"

echo
}

# =========================
# Overdue Tasks Report
# =========================
overdue_report() {

validate_file_structure || return

echo "===== OVERDUE TASKS ====="

print_table_header

today=$(date +%s)

awk -F'|' -v t="$today" '
BEGIN {
    red="\033[31m"
    yellow="\033[33m"
    blue="\033[34m"
    green="\033[32m"
    reset="\033[0m"
}

$5 != "done" {

    cmd = "date -d \"" $4 "\" +%s"
    cmd | getline d
    close(cmd)

    if (d != "" && d < t) {

        color = red   # overdue نخليها أحمر افتراضياً

        if ($5=="pending")      color=yellow
        else if ($5=="in-progress") color=blue
        else if ($5=="done")    color=green

        printf color "| %-4s | %-30s | %-8s | %-10s | %-12s |\n" reset,
               $1,$2,$3,$4,$5
    }
}
' "$FILE"

}

# =========================
# Priority Grouped Report
# =========================
priority_report() {

    validate_file_structure || return

    echo "===== PRIORITY REPORT ====="

    # تعريف ألوان
    red="\033[31m"
    yellow="\033[33m"
    green="\033[32m"
    blue="\033[34m"
    reset="\033[0m"

    for p in high medium low; do
        echo
        echo "--- $p priority ---"
        print_table_header

        awk -F'|' -v pr="$p" -v red="$red" -v yellow="$yellow" -v green="$green" -v blue="$blue" -v reset="$reset" '
        $3 == pr {
            color = green  # قيمة افتراضية

            if ($3=="high")      color=red
            else if ($3=="medium") color=yellow
            else if ($3=="low")    color=blue

            printf "%s| %-4s | %-30s | %-8s | %-10s | %-12s |%s\n", color, $1,$2,$3,$4,$5,reset
        }
        ' "$FILE"
    done

}

# =========================
# Reports Menu
# =========================
reports_menu() {
while true; do
    echo "===== Reports ====="
    echo "1) Summary Report"
    echo "2) Overdue Tasks"
    echo "3) Priority Report"
    echo "4) Back"
    read -p "Choose option: " choice

    case $choice in
        1) summary_report ;;
        2) overdue_report ;;
        3) priority_report ;;
        4) return ;;
        *) echo "❌ Invalid choice." ;;
    esac
done
}