#!/bin/bash

#compile this program using chmod +x ~/VSCode_gitlab.sh
currentdir=$(pwd)
targetdir='Desktop/Repositories/Repositories - GitLab/'
LBLUE='\033[1;34m'
RED='\033[1;31m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m'

#replace the $targetdir path with your own machines, where your gitlab repos are under
if [ -z "$SSH_AUTH_SOCK" ] && [[ $currentdir == *$targetdir* ]] ; then
    echo -e "${CYAN}Connecting to ssh-agent\r"
    eval `ssh-agent -s`
    echo -e "${NC}"
    ssh-add
    ssh -T git@gitlab.com

    code
else
	echo -e "> ${RED}****Warning****\r${NC}
> Current directory is not a Git repository. Please rerun this bash program\r
  in a Git repository path to run the connection agent for your session.\r
> 1. close VSCode,\r
> 2. start a bash terminal from the desktop, and\r
> 3. ${CYAN}run the following commands:${NC}\r
> cd ${YELLOW}\"$targetdir${LBLUE}{your repository}${YELLOW}\"${NC}\r
> ${YELLOW}~/VSCode_gitlab.sh${NC}"
fi
