# spigot-installer-on-termux
Install Spigot on termux.

## Install

To prevent the number of files in the directory from increasing, create a folder with a name of your choice and move the working folder.

```
mkdir spigot-server
cd spigot-server
```

```
pkg update -y && pkg install wget curl proot tar -y && wget https://raw.githubusercontent.com/Lv0Yuyu/spigot-installer-on-termux/main/ubuntu22.sh -O ubuntu22.sh && chmod +x ubuntu22.sh && bash ubuntu22.sh
```

If you are asked about storage during the installation, type y and press enter.

