#!/bin/bash

#*******************************************************************************
#  (\_/)	Author: Bradley Stradling
#  (o.o)	Date of first revision: Thu 18 Feb 2021 02:50:18 PM EST
# (")_(")	Lincense: https://unlicense.org/
#*******************************************************************************
# (\_/)		Simple Vignere cipher script. That can handle encipher or 
# (*.*)		decipher mode, and any rotation count between 0 and 26
#(")_(")	
#*******************************************************************************

red=`tput setaf 1`
green=`tput setaf 2`
yellow=`tput setaf 3`
blue=`tput setaf 4`
purple=`tput setaf 5`
lightblue=`tput setaf 6`
black=`tput setaf 0`
reset=`tput sgr0`

echo "This script is nowhere near complete. Please wait for it to be finished before running."
exit 0

show_Help() {
echo -e "Example run ${red}encipher${reset} by key value of ACE \n \"./caesar.sh -e -k ACE -i infile -o outfile\""
echo -e "or \n \"./caesar.sh --encipher -rotation 3 -input_File infile -output_File outfile\"\n"
echo -e "Example run ${red}decipher${reset} by key value of ACE \n \"./caesar.sh -d -k ACE -i infile -o outfile\""
echo -e "or \n \"./caesar.sh --decipher -key ACE -input_File infile -output_File outfile\""

echo ""

echo -e "The 1st option passed should be\n -e or --encipher # to flag encipher or dicpher"
echo -e "The 2nd option passed should be\n -k or --key # to flag the key followed by the keyword"
echo -e "The 3rd option passed should be\n -i or --input_File # to flag the input file followed by the path/name of the file"
echo -e "The 4th option passed should be\n -o or --output_FIle # to flag the output file followed by the path/name of the file"
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
if [[ -z "$7" ]]; then
echo "Missing"
echo "${yellow}Please pass all needed options and parameters. Use -h to see help. Exiting${reset}"
exit 1
fi

#set_Arguments
if [[ $1 == "-e" || $1 == --encipher ]]; then
cipher="encipher"
elif [[ $1 == "-d" || $1 == --decipher ]]; then
cipher="decipher"
else
echo "${yellow}Please pass options in correct order. Use -h to see help. Exiting${reset}"
exit
fi
if [[ $2 == "-r" || $2 == --rotation ]]; then
if [[ $cipher == "encipher" ]]; then
rotation=$3
elif [[ $cipher == decipher ]]; then
rotation=$((26 - $3))
elif [[ $1 != "-r" ]]; then
echo "${yellow}Please pass options in correct order. Use -h to see help. Exiting${reset}"
exit 1
fi
fi
if [[ $4 == "-i" || $4 == --input_File ]]; then
input_File=$5
elif [[ $4 != "-i" ]]; then
echo "${yellow}Please pass options in correct order. Use -h to see help. Exiting${reset}"
exit 1
fi
if [[ $6 == "-o" || $6 == --output_File ]]; then
output_File=$7
elif [[ $6 != "-o" ]]; then
echo "${yellow}Please pass options in correct order. Use -h to see help. Exiting${reset}"
exit 1
fi

#check_Choices
if [[ -z "$cipher" ]]; then
echo "${red} cipher variable was not set :( Exiting${reset}"
exit 1
fi
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

if [[ $cipher == "encipher" ]]; then
echo "${green}Encipher mode set${reset}"
elif [[ $cipher == "decipher" ]]; then
echo "${green}Decipher mode set${reset}"
fi

#check_File_Locations
if [ $rotation -lt 26 ] && [ $rotation -gt 0 ]; then
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
echo -e "${green}Output File found at $output_File ${green}"
else
echo "${red}Unable to read $output_File :( Exiting${reset}" && exit 1
fi

lowercase=(
"a" "b" "c" "d" "e" "f" "g" "h" "i" "j" "k" "l" "m" "n" "o" "p" "q" "r" "s" "t" "u" "v" "w" "x" "y" "z"
)
uppercase=(
"A" "B" "C" "D" "E" "F" "G" "H" "I" "J" "K" "L" "M" "N" "O" "P" "Q" "R" "S" "T" "U" "V" "W" "X" "Y" "Z"
)
positional_Chart=${!uppercase[@]}

echo ${blue}${positional_Chart[@]}
shifted_Positional_Chart=("${positional_Chart[@]:$rotation}" "${positional_Chart[@]:0:$rotation}")
echo ${shifted_Positional_Chart[@]}
echo ${lightblue}${uppercase[@]}
shifted_Uppercase=("${uppercase[@]:$rotation}" "${uppercase[@]:0:$rotation}")
echo ${shifted_Uppercase[@]}
echo ${yellow}${lowercase[@]}
shifted_Lowercase=("${lowercase[@]:$rotation}" "${lowercase[@]:0:$rotation}")
echo ${shifted_Lowercase[@]}${purple}

#Encipher
while read -n1 char; do
count=0
for input in ${uppercase[@]}
do
if [[ $char == " " ]]; then
echo "a space was detected"
fi
if [[ $char == $input ]]; then
upper_Or_Lower="upper"
position=$(($count - $rotation)) # need to handle this being a negative number
if [[ $position -lt "0" ]]; then
position=$(($position + 26))
fi
echo "${green}$char${purple} is uppercase at position $count and rotates by $rotation back to $position as ${green}${uppercase[$position]}"
echo -n ${uppercase[$position]} >> $output_File
fi
count=$(($count + 1))
done
count=0
for input in ${lowercase[@]}
do
if [[ $char == $input ]]; then
upper_Or_Lower="lower"
position=$(($count - $rotation)) # need to handle this being a negative number
if [[ $position -lt "0" ]]; then
position=$(($position + 26))
fi
echo "${green}$char${purple} is lowercase at position $count and rotates by $rotation back to $position as ${green}${lowercase[$position]}"
echo -n ${lowercase[$position]} >> $output_File
fi
count=$(($count + 1))
done
done < $input_File

