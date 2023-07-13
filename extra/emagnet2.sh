#!/usr/bin/env bash

# - iNFO --------------------------------------
#
#   Author: wuseman <wuseman@nr1.nu>
# FileName: emagnet2.sh
#  Created: 2023-07-03 (09:40:19)
# Modified: 2023-07-13 (09:53:25)
#  Version: 3.4.4
#  License: MIT
#
#      iRC: wuseman (Libera/EFnet/LinkNet)
#   GitHub: https://github.com/wuseman/
#
# ---------------------------------------------

emagnetHome="$HOME/emagnet"
emagnetIncoming="$emagnetHome/incoming/"
emagnetIncomingDaily="$emagnetHome/incoming/$(date +%Y-%m-%d)"
emagnetIncomingTemp="$emagnetHome/incoming/$(date +%Y-%m-%d)/.temp"
emagnetIncomingLog="$emagnetHome/logs/logins-$(date +%Y-%m-%d).log"
emagnetLoginDaily="$emagnetHome/logs/$(date +%Y-%m-%d)"

cookiesDir="$emagnetHome/stealer/cookie-files"
passwordDir="$emagnetHome/stealer/password-files"
screenshotDir="$emagnetHome/stealer/screenshot-files"
walletsDir="$emagnetHome/stealer/wallet-files"

crackedAccounts="$emagnetHome/cracked-accounts"

cpuCores="$(($(nproc) + 1))"
stealerSource=""

emagnet_create_dirs() {
	declare -A directories=(
		[emagnetHome]="$HOME/emagnet"
		[emagnetIncoming]="${emagnetHome}/incoming/"
		[emagnetIncomingDaily]="${emagnetHome}/incoming/$(date +%Y-%m-%d)"
		[emagnetIncomingTemp]="${emagnetHome}/incoming/$(date +%Y-%m-%d)/.temp"
		[passwordDir]="${emagnetHome}/stealer/password-files"
		[screenshotDir]="${emagnetHome}/stealer/screenshot-files"
		[cookiesDir]="${emagnetHome}/stealer/cookie-files"
		[emagnetLoginDaily]="${emagnetHome}/logs/$(date +%Y-%m-%d)"
                ### FOlder to be used for send files to group.
		[stealerSource]="/mnt/usb/telegram"
		[crackedAccounts]="$emagnetHome/cracked-accounts"
	)

	create_directory() {
		if [ ! -d "$1" ]; then
			mkdir -p "$1"
		fi
	}

	for dir in "${!directories[@]}"; do
		create_directory "${directories[$dir]}"
	done
}

emagnetRequirements() {
	for tools in rg wget wget2 curl ; do
		command -v "$tools" >/dev/null 2>&1
		if [ $? -ne 0 ]; then
			printf "%s: internal error -- \e[1;4m%s\e[0m is required to be installed\n" "$0" "$tools"
			
		fi
	done
}

emagnetStealerRequirements() {
	for tools in unzip unrar parallel rga grep; do
		command -v "$tools" >/dev/null 2>&1
		if [ $? -ne 0 ]; then
			printf "%s: internal error -- \e[1;4m%s\e[0m is required to be installed\n" "$0" "$tools"
			exit 1
		fi
	done
}

