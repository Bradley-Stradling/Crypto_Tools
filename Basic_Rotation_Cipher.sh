#!/bin/bash

#*******************************************************************************
#  (\_/)	Author: Bradley Stradling
#  (o.o)	Date of first revision: Fri 12 Feb 2021 01:33:14 PM EST
# (")_(")	Lincense: https://unlicense.org/
#*******************************************************************************
# (\_/)		Simple Caesar cipher script. That can handle encipher or 
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

show_Help() {
echo -e "Requires 7 total inputs"
echo -e "-e or --encipher \t# to flag encipher or dicpher"
echo -e "-r or --rotation \t# to flag the rotation count followed by a number"\
" between 0 and 26"
echo -e "-i or --input-File \t# to flag the input file followed by the "\
"path/name of the file"
echo -e "-o or --output-FIle \t# to flag the output file followed by the "\
"path/name of the file\n"
echo -e "2 verbose options exist but are not needed to run"
echo -e "-v or --verbose # displays cipher chart"
echo -e "-vv or --very-verbose will display each char's rotation, not "\
"recommended for long files\n"
echo -e "Example run ${red}encipher${reset} by rotation value of 3 \n \""\
"${yellow}./caesar.sh -e -r 3 -i infile -o outfile${reset}\""
echo -e "or \n \"${yellow}./caesar.sh --encipher -rotation 3 -input-File "\
"infile -output-File outfile${reset}\"\n"
echo -e "Example run ${red}decipher${reset} by rotation value of 3 \n \""\
"${yellow}./caesar.sh -d -r 3 -i infile -o outfile${reset}\""
echo -e "or \n \"${yellow}./caesar.sh --decipher -rotation 3 -input-File "\
"infile -output-File outfile${reset}\"\n"
echo -e "Example run ${red}verbose${reset} by rotation value of 3 \n \""\
"${yellow}./caesar.sh -e -r 3 -i infile -o outfile -v${reset}\""
echo -e "or \n \"${yellow}./caesar.sh --encipher -rotation 3 -input-File "\
"infile -output-File outfile --verbose${reset}\"\n"
echo -e "Example run ${red}very verbose${reset} by rotation value of 3 \n \""\
"${yellow}./caesar.sh -e -r 3 -i infile -o outfile -vv${reset}\""
echo -e "or \n \"${yellow}./caesar.sh --encipher -rotation 3 -input-File "\
"infile -output-File outfile --very-verbose${reset}\"\n"
}

#check_Help
if [[ $1 == "-h" || $1 == --help ]]; then
show_Help
exit 1
fi

more_Options() {
echo "${yellow}Please pass all needed options and parameters. Use -h to see "\
"help. Exiting${reset}"
exit 1
}

#check_Arguments
if [[ -z "$1" ]]; then
	more_Options
fi
if [[ -z "$2" ]]; then
	more_Options
fi
if [[ -z "$3" ]]; then
	more_Options
fi
if [[ -z "$4" ]]; then
	more_Options
fi
if [[ -z "$5" ]]; then
	more_Options
fi
if [[ -z "$6" ]]; then
	more_Options
fi
if [[ -z "$7" ]]; then
	more_Options
fi

wrong_Order() {
echo "${yellow}Please pass options in correct order. Use -h to see help."\
" Exiting${reset}"
exit 1
}

#set_Arguments
if [[ $1 == "-e" || $1 == --encipher ]]; then
	cipher="encipher"
		elif [[ $1 == "-d" || $1 == --decipher ]]; then
			cipher="decipher"
				else
					wrong_Order
fi

if [[ $2 == "-r" || $2 == --rotation ]]; then
	if [[ $cipher == "encipher" ]]; then
		rotation=$3
			elif [[ $cipher == decipher ]]; then
				rotation=$((26 - $3))
					elif [[ $1 != "-r" ]]; then
						wrong_Order
	fi
fi

if [[ $4 == "-i" || $4 == --input_File ]]; then
	input_File=$5
		elif [[ $4 != "-i" ]]; then
			wrong_Order
fi

if [[ $6 == "-o" || $6 == --output_File ]]; then
	output_File=$7
		elif [[ $6 != "-o" ]]; then
			wrong_Order
fi

if [[ $8 == "-v" || $8 == "--verbose" ]]; then
	silence="no"
		else
			silence="yes"
fi

if [[ $8 == "-vv" || $8 == "--very-verbose" ]]; then
	silence="noway"
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
	echo "${red} input-File variable was not set :( Exiting${reset}"
	exit 1
fi

if [[ -z "$output_File" ]]; then
	echo "${red} output-File variable was not set :( Exiting${reset}"
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
			echo "${red}Unable to set the rotation to $rotation :( "\
				 "Exiting${reset}" && exit 1
fi

if [[ -r $input_File ]]; then
	echo -e "${green}Input File found at $input_File ${reset}"
		else
			echo "${red}Unable to read $input_File :( Exiting${reset}" \
				 && exit 1
fi

if [[ -r $output_File ]]; then
	echo -e "${green}Output File found at $output_File ${reset}"
		else
			echo "${red}Unable to read $output_File :( Exiting${reset}" \
				 && exit 1
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

if [[ $silence == "no"  || $silence == "noway" ]]; then
	echo "${blue}${positional_Chart[@]}"
	shifted_Positional_Chart=("${positional_Chart[@]:$rotation}" \
	"${positional_Chart[@]:0:$rotation}")
	echo ${shifted_Positional_Chart[@]}
	echo ${lightblue}${uppercase[@]}
	shifted_Uppercase=("${uppercase[@]:$rotation}" "${uppercase[@]:0:$rotation}")
	echo ${shifted_Uppercase[@]}
	echo ${yellow}${lowercase[@]}
	shifted_Lowercase=("${lowercase[@]:$rotation}" "${lowercase[@]:0:$rotation}")
	echo ${shifted_Lowercase[@]}${purple}
fi

#cipher
while read -n1 char; do
	count=1
	for input in ${uppercase[@]}
	do
		if [[ $char == " " ]]; then
			echo "a space was detected"
		fi

		if [[ $char == $input ]]; then
			upper_Or_Lower="upper"
			position=$(($count - $rotation - 1))
			if [[ $position -lt "0" ]]; then
				position=$(($position + 26))
			fi

			if [[ $silence == "noway" ]]; then
				position_Display=$(($position + 1))
				echo "${green}$char${purple} is uppercase at position $count "\
					 "and rotates by $rotation back to $position_Display as "\
					 "${green}${uppercase[$position]}"
				echo -n ${uppercase[$position]} >> $output_File
			fi
		fi
	count=$(($count + 1))
	done
	count=1
	for input in ${lowercase[@]}
	do
		if [[ $char == $input ]]; then
			upper_Or_Lower="lower"
			position=$(($count - $rotation - 1))
			if [[ $position -lt "0" ]]; then
				position=$(($position + 26))
			fi
			if [[ $silence == "noway" ]]; then
				position_Display=$(($position + 1))
				echo "${green}$char${purple} is lowercase at position $count "\
					 "and rotates by $rotation back to $position_Display as "\
					 "${green}${lowercase[$position]}"
				echo -n ${lowercase[$position]} >> $output_File
			fi
		fi
	count=$(($count + 1))
	done
done < $input_File

cat $output_File | fold -w60 > tempfile
rm $output_File
mv tempfile $output_File

