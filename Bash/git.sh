#! /bin/bash

if [ "${#}" -eq 1 ]; then
    git status 
    git add . 
    git commit -m "${1}"
    git push
    git status 
else 
    echo "Je moet een naam meegeven met het script deze wordt gebruikt als git commit message."
fi