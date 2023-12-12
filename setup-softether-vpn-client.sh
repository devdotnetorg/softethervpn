#!/bin/bash
# Setup SoftEther VPN Client for Linux Intel x64 or AMD64
#=================================================================
# Run:	chmod +x setup-softether-vpn-client.sh
# 		sudo ./setup-softether-vpn-client.sh
#=================================================================
# DevDotNet.ORG <anton@devdotnet.org> MIT License

set -e

# Update and installs
sudo apt-get update
sudo apt-get install -y tar sed grep curl wget unzip make gcc net-tools
# Download Bash scripts
mkdir -p softethervpn
cd softethervpn
wget -O softether-vpn-client.zip "https://raw.githubusercontent.com/devdotnetorg/softethervpn/master/softether-vpn-client.zip"
unzip -o softether-vpn-client.zip
rm softether-vpn-client.zip
chmod +x setup-client.sh
chmod +x remove-client.sh
chmod +x vpn-connect.sh
chmod +x vpn-disconnect.sh
cd ..
# Download SoftEther VPN Client
#Full url https://www.softether-download.com/files/softether/v4.43-9799-beta-2023.08.31-tree/Linux/SoftEther_VPN_Client/64bit_-_Intel_x64_or_AMD64/softether-vpnclient-v4.43-9799-beta-2023.08.31-linux-x64-64bit.tar.gz

# check
if [[ -z "${URL_SE_VPN_CLIENT}" ]]; then
	# get last url
	curl -SL --output softether-links.html https://www.softether-download.com/files/softether/
	declare LIST_LINKS=$(grep -Po '(?<=HREF=")[^"]*' softether-links.html)
	rm softether-links.html
	LIST_LINKS=$(echo "$LIST_LINKS" | tr '\n' ' ')
	IFS=' ' read -r -a arraylinks <<< "$LIST_LINKS"
	SUB='/files/softether/v'
	for (( i=1; i<${#arraylinks[@]}; i=i+1)); do
		#index
		index=(-1)*${i}
		STR="${arraylinks[$index]}"
		if [[ "$STR" == *"$SUB"* ]]; then
			#urlfile=/files/softether/v4.43-9799-beta-2023.08.31-tree/
			urlfile=${STR}
			break;
		fi
	done
	#urlfile=https://www.softether-download.com/files/softether/v4.43-9799-beta-2023.08.31-tree/
	urlfile="https://www.softether-download.com${urlfile}"
	#get files.txt
	echo "=============================="
	echo "Download version: ${urlfile}"
	echo "=============================="
	curl -SL --output files.txt ${urlfile}files.txt
	LINK_FILE=$(cat files.txt | grep FILENAME | grep Linux | grep SoftEther_VPN_Client | grep AMD64)
	rm files.txt
	LINK_FILE=($LINK_FILE)
	# LINK_FILE=Linux/SoftEther_VPN_Client/64bit_-_Intel_x64_or_AMD64/softether-vpnclient-v4.43-9799-beta-2023.08.31-linux-x64-64bit.tar.gz
	LINK_FILE=$(echo ${LINK_FILE[1]})
	urlfile="${urlfile}${LINK_FILE}"
	#delete CR and LF
	urlfile=$(echo ${urlfile} | sed 's/\r$//')
	#
	URL_SE_VPN_CLIENT="${urlfile}"
fi
# download
echo "=============================="
echo "Download file: '${URL_SE_VPN_CLIENT}'"
echo "=============================="
#
curl -SL --output softether-vpnclient.tar.gz ${URL_SE_VPN_CLIENT}
file softether-vpnclient.tar.gz
tar -xvzf softether-vpnclient.tar.gz -C softethervpn
rm softether-vpnclient.tar.gz
echo "==============================================="
echo "Successfully"
exit 0;