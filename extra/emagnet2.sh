#!/usr/bin/env bash

# - iNFO --------------------------------------
#
#   Author: wuseman <wuseman@nr1.nu>
# FileName: emagnet2.sh
#  Created: 2023-07-03 (09:40:19)
# Modified: 2023-07-13 (03:29:08)
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
