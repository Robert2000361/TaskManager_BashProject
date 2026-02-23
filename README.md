# TaskManager_BashProject

# 🗂️ Bash Task Manager

A modular command-line Task Management System built using pure Bash scripting on **Ubuntu 24.04.4 LTS**.

This project demonstrates practical usage of core Linux and Bash concepts including:

- Functions
- Case statements
- Loops
- awk
- sed
- grep
- regex validation
- file handling
- structured data processing

---

# 📌 Project Overview

Bash Task Manager is a fully interactive CLI application that allows users to manage tasks efficiently through a structured menu-driven interface.

The system stores tasks in a delimiter-based text file and performs data manipulation using standard Unix utilities.

All features are modularized into separate scripts for maintainability and clarity.

---

# 🚀 Features

✔ Full CRUD Operations  
✔ Auto Increment Task ID  
✔ Regex-based Date Validation  
✔ Strict Input Validation  
✔ Colored Terminal Output  
✔ CSV Export  
✔ Reports (Summary / Overdue / Priority)  
✔ Search by Title (using awk only)  
✔ Modular Architecture  
✔ Robust Error Handling (Loop-based)  

---

# 🏗️ Project Architecture
            ┌────────────────────┐
            │  task_manager.sh   │
            │  (Main Controller) │
            └─────────┬──────────┘
                      │
    ┌─────────────────┼─────────────────┐
    │                 │                 │
    add_task.sh  update_task.sh  delete_task.sh
    list_task.sh search_task.sh  reports.sh
    export_csv.sh validation.sh  config.sh

    
## Architecture Explanation

- **task_manager.sh**  
  Controls the main menu and routes execution using `select` and `case`.

- **config.sh**  
  Defines shared variables (e.g., `FILE=tasks.txt`).

- **validation.sh**  
  Contains reusable validation functions for:
  - Title
  - Priority
  - Date
  - Status
  - ID existence

- Feature scripts (add, update, delete, search, reports, export)  
  Each handles one responsibility only.

---

# 🔄 Application Flow

Start Program
↓
Display Main Menu (select loop)
↓
User selects option
↓
Case statement routes to function
↓
Function validates input
↓
Process data (awk / sed / grep)
↓
Display formatted output
↓
Return to Main Menu


The script only terminates when the user explicitly selects **Exit**.

---

# 🗃️ Project Structure
add_task.sh
delete_task.sh
list_task.sh
update_task.sh
search_task.sh
reports.sh
export_csv.sh
validation.sh
config.sh
task_manager.sh
tasks.txt
tasks_export.csv
README.md


---

# ▶️ How to Run

Make sure you are on Ubuntu 24.04.4 LTS.

```bash
chmod +x *.sh
bash task_manager.sh

📄 Data Storage Format

tasks.txt
Delimiter used: |

Format:
ID|Title|Priority|DueDate|Status

Example:
1|Study Bash|high|2026-02-02|pending
2|Fix bug|medium|2026-02-05|done


🧪 Validation Rules
Title

Cannot be empty

Must contain at least one alphabetic character

Numbers-only titles are rejected

Priority

Allowed values only:

high

medium

low

Due Date

Format: YYYY-MM-DD

Validated using Regex

Verified using date -d

Unrealistic future dates rejected

Status

Allowed values:

pending

in-progress

done

ID

Must exist before update/delete

Auto-incremented



🔢 Auto Increment ID Logic

If file is empty:

ID = 1

Otherwise:

Last ID + 1

Handled using:

awk -F'|' 'END {print $1}'
🔍 Search Feature

Search is performed using:

awk -F'|' '$2 ~ "(^|[[:space:]])prefix"'

Searches ONLY in Title column

Case-insensitive

Matches words starting with prefix



📊 Reports
1️⃣ Summary Report

Counts tasks grouped by Status.

2️⃣ Overdue Report

Compares Due Date against current date using:

date +%s
3️⃣ Priority Grouped Report

Groups tasks by Priority level.

All reports use awk for field processing.

📤 CSV Export

Exports tasks into:

tasks_export.csv

Format:

ID,Title,Priority,Due Date,Status

After exporting, user can optionally display content in formatted table view.

🎨 Colored Output

ANSI escape codes are used to color:

Success messages (Green)

Errors (Red)

Section titles (Cyan)

Status-based row coloring (optional)

🛠️ Technical Concepts Used
Tool	Purpose
awk	Field processing & formatting
sed	In-place editing & deletion
grep	Searching & filtering
case	Menu routing
select	Interactive menu
loops	Input validation control
date	Date validation & comparison
file redirection	Data persistence



+------+--------------------------------+----------+------------+--------------+
| ID   | TITLE                          | PRIORITY | DUE DATE   | STATUS       |
+------+--------------------------------+----------+------------+--------------+
| 1    | Study Bash                     | high     | 2026-02-02 | pending      |
| 2    | Fix bug                        | medium   | 2026-02-05 | done         |
+------+--------------------------------+----------+------------+--------------+



📦 System Requirements

Ubuntu 24.04.4 LTS

Bash 5+

Standard GNU utilities

👤 Author

Developed as a practical Bash scripting project demonstrating modular design and Unix text-processing capabilities.

📜 License

This project is open-source and free to use for educational and personal purposes.