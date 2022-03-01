#!/bin/bash
if [ ! -f ${STEAMCMD_DIR}/steamcmd.sh ]; then
  echo "SteamCMD not found!"
  wget -q -O ${STEAMCMD_DIR}/steamcmd_linux.tar.gz http://media.steampowered.com/client/steamcmd_linux.tar.gz 
  tar --directory ${STEAMCMD_DIR} -xvzf /serverdata/steamcmd/steamcmd_linux.tar.gz
  rm ${STEAMCMD_DIR}/steamcmd_linux.tar.gz
fi

echo "---Update SteamCMD---"
if [ "${USERNAME}" == "" ]; then
  ${STEAMCMD_DIR}/steamcmd.sh \
  +login anonymous \
  +quit
fi

echo "---Update Server---"
cd ${SERVER_DIR}
if [ ! -f ${SERVER_DIR}/Longvinter/Binaries/Linux/LongvinterServer-Linux-Shipping ]; then
  git clone https://github.com/Uuvana-Studios/longvinter-linux-server.git ${SERVER_DIR}
elif git merge-base --is-ancestor origin/main main ; then
  echo "---Nothing to do, game up to date!---"
else
  echo "---Updating game, please wait!---"
  git restore
  sleep 1
  git pull "https://github.com/Uuvana-Studios/longvinter-linux-server.git" main
fi

echo "---Prepare Server---"
if [ ! -f ${DATA_DIR}/.steam/sdk64/steamclient.so ]; then
  if [ ! -d ${DATA_DIR}/.steam/sdk64 ]; then
    mkdir -p ${DATA_DIR}/.steam/sdk64
  fi
  cp -R ${STEAMCMD_DIR}/linux64/* ${DATA_DIR}/.steam/sdk64/
fi
if [ ! -f ${SERVER_DIR}/Longvinter/Saved/Config/LinuxServer/Game.ini ]; then
    echo "---No config file found, creating...---"
    echo "[/Game/Blueprints/Server/GI_AdvancedSessions.GI_AdvancedSessions_C]
ServerName=Longvinter Docker
MaxPlayers=32
ServerMOTD=Welcome to Longvinter running in Docker!
Password=Docker
CommunityWebsite=unraid.net

[/Game/Blueprints/Server/GM_Longvinter.GM_Longvinter_C]
AdminSteamID=" > ${SERVER_DIR}/Longvinter/Saved/Config/LinuxServer/Game.ini
fi
chmod -R ${DATA_PERM} ${DATA_DIR}
chmod +x ${SERVER_DIR}/Longvinter/Binaries/Linux/LongvinterServer-Linux-Shipping
echo "---Server ready---"

echo "---Start Server---"
cd ${SERVER_DIR}
${SERVER_DIR}/Longvinter/Binaries/Linux/LongvinterServer-Linux-Shipping Longvinter QueryPort=${GAME_PORT} ${GAME_PARAMS}