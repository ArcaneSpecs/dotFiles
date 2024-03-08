#!/bin/bash

# while inotifywait -e close_write libRPG.so; do 
#     echo "libRPG.so changed..." 
#     nvim -c "%!xxd" -c /GetClassImpl; 
# done
# inotifywait -m /path -e create -e moved_to |
#     while read -r directory action file; do
#         if [[ "$file" =~ .*xml$ ]]; then # Does the file end with .xml?
#             echo "xml file" # If so, do your thing here!
#         fi
#     done
# while inotifywait --monitor --event access ./libRPG.so; do
#     echo "libRPG.so changed..."
#     nvim ./libRPG.so -c "%!xxd" -c /GetClassImpl;
# done
#
PID=0
while inotifywait . -e create,delete,modify; do { 
    if [ $PID -ne 0 ]; then
        kill $PID;
    fi
    echo "libRPG.so changed...";
    nvim ./libRPG.so -c "%!xxd" -c /GetClassImpl&
    PID=$!
}; done 

# inotifywait --event access --monitor ./libRPG.so && kill nvim; echo "libRPG.so changed..."; nvim ./libRPG.so -c "%!xxd" -c /GetClassImpl;

