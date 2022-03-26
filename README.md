# SteamCMD in Docker optimized for Unraid
This Docker will download and install SteamCMD. It will also install Necesse and run it.

**ATTENTION:** First Startup can take very long since it downloads the gameserver files!

**Update Notice:** Simply restart the container if a newer version of the game is available.

>**WEB CONSOLE:** You can connect to the Necesse console by opening your browser and go to HOSTIP:9023 (eg: 192.168.1.1:9023) or click on WebUI on the Docker page within Unraid.

## Example Env params
| Name | Value | Example |
| --- | --- | --- |
| STEAMCMD_DIR | Folder for SteamCMD | /serverdata/steamcmd |
| SERVER_DIR | Folder for gamefile | /serverdata/serverfiles |
| GAME_ID | The GAME_ID that the container downloads at startup. If you want to install a static or beta version of the game change the value to: '1169370 -beta YOURBRANCH' (without quotes, replace YOURBRANCH with the branch or version you want to install). | 1169370 |
| WORLD_NAME | Specify the world name here (your worlds are saved in .../.config/Necesse/saves/) | World |
| GAME_PARAMS | Enter your extra startup parameters here if needed | empty |
| UID | User Identifier | 99 |
| GID | Group Identifier | 100 |
| VALIDATE | Validates the game data | true |
| USERNAME | Leave blank for anonymous login | blank |
| PASSWRD | Leave blank for anonymous login | blank |

## Run example
```
docker run --name Necesse -d \
	-p 14159:14159/udp -p 9023:8080 \
	--env 'GAME_ID=1169370' \
	--env 'WORLD_NAME=World' \
	--env 'UID=99' \
	--env 'GID=100' \
	--volume /path/to/steamcmd:/serverdata/steamcmd \
	--volume /path/to/necesse:/serverdata/serverfiles \
	ich777/steamcmd:necesse
```

This Docker was mainly edited for better use with Unraid, if you don't use Unraid you should definitely try it!


This Docker is forked from mattieserver, thank you for this wonderfull Docker.


#### Support Thread: https://forums.unraid.net/topic/79530-support-ich777-gameserver-dockers/