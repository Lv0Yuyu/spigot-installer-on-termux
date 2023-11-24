#!/bin/bash

basedir=`pwd`

# Colors
black=$(tput setaf 0)
red=$(tput setaf 1)
green=$(tput setaf 2)
yellow=$(tput setaf 3)
blue=$(tput setaf 4)
magenta=$(tput setaf 5)
cyan=$(tput setaf 6)
white=$(tput setaf 7)

# Background colors
bg_black=$(tput setab 0)
bg_red=$(tput setab 1)
bg_green=$(tput setab 2)
bg_yellow=$(tput setab 3)
bg_blue=$(tput setab 4)
bg_magenta=$(tput setab 5)
bg_cyan=$(tput setab 6)
bg_white=$(tput setab 7)

reset=$(tput sgr0)


function showHeader {
echo " ========================================="
echo "|                                         |"
echo "|        ${yellow}Spigot installer${reset} on ${green}Termux${reset}       |"
echo "|                                         |"
echo "|            lv0 [v0.1.autorun]           |"
echo "|                                         |"
echo " ========================================="
echo
echo -n "current directory: " && pwd
echo -n "machine is: " && uname -a
echo
}

function plugin {
	local bef
	local pluginUrl
	local exitcode
	exitcode=0
	declare -A pluginUrl
	pluginUrl["geyser-spigot"]="https://download.geysermc.org/v2/projects/geyser/versions/latest/builds/latest/downloads/spigot"
	pluginUrl["floodgate-spigot"]="https://download.geysermc.org/v2/projects/floodgate/versions/latest/builds/latest/downloads/spigot"
	pluginUrl["viaversion-4.8.1"]="https://github.com/ViaVersion/ViaVersion/releases/download/4.8.1/ViaVersion-4.8.1.jar"
	bef=`pwd`
	mkdir plugins
	cd plugins
	
	case $1 in

	help)
		echo "-- Internal Plugin Manager --"
		echo 
		echo " > plugin install [plugin name]"
		echo " > plugin remove [plugin name]"
		echo " > plugin list [all | installed]"
		echo
		;;	
	
	install)
		local name=$2
		echo "${blue}plugin installing: ${name}${reset}"
		wget "${pluginUrl[${name}]}" -O "${name}.jar"
		sleep 1
		if [ $? -eq 0 ]; then
			echo "${green}plugin installed!${reset}"
			exitcode=0
		else
			echo "${red}plugin install failed...${reset}"
			exitcode=1
		fi
		sleep 3
		;;

	remove)
		local name=$2
		if [ -e "${name}.jar" ]; then
			rm "${name}.jar"
		
			if [ $? -eq 0 ]; then
				sleep 1
				echo "${green}[OK] plugin ${blue}${name}${green} is removed (option directory is not removed)${reset}"
				sleep 3
				exitcode=0
			else
				sleep 1
				echo "${red}[ERR] failed remove plugin ${blue}${name}${reset}"
				exitcode=1
			fi

		else
			echo "${red}[ERR] not exist ${blue}${name}${reset}"
		    exitcode=1
		fi
		;;

	list)
		if [ $2 = "installed" ]; then
			echo " ${blue}* Installed plugins${reset}"
			for file in *; do
			    if [ -f "$file" ]; then
			        echo "  - ${green}${file%.*}${reset}"
			    fi
			done
		else
			echo " ${blue}* Available plugins${reset}"
			for key in "${!pluginUrl[@]}"; do
			  echo "  - ${green}$key${reset}"
			done
		fi
		;;
	
	*)
		echo Type help to see a list of commands.
		;;
	esac
	
	cd "${bef}"
	return $exitcode
}




echo [INFO] Start package updates and installation
sleep 1

apt update -y && apt upgrade -y
apt install micro curl wget openjdk-19-jdk -y

if [ $? -eq 0 ]; then
  echo
  echo "${green}[OK]${reset} Package updates and installation of required packages completed"
  sleep 2
else
  echo
  echo "${red}[ERR]${reset} Failed to install required packages"
  exit 1
fi

# Versions URL

