# TOP_OUTPUT="$(top -b -n 1 -o %MEM | sed -n -e 7,20p > ~/top_output.json)"
#!/bin/bash

# NOTE: This requires nice top config to be usable, make sure to have limited amount of columns

# TOP_OUTPUT="$(top -b -n 1 -o %MEM | sed -n -e 7,20p > ~/top_output)"
# TOP_OUTPUT="$(top -b -n 1 -w 70 -o %MEM | sed -n -e 7,20p | column -t -R 1,2,3,4 > ~/top_output)"
TOP_OUTPUT="$(top -b -n 1 -w 70 -o %MEM | sed -n -e 7,20p > ~/top_output)"
# Need to write to file to make the management easier FIXME: Investigate if this is actually needed
# or can we just use the variable here? even tho it goes to python later
TOP_OUTPUT=$(cat ~/top_output)

# Mem in GiB, with 2 decimals
# FREE_MEM=$(free | grep Mem | awk '{print $3/$2 * 100.0}')
# FREE_MEM=$(free | grep Mem | awk '{printf "%.2f", $3/$2 * 100.0}') # NOTE: Percentage used
FREE_MEM=$(free | grep Mem | awk '{printf "%.2f", $3 / 1024.0 / 1024.0}') # Used in GiB
# echo $TOP_OUTPUT

json_output=$(echo "{\"text\": \"$FREE_MEM\", \"alt\": \"$TOP_OUTPUT\"}" | python3 -c "import sys; import json; data = sys.stdin.read(); our_json=json.dumps(data); print(our_json)")
# echo $json_output > ~/top_output.json
# echo $json_output > ~/top_output.json
new_json=$(echo $json_output | python3 -c 'import sys; my_str=sys.stdin.read(); new_str=my_str.replace("\\", "", 7); new_str=new_str.replace("\"", "", 1); new_str=new_str[0:-4]; last_stuff=new_str[0:-3] + "\"}"; new_str=last_stuff; print(new_str);')

# For debugging
echo $new_json > ~/top_output.json

echo $new_json