analyzeMessage() {
	hackMessages=(
		"Please wait, infiltrating the system..."
		"Please wait, decrypting security protocols..."
		"Please wait, bypassing firewalls..."
		"Please wait, executing cyber reconnaissance..."
		"Please wait, cracking encryption codes..."
		"Please wait, breaching the digital fortress..."
		"Please wait, mapping network vulnerabilities..."
		"Please wait, exploiting system weaknesses..."
		"Please wait, hacking into the mainframe..."
	)

	for ((i = ${#hackMessages[@]} - 1; i > 0; i--)); do
		j=$((RANDOM % (i + 1)))
		temp=${hackMessages[i]}
		hackMessages[i]=${hackMessages[j]}
		hackMessages[j]=$temp
	done

	selected_hackMessages=${hackMessages[0]}
	echo -ne "$selected_hackMessages\033[0K\r"
}


display_usage() {
    echo "Usage: ./$0 [options]"
    echo "Options:"
    echo "  -e, --emagnet           : Run emagnet once and stop"
    echo "  -t, --time              : Run emagnet every X minute"
    echo "  -c, --convert           : Convert a curl command to wget2 and start mirroring"
    echo "  -x, --extract           : Extract specific data from stealer dir"
    echo "                            Valid options: passwords, wallets, cookies, screenshots, autofills, all"
    echo "  -p, --parallel <value>  : Extract with specified number of parallel cores (default: number of CPU cores)"
    echo "  -l, --list              : Extract specific data from stealer dir"
    echo "                            Valid options: passwords, wallets, cookies, screenshots, autofills, all"
    echo "  --test                  : Test archive files"
    echo ""
    echo "Example:"
    echo "  ./$0 -t 5               : Run emagnet every 5 minutes"
    echo "  ./$0 -c                 : Convert curl command to wget2 and start mirroring"
    echo "                            Note: For more information, see the video in the README (to be added)"
    echo "                            - Copy and paste the web source URL from your browser"
    echo "                              to initiate the download of all files when you are logged in"
    echo ""
    echo "."
}

emagnetGet() {

	tempFile1=$emagnetIncomingTemp/dl-urls.txt
	tempFile2="$emagnetIncomingTemp/temp-dl-diff2-txt"
	tempFile3="$emagnetIncomingTemp/temp-dl-diff3-txt"

	analyzeMessage
	start=$(date +%s.%3N)
#	fetchSource1() {
#		wget2 -qO- ........ |
#			awk 'match($0, /https.*upload.ee\/files.*txt.html/) {
#          		url = substr($0, RSTART, RLENGTH); gsub(/["<]/, "", url); urls[url]}
#           		END {for (url in urls) print url}' |
#			xargs -P5 curl -sL |
#			grep -o 'd_l.*href="[^"]*"' |
#			grep -o 'https://[^[:space:]]*' |
#			cut -d: -d'"' -f1 >$tempFile1
#
	#}
	#fetchSource2() {
	#	exclude='signup\|login\|archive\|_\|pastebin$\|dmca$\|tools$\|contact$\|languages'
	#	curl -Ls "https://pastebin.com/archive" |
	#		awk -F'href="/' '{print $2}' |
	#		cut -d'"' -f1 |
	#		awk 'length($0)>6 && length($0)<9' |
	#		sed 's/^/https:\/\/pastebin.com\/raw\//g' | rg -v $exclude
	#}
	#fetchSource4() {
	# add another source
	#}
	#fetchSource5() {
	# add another source
	#}
	#fetchSource6() {
	# add another source
	#}
	#fetchSource7() {
	# add another source
	#}

	fetchSource1
	end=$(date +%s.%3N)
	duration=$(awk "BEGIN {printf \"%.2f\", ${end} - ${start}}")
}

emagnetMain() {
	emagnetGet
# rg -Nc "\b[A-Za-z0-9._%+-]+@.*" $emagnetIncomingTemp|| awk -F: '{sum += $2} END {print sum}'
# rg '\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,6}\b:.....*' "$emagnetIncomingTemp/" >"$emagnetIncomingLog"
# logins=$(rg '\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,6}\b:.....*' $emagnetIncomingTemp/ | wc -l)
    if [[ -s $tempFile1 ]]; then
        echo -ne "Nothing to download...\033[0K\r"
        sleep 2
        echo -ne "\033[0K\r"
        exit 0
    fi

    count=$(cat $tempFile3 | wc -l)
    logins=$(rg -c "\b[A-Za-z0-9._%+-]+@.*" $emagnetIncomingTemp | awk -F: '{sum += $2} END {print sum}')

    variations=(
        "Retribution: ${count} files reclaimed, ${logins} logins captured, Nr1 dominating in ${duration}s.\033[0K\r"
        "The ultimate hack: ${count} files seized, ${logins} logins controlled, proving Nr1 status in ${duration}s.\033[0K\r"
        "Digital justice served: ${count} files recovered, ${logins} logins reclaimed, Nr1 in ${duration}s.\033[0K\r"
        "Hackers meet their match: ${count} files intercepted, ${logins} logins compromised, Nr1 strikes in ${duration}s.\033[0K\r"
        "Stealing from stealers: ${count} files reclaimed, ${logins} logins captured, Nr1 supremacy in ${duration}s.\033[0K\r"
        "Masters of the hack: ${count} files controlled, ${logins} logins at command, Nr1 domination in ${duration}s.\033[0K\r"
        "Hacking hackers: ${count} files infiltrated, ${logins} logins compromised, Nr1 reigns in ${duration}s.\033[0K\r"
        "Digital dominators: ${count} files conquered, ${logins} logins mastered, Nr1 proving supremacy in ${duration}s.\033[0K\r"
        "Emagnet's reign: ${count} files seized, ${logins} logins captured, Nr1's authority in ${duration}s.\033[0K\r"
        "Defying hackers: ${count} files reclaimed, ${logins} logins controlled, Nr1 showcasing skills in ${duration}s.\033[0K\r"
    )

    for ((i = ${#variations[@]} - 1; i > 0; i--)); do
        j=$((RANDOM % (i + 1)))
        temp=${variations[i]}
        variations[i]=${variations[j]}
        variations[j]=$temp
    done

    selected_variation=${variations[0]}
    echo -ne "$selected_variation\r"
    mv -v $emagnetIncomingTemp/* $emagnetLoginDaily/
}

emagnetExtract() {
echo "N/A"
## VALID 
# find /path -type f \( -iname "*.<add>" -o -iname "*.<add>" \) -print0 | xargs -0 $cpuCores -n 1 bash process_file.sh (proccess_file_on_note)
#-------------------------------
### SHELL INJECTION !!! 
###find $stealerSource -type f \( -name "*.<add>" -exec sh -c '<add> -l "{}" "**"' \; \) -o \( -name "*.<add>" -exec sh -c '<add>  "{}" "**"' \; \) | xargs -P $cpuCores -I {} bash -c 'export LC_ALL=C; {}'
#-------------------------------
}

emagnetExtract() {
echo "N/A"
case $2 in
   '*ssword*')
   echo "add handler passwords"
   ;;
   '*utofil*')
    echo "add handler autofills"
   ;;
   '*ooki*')
    echo "add list handler cookies"
   ;;
   '*creensho*')
    echo "add list handler screenshots"
   ;;
   ''.dat*|*llet*)
    echo "add handler crypto wallets"
    echo "add reverse eng. command for grab balance if possible on stdin"
    echo "add bruteforce for encrypted wallets IF there is more then 1$"
   ;;
esac
## VALID 
# find /path -type f \( -iname "*.<add>" -o -iname "*.<add>" \) -print0 | xargs -0 $cpuCores -n 1 bash process_file.sh (proccess_file_on_note)
#-------------------------------
### SHELL INJECTION !!! 
###find $stealerSource -type f \( -name "*.<add>" -exec sh -c '<add> -l "{}" "**"' \; \) -o \( -name "*.<add>" -exec sh -c '<add>  "{}" "**"' \; \) | xargs -P $cpuCores -I {} bash -c 'export LC_ALL=C; {}'
#-------------------------------
}

emagnetList() {
case $2 in
   '*ssword*')
   echo "add list passwords"
   ;;
   '*utofil*')
    echo "add list autofills"
   ;;
   '*ooki*')
    echo "add list cookies"
   ;;
   '*creensho*')
    echo "add list screenshots"
   ;;
   ''.dat*|*llet*)
    echo "add list crypto wallets"
    echo "add reverse eng. command for grab balance if possible on stdin"
   ;;
esac


if [[ $# -eq 0 ]]; then
	display_usage
	exit 1
fi

while [[ $# -gt 0 ]]; do
	key="$1"

	case $key in
	-e | --emagnet)

		#emagnetMain
		;;
	-t | --time)
		if [[ -z $2 ]]; then
			echo "Please provide a time value in minutes."
			exit 1
		fi
		minutes="$2"
		echo "....running next session in $seconds minute(s)..."

		;;
	-c | --convert)
		#curl2wget2
		;;
	*)
		echo "Unknown option: $key"
		display_usage
		exit 1
		;;
	esac

	shift
done