declare -A versions
versions=(
 ["1.20.2"]="https://download.getbukkit.org/spigot/spigot-1.20.2.jar"
 ["1.20.1"]="https://download.getbukkit.org/spigot/spigot-1.20.1.jar"
 ["1.19.4"]="https://download.getbukkit.org/spigot/spigot-1.19.4.jar"
 ["1.19.3"]="https://download.getbukkit.org/spigot/spigot-1.19.3.jar"
 ["1.19.2"]="https://download.getbukkit.org/spigot/spigot-1.19.2.jar"
 ["1.19.1"]="https://download.getbukkit.org/spigot/spigot-1.19.1.jar"
 ["1.19"]="https://download.getbukkit.org/spigot/spigot-1.19.jar"
 ["1.18.2"]="https://download.getbukkit.org/spigot/spigot-1.18.2.jar"
 ["1.18.1"]="https://download.getbukkit.org/spigot/spigot-1.18.1.jar"
 ["1.18"]="https://download.getbukkit.org/spigot/spigot-1.18.jar"
 ["1.17.1"]="https://download.getbukkit.org/spigot/spigot-1.17.1.jar"
 ["1.17"]="https://download.getbukkit.org/spigot/spigot-1.17.jar"
 ["1.16.5"]="https://cdn.getbukkit.org/spigot/spigot-1.16.5.jar"
 ["1.16.4"]="https://cdn.getbukkit.org/spigot/spigot-1.16.4.jar"
 ["1.16.3"]="https://cdn.getbukkit.org/spigot/spigot-1.16.3.jar"
 ["1.16.2"]="https://cdn.getbukkit.org/spigot/spigot-1.16.2.jar"
 ["1.16.1"]="https://cdn.getbukkit.org/spigot/spigot-1.16.1.jar"
 ["1.15.2"]="https://cdn.getbukkit.org/spigot/spigot-1.15.2.jar"
 ["1.15.1"]="https://cdn.getbukkit.org/spigot/spigot-1.15.1.jar"
 ["1.15"]="https://cdn.getbukkit.org/spigot/spigot-1.15.jar"
 ["1.14.4"]="https://cdn.getbukkit.org/spigot/spigot-1.14.4.jar"
 ["1.14.3"]="https://cdn.getbukkit.org/spigot/spigot-1.14.3.jar"
 ["1.14.2"]="https://cdn.getbukkit.org/spigot/spigot-1.14.2.jar"
 ["1.14.1"]="https://cdn.getbukkit.org/spigot/spigot-1.14.1.jar"
 ["1.14"]="https://cdn.getbukkit.org/spigot/spigot-1.14.jar"
 ["1.13.2"]="https://cdn.getbukkit.org/spigot/spigot-1.13.2.jar"
 ["1.13.1"]="https://cdn.getbukkit.org/spigot/spigot-1.13.1.jar"
 ["1.13"]="https://cdn.getbukkit.org/spigot/spigot-1.13.jar"
 ["1.12.2"]="https://cdn.getbukkit.org/spigot/spigot-1.12.2.jar"
 ["1.12.1"]="https://cdn.getbukkit.org/spigot/spigot-1.12.1.jar"
 ["1.12"]="https://cdn.getbukkit.org/spigot/spigot-1.12.jar"
 ["1.11.2"]="https://cdn.getbukkit.org/spigot/spigot-1.11.2.jar"
 ["1.11.1"]="https://cdn.getbukkit.org/spigot/spigot-1.11.1.jar"
 ["1.11"]="https://cdn.getbukkit.org/spigot/spigot-1.11.jar"
 ["1.10.2"]="https://cdn.getbukkit.org/spigot/spigot-1.10.2-R0.1-SNAPSHOT-latest.jar"
 ["1.10"]="https://cdn.getbukkit.org/spigot/spigot-1.10-R0.1-SNAPSHOT-latest.jar"
 ["1.9.4"]="https://cdn.getbukkit.org/spigot/spigot-1.9.4-R0.1-SNAPSHOT-latest.jar"
 ["1.9.2"]="https://cdn.getbukkit.org/spigot/spigot-1.9.2-R0.1-SNAPSHOT-latest.jar"
 ["1.9"]="https://cdn.getbukkit.org/spigot/spigot-1.9-R0.1-SNAPSHOT-latest.jar"
 ["1.8.8"]="https://cdn.getbukkit.org/spigot/spigot-1.8.8-R0.1-SNAPSHOT-latest.jar"
 ["1.8.7"]="https://cdn.getbukkit.org/spigot/spigot-1.8.7-R0.1-SNAPSHOT-latest.jar"
 ["1.8.6"]="https://cdn.getbukkit.org/spigot/spigot-1.8.6-R0.1-SNAPSHOT-latest.jar"
 ["1.8.5"]="https://cdn.getbukkit.org/spigot/spigot-1.8.5-R0.1-SNAPSHOT-latest.jar"
 ["1.8.4"]="https://cdn.getbukkit.org/spigot/spigot-1.8.4-R0.1-SNAPSHOT-latest.jar"
 ["1.8.3"]="https://cdn.getbukkit.org/spigot/spigot-1.8.3-R0.1-SNAPSHOT-latest.jar"
 ["1.8"]="https://cdn.getbukkit.org/spigot/spigot-1.8-R0.1-SNAPSHOT-latest.jar"
 ["1.7.10"]="https://cdn.getbukkit.org/spigot/spigot-1.7.10-SNAPSHOT-b1657.jar"
 ["1.7.9"]="https://cdn.getbukkit.org/spigot/spigot-1.7.9-R0.2-SNAPSHOT.jar"
 ["1.7.8"]="https://cdn.getbukkit.org/spigot/spigot-1.7.8-R0.1-SNAPSHOT.jar"
 ["1.7.5"]="https://cdn.getbukkit.org/spigot/spigot-1.7.5-R0.1-SNAPSHOT-1387.jar"
 ["1.7.2"]="https://cdn.getbukkit.org/spigot/spigot-1.7.2-R0.4-SNAPSHOT-1339.jar"
 ["1.6.4"]="https://cdn.getbukkit.org/spigot/spigot-1.6.4-R2.1-SNAPSHOT.jar"
 ["1.6.2"]="https://cdn.getbukkit.org/spigot/spigot-1.6.2-R1.1-SNAPSHOT.jar"
 ["1.5.2"]="https://cdn.getbukkit.org/spigot/spigot-1.5.2-R1.1-SNAPSHOT.jar"
 ["1.5.1"]="https://cdn.getbukkit.org/spigot/spigot-1.5.1-R0.1-SNAPSHOT.jar"
 ["1.4.7"]="https://cdn.getbukkit.org/spigot/spigot-1.4.7-R1.1-SNAPSHOT.jar"
 ["1.4.6"]="https://cdn.getbukkit.org/spigot/spigot-1.4.6-R0.4-SNAPSHOT.jar"
)

