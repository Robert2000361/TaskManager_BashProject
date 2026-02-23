#!/bin/bash

# =========================
#  General Helpers
# =========================

error() {
    echo -e "\e[31m[ERROR] $1\e[0m"
}

success() {
    echo -e "\e[32m$1\e[0m"
}

# =========================
#  Title Validation
# =========================

validate_title() {

    local title="$1"

    # empty
    [[ -z "$title" ]] && { error "Title cannot be empty"; return 1; }

    # leading or trailing spaces
    [[ "$title" =~ ^[[:space:]] || "$title" =~ [[:space:]]$ ]] && {
        error "Title cannot start or end with space"
        return 1
    }

    # delimiter check
    [[ "$title" == *"|"* ]] && {
        error "Title cannot contain |"
        return 1
    }

    # length
    if [ ${#title} -gt 100 ]; then
        error "Title too long (max 100 chars)"
        return 1
    fi

    return 0
}

# =========================
# Priority Validation
# =========================

validate_priority() {
    [[ "$1" =~ ^(high|medium|low)$ ]] || {
        error "Priority must be high, medium, or low"
        return 1
    }
}

# =========================
# Status Validation
# =========================

validate_status() {
    [[ "$1" =~ ^(pending|in-progress|done)$ ]] || {
        error "Status must be pending, in-progress, or done"
        return 1
    }
}

# =========================
# Date Normalization
# =========================

normalize_date() {
    case "$1" in
        today) date +%F ;;
        tomorrow) date -d "+1 day" +%F ;;
        yesterday) date -d "-1 day" +%F ;;
        *) echo "$1" ;;
    esac
}

# =========================
# Date Validation (Regex + Logic)
# =========================

validate_date() {

    local input=$(normalize_date "$1")

    # regex format
    if [[ ! "$input" =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2}$ ]]; then
        error "Date format must be YYYY-MM-DD"
        return 1
    fi

    # logical calendar validation
    if ! date -d "$input" "+%F" >/dev/null 2>&1; then
        error "Invalid calendar date"
        return 1
    fi

    return 0
}

# =========================
# ID Validation
# =========================

validate_id_format() {
    [[ "$1" =~ ^[0-9]+$ ]] || {
        error "ID must be numeric"
        return 1
    }
}

id_exists() {
    grep -q "^$1|" "$FILE"
}

validate_existing_id() {

    validate_id_format "$1" || return 1

    id_exists "$1" || {
        error "ID does not exist"
        return 1
    }

    return 0
}

# =========================
# Confirmation Validation
# =========================

validate_confirmation() {
    [[ "$1" =~ ^(y|Y|yes|YES)$ ]]
}

# =========================
# Search Validation
# =========================

validate_keyword() {
    [[ -z "$1" ]] && {
        error "Search keyword cannot be empty"
        return 1
    }
}

# =========================
# File Integrity Check
# =========================

validate_file_structure() {

    # check if file empty
    [ ! -s "$FILE" ] && {
        error "No tasks found"
        return 1
    }

    # check column count
    awk -F'|' 'NF!=5 {print "Corrupted line:", NR}' "$FILE" | grep -q .
    if [ $? -eq 0 ]; then
        error "Data file corrupted"
        return 1
    fi

    return 0
}

# =========================
# Generate ID
# =========================

generate_id() {
    if [ ! -s "$FILE" ]; then
        echo 1
    else
        awk -F'|' 'END{print $1+1}' "$FILE"
    fi
}