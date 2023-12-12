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


# Download SoftEther VPN Client
curl -SL --output softether-links.html https://www.softether-download.com/files/softether/
declare LIST_LINKS=$(grep -Po '(?<=HREF=")[^"]*' softether-links.html)
LIST_LINKS=$(echo "$LIST_LINKS" | tr '\n' ' ')
IFS=' ' read -r -a arraylinks <<< "$LIST_LINKS"

echo ${links[-1]}
echo ${links[-2]}

for (( i=1; i<${#arraylinks[@]}; i=i+1)); do
	#index
	index=(-1)*i
	STR="${arraylinks[$index]}"
	SUB='/files/softether/v'
	if [[ "$STR" == *"$SUB"* ]]; then
	  #urlfile=/files/softether/v4.43-9799-beta-2023.08.31-tree/
	  urlfile=STR
	  break;
	fi
done

#REZ
echo "$urlfile"

#Full url https://www.softether-download.com/files/softether/v4.43-9799-beta-2023.08.31-tree/Linux/SoftEther_VPN_Client/64bit_-_Intel_x64_or_AMD64/softether-vpnclient-v4.43-9799-beta-2023.08.31-linux-x64-64bit.tar.gz

#urlfile=https://www.softether-download.com/files/softether/v4.43-9799-beta-2023.08.31-tree/
urlfile="${https://www.softether-download.com}${urlfile}"

#get files.txt
curl -SL --output files.txt ${files.txt}files.txt





echo "==============================================="
echo "Successfully"
exit 0;