geyser_standalone="https://download.geysermc.org/v2/projects/geyser/versions/latest/builds/latest/downloads/standalone"
#i="apple"
#echo ${data[$i]}




# loop

while true; do
cd $basedir
clear && showHeader

echo "  1. ${yellow}install spigot${reset}"
echo "  2. install geyser-spigot & floodgate-spigot"
echo "  3. install geyser-standalone & floodgate-spigot"
echo "  4. install ViaVersion"
echo " 10. ${yellow}start spigot server (./start.sh)${reset}"
echo " 11. start geyser-standalone (./geyser/start.sh)"
echo " 20. edit startscript spigot"
echo " 21. edit startscript geyser-standalone"
echo " 22. edit config server.properties"
echo " 23. ${yellow}edit config spigot${reset}"
echo " 24. edit config geyser (plugin ver)"
echo " 25. edit config geyser (standalone ver)"
echo " 26. edit config floodgate"
echo " 27. edit config viaversion"
echo " 50. disable installer autorun"
echo "  0. exit installer"
echo " help. about installer"
echo
echo " *In edit mode,"
echo "  [press CTRL+s to save] [CTRL+q to exit]"
echo
read -p "  Action: " n

clear && showHeader

case $n in
1)
  echo "${blue} * Available versions${green}"
  for key in "${!versions[@]}"; do
    echo -en "$key \t"
  done
  
  echo "${reset}"
  read -p "  Input spigot version(ex. 1.20.2): " version
  wget "${versions[${version}]}" -O spigot.jar
  if [ $? -eq 0 ]; then
    rm eula.txt
    java -jar spigot.jar
    echo
    cat eula.txt
    echo 
    read -p "Do you accept the EULA? (yes|no): " yn
    if [ $yn = "yes" ]; then
      sed -e "s/eula=false/eula=true/g" eula.txt > eula.txt.new
      cp eula.txt.new eula.txt
      rm eula.txt.new
      echo "java -Xms2G -Xmx2G -XX:+UseG1GC -jar spigot.jar" > start.sh
      chmod +x start.sh
      echo
      sleep 1
      echo "${green}[OK] Spigot installed${reset}"
      echo "You can start server >> ${blue}./start.sh${reset}"
      sleep 5
    else
      echo eula aborted by user
      exit 0
    fi
  else
    echo "${red}[ERR]${reset} Not found v${version}"
    sleep 3
  fi
  ;;

  
