#!/bin/bash

delete_task() {

read -p "Enter ID: " id
id_exists "$id" || { echo "ID not found"; return; }

read -p "Confirm delete (y/n): " c
[ "$c" != "y" ] && return

sed -i "/^$id|/d" "$FILE"
echo "Deleted"

}
