#!/bin/bash

base_path="/home/skip/.vim"

if [ "$HOSTNAME" == "skip.nkbvs.tsure.ru" ]
then
    ctags=$base_path/"utils/ctags_i686"
elif [ "$HOSTNAME" == "skip-note" ]
then
    ctags=$base_path/"utils/ctags_pentium_dual_core"
else
    ctags=$base_path/"utils/ctags_i686"
fi

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