2)
  plugin install geyser-spigot
  plugin install floodgate-spigot
  ;;
  
3)
  plugin install floodgate-spigot
  mkdir geyser
  cd geyser
  wget "${geyser_standalone}" -O geyser-standalone.jar
  sleep 1
  if [ $? -eq 0 ]; then
    java -jar geyser-standalone.jar > geyser.tmp &
    pid=$!
    
    echo "${green}[OK] execute ${blue}geyser-standalone.jar${reset}"
    echo "${green}[INFO] startup process running${reset}"
    
    while true; do

      echo startup checking...
      grep 'Started' geyser.tmp
      if [ $? -eq 0 ]; then
        rm geyser.tmp
        echo proccess exit
        kill -s SIGKILL $pid
        echo "${green}OK. startup successful!${reset}"
        sleep 1
        
        echo 'cd geyser && java -jar geyser-standalone.jar' > start.sh
        chmod +x start.sh
        echo "${green}[OK] you can execute geyser-standalone >> ${blue}./geyser/start.sh${reset}"
    
        cd $basedir
        sleep 1
        cp plugins/floodgate/key.pem geyser/
        if [ $? -eq 0 ]; then
          echo "${green}[OK] key.pem has been successfully cloned to geyser-standalone.${reset}"
        else
          echo "${yellow}[WARN] Failed to clone key.pem to geyser-standalone.  It is possible that you have not started the server once with the floodgate plugin installed.  Please start the server once with the floodgate plugin installed and run this option again.${reset}"
          # TODO:  サーバーを実行したうえで、オートセットアップするように。
        fi
        read -p 'press to enter...' x
        break
      fi
      
      grep 'ERROR' geyser.tmp
      if [ $? -eq 0 ]; then
        clear
        echo "${red}[ERROR] It seems that some error has occurred."
        cat geyser.tmp
        rm geyser.tmp
        echo
        cd $basedir
        read -p 'press to enter...' x
        break
      fi

      sleep 1
    done
    
  else
    echo "${red}[ERR] geyser-standalone download failed${reset}"
    sleep 3
  fi
  ;;

4)
  plugin install viaversion-4.8.1
  ;;
  
0)
  echo " installer exited"
  break
  ;;

  
10)
  clear
  ./start.sh
  ;;

11)
  clear
  ./geyser/start.sh
  ;;
  
20)
  micro start.sh
  ;;
21)
  micro geyser/start.sh
  ;;
22)
  micro server.properties
  ;;
23)
  micro spigot.yml
  ;;
24)
  micro plugins/Geyser-Spigot/config.yml
  ;;
25)
  micro geyser/config.yml
  ;;
26)
  micro plugins/floodgate/config.yml
  ;;
27)
  micro plugins/ViaVersion/config.yml
  ;;

help)
  echo writting...
  ;;
*)
  echo " No action"
  ;;
esac

sleep 1
done
echo
