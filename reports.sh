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
$5 != "done" {

cmd = "date -d \"" $4 "\" +%s"
cmd | getline d
close(cmd)

if (d != "" && d < t) {
printf "| %-4s | %-30s | %-8s | %-10s | %-12s |\n",$1,$2,$3,$4,$5
}

}
' "$FILE"

print_table_footer
}

# =========================
# Priority Grouped Report
# =========================
priority_report() {

validate_file_structure || return

echo "===== PRIORITY REPORT ====="

for p in high medium low; do
    echo
    echo "--- $p priority ---"
    print_table_header

    awk -F'|' -v pr="$p" '
    $3 == pr {
    printf "| %-4s | %-30s | %-8s | %-10s | %-12s |\n",$1,$2,$3,$4,$5
    }' "$FILE"

    print_table_footer
done

}