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
# ----------------------------------------------

emagnetHome="$HOME/emagnet"
emagnetIncoming="$emagnetHome/incoming/"
emagnetIncomingDaily="$emagnetHome/incoming/$(date +%Y-%m-%d)"
emagnetIncomingTemp="$emagnetHome/incoming/$(date +%Y-%m-%d)/.temp"
emagnetIncomingLog="$emagnetHome/logs/logins-$(date +%Y-%m-%d).log"
emagnetLoginDaily="$emagnetHome/logs/$(date +%Y-%m-%d)"

cookiesDir="$emagnetHome/stealer/cookie-files"
passwordDir="$emagnetHome/stealer/password-files"
screenshotDir="$emagnetHome/stealer/screenshot-files"
walletsDir="$emagnetHome/stealer/wallets-files"

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
	for tools in rg wget elinks grep; do
		command -v "$tools" >/dev/null 2>&1
		if [ $? -ne 0 ]; then
			printf "%s: internal error -- \e[1;4m%s\e[0m is required to be installed\n" "$0" "$tools"
			exit 1
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


