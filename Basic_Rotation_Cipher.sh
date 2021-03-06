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
echo -e "This script is designed to assist with processing a Rotational cipher."
if [[ $1 == "-e" || $1 == "--explain" || $1 == "-vv" || $1 == "--very-verbose" ]]; then
echo "### Explanation of a Rotational cipher here ###"
fi
if [[ $1 != "-e" && $1 != "--explain" ]]; then
echo -e "Requires 7 total inputs"
echo -e "-e or --encipher || -d or --decipher \t# to flag encipher or dicpher"
echo -e "-k or --keyword \t# to flag the key followed by a keyword"
echo -e "-i or --input-File \t# to flag the input file followed by the "\
		"path/name of the file"
echo -e "-o or --output-FIle \t# to flag the output file followed by the "\
		"path/name of the file\n"
echo -e "2 verbose options exist but are not needed to run, can be used with help"
echo -e "-v or --verbose # displays cipher chart"
echo -e "-vv or --very-verbose will display each char's rotation, not "\
		"recommended for long files\n"
echo -e "An addtional option can be supplied after -h to call for explanation "\
		"\bof a Vignere keyword cipher that this script is based on."
echo -e "\"./Basic_Rotation_Cipher.sh -h -e\" or "\
		"\"./Basic_Rotation_Cipher.sh --help --explain\"\n"
fi

if [[ $1 == "-v" || $1 == "--verbose" || $1 == "-vv" || $1 == "--very-verbose" ]]; then
echo -e "Example run ${red}encipher${reset} with a rotation of 3\n\""\
		"${yellow}\b./Basic_Rotation_Cipher.sh -e -r 3 -i infile -o outfile"\
		"${reset}\b\""
echo -e "or \n\"${yellow}./Basic_Rotation_Cipher.sh --encipher --rotational 3"\
		"\b --input-File infile --output-File outfile${reset}\"\n"
echo -e "Example run ${red}decipher${reset} with a rotation of 3\n\""\
		"${yellow}\b./Basic_Rotation_Cipher.sh -d -r 3 -i infile -o outfile"\
		"${reset}\b\""
echo -e "or \n\"${yellow}./Basic_Rotation_Cipher.sh --decipher --rotation 3"\
		"\b --input-File infile --output-File outfile${reset}\"\n"
echo -e "Example run ${red}verbose${reset} with a rotation of 3\n\"${yellow}"\
		"\b./Basic_Rotation_Cipher.sh -e -r 3 -i infile -o outfile -v"\
		"${reset}\b\""
echo -e "or \n\"${yellow}./Basic_Rotation_Cipher.sh --encipher --rotation 3"\
		"--input-File infile --output-File outfile --verbose${reset}\"\n"
echo -e "Example run ${red}very verbose${reset} with a rotation of 3\n\""\
		"${yellow}\b./Basic_Rotation_Cipher.sh -e -r 3 -i infile -o outfile -vv"\
		"${reset}\b\""
echo -e "or \n\"${yellow}./Basic_Rotation_Cipher.sh --encipher --rotation"\
		"ACE --input-File infile --output-File outfile --very-verbose${reset}\"\n"
fi
exit 0
}

#check_Help
if [[ $1 == "-h" || $1 == --help ]]; then
show_Help $2
fi

more_Options() {
echo "${yellow}Please pass all needed options and parameters. Use -h to see "\
"help. Exiting${reset}"
exit 1
}

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
			elif [[ $cipher == "decipher" ]]; then
				rotation=$((26 - $3))
					else
						wrong_Order
	fi
display_Rotation=$3
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
IFS=''
while read -n1 char; do
	if [[ $char == " " ]]; then
	continue
	fi
	count=1
	for input in ${uppercase[@]}
	do
		if [[ $char == $input ]]; then
			upper_Or_Lower="upper"
			position=$(($count - $rotation - 1))
			if [[ $position -lt "0" ]]; then
				position=$(($position + 26))
			fi

			if [[ $silence == "noway" ]]; then
				position_Display=$(($position + 1))
				echo "${green}$char${purple} is uppercase at position $count"\
					 "and rotates by $display_Rotation back to $position_Display"\
					 " as ${green}${uppercase[$position]}${reset}"
			fi
			echo -n ${uppercase[$position]} >> $output_File
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
				echo "${green}$char${purple} is lowercase at position $count"\
					 "and rotates by $display_Rotation back to $position_Display"\
					 " as ${green}${lowercase[$position]}${reset}"
			fi
			echo -n ${lowercase[$position]} >> $output_File
		fi
	count=$(($count + 1))
	done
done < $input_File

cat $output_File | fold -w60 > tempfile
rm $output_File
mv tempfile $output_File
