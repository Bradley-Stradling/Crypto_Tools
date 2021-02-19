#!/bin/bash

#*******************************************************************************
#  (\_/)	Author: Bradley Stradling
#  (o.o)	Date of first revision: Fri 12 Feb 2021 01:33:14 PM EST
# (")_(")	Lincense: https://unlicense.org/
#*******************************************************************************
# (\_/)		Simple script to help visualize simple rotational ciphers
# (*.*)		
#(")_(")	
#*******************************************************************************

show_Help() {
echo -e "Requires 2 total inputs"
echo -e "-r or --rotation \t# to flag the rotation count followed by a number"\
		" between 0 and 26\n"
echo -e "Example run \n\"./Rotation_Cipher_Key_Genie.sh -r 3\"\n or \n" \
		"\"./Rotation_Cipher_Key_Genie.sh --rotation 3\""
exit 0
}

#check_Help
if [[ $1 == "-h" || $1 == --help ]]; then
	show_Help
fi


if [[ $1 == "-r" || $1 == --rotation ]]; then
	rotation=$2
		elif [[ $1 != "-r" ]]; then
			echo "${yellow}Please pass options in correct order. Use -h to "\
				 "see help. Exiting${reset}"
			echo " Must be -r n # where n is a positive number"
			exit 1
fi

lowercase=(
"a" "b" "c" "d" "e" "f" "g" "h" "i" "j" "k" "l" "m" "n" "o" 
"p" "q" "r" "s" "t" "u" "v" "w" "x" "y" "z"
)
uppercase=(
"A" "B" "C" "D" "E" "F" "G" "H" "I" "J" "K" "L" "M" "N" "O" 
"P" "Q" "R" "S" "T" "U" "V" "W" "X" "Y" "Z"
)

positional_Chart=( ${!uppercase[@]} )

for i in ${positional_Chart[@]}
do
positional_Chart[$i]=$(( ${positional_Chart[$i]} + 1 ))
done

echo ${positional_Chart[@]}
shifted_Positional_Chart=("${positional_Chart[@]:$rotation}" 
"${positional_Chart[@]:0:$rotation}")
echo ${shifted_Positional_Chart[@]}
echo
echo ${uppercase[@]}
shifted_Uppercase=("${uppercase[@]:$rotation}" "${uppercase[@]:0:$rotation}")
echo ${shifted_Uppercase[@]}
echo
echo ${lowercase[@]}
shifted_Lowercase=("${lowercase[@]:$rotation}" "${lowercase[@]:0:$rotation}")
echo ${shifted_Lowercase[@]}
