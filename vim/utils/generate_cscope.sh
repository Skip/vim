#!/bin/bash

base_path="/home/skip/.vim"
files_list="project_files.list"
cscope_out="cscope.out"
cscope="/home/skip/.vim/utils/cscope"


if [ ! -f "$files_list" ]
then
    $base_path/utils/generate_files_list.sh
fi

if [ -f "$cscope_out" ]
then
    rm -rf $cscope_out
fi


$cscope -R -b -k -i $files_list -f $cscope_out
