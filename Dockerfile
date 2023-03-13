FROM cm2network/steamcmd
USER root
ARG PUID=1000
ARG PGID=1000
# Umask for files created by steamcmd during server installs
# It will NOT cover files that are created by server executables!
ENV UMASK=027
ENV HOME_DIR=${HOMEDIR}
ENV STEAMCMD_DIR=${STEAMCMDDIR}
ENV SERVER_DIR="${HOMEDIR}/server"
# IMAGE_DIR are files that are moved into SERVER_DIR at runtime
# The purpose of it is for baking custom start/update scripts into your 
# images and having them still appear in the server/ volume.
ENV IMAGE_DIR="${HOMEDIR}/image"
# For referencing inside server scripts in conjunction with IMAGE_DIR / SERVER_DIR. 
# This just allows us to give them different names in the future.
ENV STEAMCMD_UPDATE_SCRIPT="steam_update.txt"
ENV UPDATE_SCRIPT="update.sh"
ENV START_SCRIPT="start.sh"
# You need to integrate these in your server images
ENV APP_ID=
ENV START_ARGS=
COPY /start.sh /start.sh
RUN usermod -u ${PUID} ${USER} &&\
    groupmod -g ${PGID} ${USER} &&\
    chown ${USER}:${USER} /start.sh &&\
    chmod +x /start.sh &&\
    mkdir "${SERVER_DIR}" &&\
    chown ${USER}:${USER} "${SERVER_DIR}"
WORKDIR "${SERVER_DIR}"
USER ${USER}
CMD ["/start.sh"]
