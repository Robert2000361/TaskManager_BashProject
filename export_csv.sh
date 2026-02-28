#!/bin/bash

export_tasks_csv() {

# =========================
# Validate file existence
# =========================
if [[ ! -f "$FILE" ]]; then
    echo "❌ tasks.txt not found."
    return
fi

if [[ ! -s "$FILE" ]]; then
    echo "⚠ No tasks available to export."
    return
fi

output_file="tasks_export.csv"

# =========================
# Create CSV file
# =========================
echo "ID,Title,Priority,Due Date,Status" > "$output_file"

awk -F'|' '{
printf "%s,%s,%s,%s,%s\n",$1,$2,$3,$4,$5
}' "$FILE" >> "$output_file"

echo "✅ Tasks exported successfully to $output_file"

# =========================
# Ask user to display table
# =========================
while true; do
    read -p "Do you want to display exported tasks? (y/n): " answer

    case $answer in
        y|Y)

            # Print table header
            print_table_header

            # Print table content formatted
            awk -F',' 'NR>1 {
                printf "| %-4s | %-30s | %-8s | %-10s | %-12s |\n",
                $1,$2,$3,$4,$5
            }' "$output_file"

            # Print table footer

            break
            ;;
        n|N)
            break
            ;;
        *)
            echo "❌ Invalid choice. Please enter y or n."
            ;;
    esac
done

}