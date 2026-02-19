#!/bin/bash

FILE="tasks.txt"
DELIM="|"

# colors
RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
CYAN="\e[36m"
NC="\e[0m"

[ -f "$FILE" ] || touch "$FILE"
