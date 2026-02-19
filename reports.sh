#!/bin/bash

summary_report() {
echo "Tasks per status:"
awk -F'|' '{count[$5]++} END{for (s in count) print s,count[s]}' "$FILE"
}

overdue_report() {
today=$(date +%s)
awk -F'|' -v t="$today" '
$5!="done" {
cmd="date -d "$4" +%s"
cmd | getline d
close(cmd)
if(d<t) print $0
}' "$FILE"
}

priority_report() {
awk -F'|' '{print $3":",$0}' "$FILE" | sort
}
