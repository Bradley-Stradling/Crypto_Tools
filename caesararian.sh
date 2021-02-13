#!/bin/bash

#*******************************************************************************
#  (\_/)	Author: Bradley Stradling
#  (o.o)	Date of first revision: Fri 12 Feb 2021 01:33:14 PM EST
# (")_(")	Lincense: https://unlicense.org/
#*******************************************************************************
# (\_/)		Simple Caesar cipher script.
# (*.*)		
#(")_(")	
#*******************************************************************************

red=`tput setaf 1`
green=`tput setaf 2`
yellow=`tput setaf 3`
reset=`tput sgr0`

show_Help() {
echo -e "Example run \"./caesar.sh -r 3 -i infile -o outfile\""
}

#check_Help
if [[ $1 == "-h" || $1 == --help ]]; then
show_Help
exit 1
fi

#check_Arguments
if [[ -z "$1" ]]; then
echo "${yellow}Please pass all needed options and parameters. Use -h to see help. Exiting${reset}"
exit 1
fi
if [[ -z "$2" ]]; then
echo "${yellow}Please pass all needed options and parameters. Use -h to see help. Exiting${reset}"
exit 1
fi
if [[ -z "$3" ]]; then
echo "${yellow}Please pass all needed options and parameters. Use -h to see help. Exiting${reset}"
exit 1
fi
if [[ -z "$4" ]]; then
echo "${yellow}Please pass all needed options and parameters. Use -h to see help. Exiting${reset}"
exit 1
fi
if [[ -z "$5" ]]; then
echo "${yellow}Please pass all needed options and parameters. Use -h to see help. Exiting${reset}"
exit 1
fi
if [[ -z "$6" ]]; then
echo "Missing"
echo "${yellow}Please pass all needed options and parameters. Use -h to see help. Exiting${reset}"
exit 1
fi

#set_Arguments
if [[ $1 == "-r" || $1 == --rotation ]]; then
rotation=$2
elif [[ $1 != "-r" ]]; then
echo "${yellow}Please pass options in correct order. Use -h to see help. Exiting${reset}"
exit 1
fi
if [[ $3 == "-i" || $3 == --input_File ]]; then
input_File=$4
elif [[ $3 != "-i" ]]; then
echo "${yellow}Please pass options in correct order. Use -h to see help. Exiting${reset}"
exit 1
fi
if [[ $5 == "-o" || $5 == --output_File ]]; then
output_File=$6
elif [[ $5 != "-o" ]]; then
echo "${yellow}Please pass options in correct order. Use -h to see help. Exiting${reset}"
exit 1
fi

#check_Choices
if [[ -z "$rotation" ]]; then
echo "${red} rotation variable was not set :( Exiting${reset}"
exit 1
fi
if [[ -z "$input_File" ]]; then
echo "${red} input_File variable was not set :( Exiting${reset}"
exit 1
fi
if [[ -z "$output_File" ]]; then
echo "${red} output_File variable was not set :( Exiting${reset}"
exit 1
fi

#check_File_Locations
if [ $rotation -lt 26 ] && [ $rotation -gt -26 ]; then
echo -e "${green}Rotation set to $rotation ${reset}"
else
echo "${red}Unable to set the rotation to $rotation :( Exiting${reset}" && exit 1
fi
if [[ -r $input_File ]]; then
echo -e "${green}Input File found at $input_File ${reset}"
else
echo "${red}Unable to read $input_File :( Exiting${reset}" && exit 1
fi
if [[ -r $output_File ]]; then
echo -e "${green}Input File found at $output_File ${green}\n"
else
echo "${red}Unable to read $output_File :( Exiting${reset}" && exit 1
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

while read -n1 char; do
for input in ${uppercase[@]}
do
if [[ $char == $input ]]; then
echo "$char is uppercase"
fi
done
for input in ${lowercase[@]}
do
if [[ $char == $input ]]; then
echo "$char is lowercase"
fi
done
done < $input_File







