#!/bin/bash

# Run the 'sensors' command and capture its output
sensors_output=$(sensors)

# Use grep to find the line containing "Tctl" and then use awk to extract the temperature value
tctl_temperature=$(echo "$sensors_output" | grep -A 0 "Tctl" | awk '{print $2}' | tr -d '+°C')

echo "$tctl_temperature"

