#!/bin/bash

validate_priority() {
    [[ "$1" =~ ^(high|medium|low)$ ]]
}

# تحويل كلمات مثل today / tomorrow
normalize_date() {
    case "$1" in
        today) date +%F ;;
        tomorrow) date -d "+1 day" +%F ;;
        *) echo "$1" ;;
    esac
}

validate_date() {
    input=$(normalize_date "$1")

    # regex شكل التاريخ
    if [[ ! "$input" =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2}$ ]]; then
        return 1
    fi

    # تحقق منطقي بالتقويم
    date -d "$input" "+%F" >/dev/null 2>&1
}

id_exists() {
    grep -q "^$1|" "$FILE"
}

generate_id() {
    if [ ! -s "$FILE" ]; then echo 1; return; fi
    awk -F'|' 'END{print $1+1}' "$FILE"
}

