# moy.sh - Weighted Grade Calculator

## Overview

`moy.sh` is a shell script that calculates weighted grades from a CSV file. It extracts weightings from the first line of the file and then computes a weighted grade for each subsequent row based on the provided weight percentages. The results are output to a new CSV file called `notes.csv`.

## Features

- **Automatic Extraction of Weights:**  
  The first line of the CSV file contains weights enclosed in parentheses (e.g., `(20) (30) (50)`). The script extracts these values and uses them as weight percentages.

- **Grade Processing:**  
  For each student (each row after the first), the script extracts their grades, multiplies each grade by the corresponding weight, and computes a weighted sum.

- **Decimal Calculation:**  
  Uses `bc` for precise decimal arithmetic.

- **Output File:**  
  The resulting CSV file, `notes.csv`, contains the original data with an additional column for the computed weighted grade.

## Prerequisites

- A Unix-like environment (Linux, macOS, etc.)
- Shell (Bash or similar)
- `bc` utility for decimal calculations
- Standard Unix utilities (`head`, `sed`, `grep`, `awk`)

## Usage

1. **Prepare Your CSV File:**  
   Ensure your CSV file is formatted as follows:
   - The first line should contain weightings in parentheses, e.g.:
     ```
     (20) (30) (50)
     ```
   - Subsequent lines should contain comma-separated grades, e.g.:
     ```
     John Doe, 80, 90, 70
     Jane Smith, 85, 95, 75
     ```

2. **Run the Script:**
   Open your terminal and execute:
   ```sh
   ./moy.sh yourfile.csv
