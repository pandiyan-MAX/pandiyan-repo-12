#!/bin/bash

# ==============================================================================
# Script Name:  simple-interest.sh
# Description:  Calculates simple interest given principal, annual rate, and time.
#               Supports floating-point numbers, input validation, and logging.
# Author:       Dev / AI Collaborator
# Version:      2.0.0
# ==============================================================================

# --- Color Codes for Visual UI ---
CLEAR='\033[0m'
BOLD='\033[1m'
GREEN='\033[0;32m'
RED='\033[0;31m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'

# --- Banner Function ---
print_banner() {
    echo -e "${CYAN}==================================================${CLEAR}"
    echo -e "${BOLD}       🧮 ADVANCED SIMPLE INTEREST CALCULATOR      ${CLEAR}"
    echo -e "${CYAN}==================================================${CLEAR}"
}

# --- Validation Function ---
# Checks if the input is a valid positive integer or decimal float
validate_input() {
    local input=$1
    local name=$2
    
    # Regex to match positive numbers or decimals
    if [[ ! "$input" =~ ^[0-9]+(\.[0-9]+)?$ ]]; then
        echo -e "${RED}[ERROR] Invalid input for $name: '$input'. Please enter a positive number.${CLEAR}" >&2
        exit 1
    fi
}

# --- Main Execution Flow ---
clear
print_banner

# 1. Acquire and Validate Principal Amount
echo -e "${BOLD}1. Enter the Principal Amount (e.g., 10000 or 550.50):${CLEAR}"
read -p "👉 Principal ($): " principal
validate_input "$principal" "Principal"

echo ""

# 2. Acquire and Validate Interest Rate
echo -e "${BOLD}2. Enter the Annual Interest Rate in % (e.g., 5, 7.5):${CLEAR}"
read -p "👉 Rate (%): " rate
validate_input "$rate" "Interest Rate"

echo ""

# 3. Acquire and Validate Time Horizon
echo -e "${BOLD}3. Enter the Time Period in Years (e.g., 2, 3.5):${CLEAR}"
read -p "👉 Time (Years): " time
validate_input "$time" "Time Period"

echo -e "${CYAN}--------------------------------------------------${CLEAR}"
echo -e "${YELLOW}⚙️ Calculating financial metrics...${CLEAR}"

# --- Financial Computations using Bash bc engine ---
# Simple Interest Formula: SI = (P * T * R) / 100
simple_interest=$(echo "scale=2; ($principal * $rate * $time) / 100" | bc -l)

# Total Accrued Balance: A = P + SI
total_balance=$(echo "scale=2; $principal + $simple_interest" | bc -l)

# --- Display Output Summary ---
echo ""
echo -e "${GREEN}${BOLD}📊 FINANCIAL SUMMARY REPORT:${CLEAR}"
echo -e "--------------------------------------------------"
printf "  %-25s : $ %'.2f\n" "Initial Principal" "$principal"
printf "  %-25s : %s%%\n" "Annual Interest Rate" "$rate"
printf "  %-25s : %s Years\n" "Time Horizon" "$time"
echo -e "--------------------------------------------------"
printf "  ${BOLD}%-25s : $ %'.2f${CLEAR}\n" "Total Interest Earned" "$simple_interest"
printf "  ${GREEN}${BOLD}%-25s : $ %'.2f${CLEAR}\n" "Total Maturity Value" "$total_balance"
echo -e "${CYAN}==================================================${CLEAR}"
echo -e "${BOLD}Thank you for using the Simple Interest Calculator!${CLEAR}"
