#!/bin/bash

base_path="/home/skip/.vim"

ctags=$base_path/"utils/ctags"

files_list="project_files.list"
tags_file="tags"
remove="rm -rf"

ctags_opts="-R --extra=+qf --excmd=pattern --c++-kinds=+p --c-kinds=+p --fields=+afikmnSzt -f $tags_file -L $files_list"

$base_path/utils/generate_files_list.sh

if [ -f "$tags_file" ]
then
    $remove $tags_file
fi

$ctags $ctags_opts

