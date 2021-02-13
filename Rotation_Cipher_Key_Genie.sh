#!/bin/bash

if [[ $1 == "-r" || $1 == --rotation ]]; then
rotation=$2
elif [[ $1 != "-r" ]]; then
echo "${yellow}Please pass options in correct order. Use -h to see help. Exiting${reset}"
echo " Must be -r n # where n is a positive number"
exit 1
fi

lowercase=(
"a" "b" "c" "d" "e" "f" "g" "h" "i" "j" "k" "l" "m" "n" "o" "p" "q" "r" "s" "t" "u" "v" "w" "x" "y" "z"
)
uppercase=(
"A" "B" "C" "D" "E" "F" "G" "H" "I" "J" "K" "L" "M" "N" "O" "P" "Q" "R" "S" "T" "U" "V" "W" "X" "Y" "Z"
)

echo ${uppercase[@]}
shifted_Uppercase=("${uppercase[@]:$rotation}" "${uppercase[@]:0:$rotation}")
echo ${shifted_Uppercase[@]}
echo
echo ${lowercase[@]}
shifted_Lowercase=("${lowercase[@]:$rotation}" "${lowercase[@]:0:$rotation}")
echo ${shifted_Lowercase[@]}
