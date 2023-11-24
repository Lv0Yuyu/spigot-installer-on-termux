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

# After Installed
You will automatically be redirected to the main screen of spigot installer.  You can enter any action number.

## Install spigot alone

 Type 1 and press enter to see the versions of spigot available for installation.  Enter the version code you want to install and press Enter to start the installation automatically.

 Old spigots do not check the eula and start the server as is, so please stop it with stop or CTRL+C.

 Otherwise, you will be asked to agree to the eula, so check the eula, enter yes, and press enter.

 The installation is now complete.

 ## Allow integrated players to enter the world.

 Type 2 and enter to automatically install the geyser floodgate plugin.

 If there is an existing plugin, it will be overwritten when this section is executed without checking its version.

 Once the installation is complete, the plugin will be automatically applied when you start the server.

 ### For old spigots

 The geyser plugin may not be applicable to older Spigots.

 In this case, perform the sections in the order 1 > 2 > 10 > 3.

 10: do not stop the server until you see the message enabling floodgate in the logs.  Once done, close the server.

 3: installs geyser standalone.

 Wait for a while and if `[WARN]` does not appear in the log, the installation was successful.

 press to enter... \[enter].

 Please open another tab and run standalone.

 ## Include it regardless of version

 Type 4 and enter.
 The viaversion plugin will be installed.

 Plugins are automatically applied when you start the server.


# Repo
Original ubuntu22.sh: AndronixApp/AndronixOrigin

### memo
spigot server is installed and runs on ubuntu22 on proot.  Be sure to remember the installation directory.
