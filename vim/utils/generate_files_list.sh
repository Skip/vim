#!/bin/bash

files_list="project_files.list"

if [ -f "$files_list" ]
then
    rm -rf $files_list
fi

find . -name "*.[cC]" -o -name "*.[hH]" -o -name "*.[sS]" -o -name "*.[cC][pP][pP]" -o -name "*.[cC][cC]" > $files_list
