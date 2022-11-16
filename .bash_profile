currentdir=$(pwd)
targetdir='Documents/Repositories/Repositories - GitLab/'
LBLUE='\033[1;34m'
RED='\033[1;31m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m'

echo -e "> ${LBLUE}Your current directory:\n${NC}>> ${YELLOW}${currentdir}${NC}\n"

if [ "$SSH_AUTH_SOCK" ] ; then
	echo -e "${CYAN}Welcome to GitLab!${NC}"
else
	echo -e "> ${RED}Warning: ssh-agent innactive\r${NC}
> There is a bug with logging into GitLab repositoiries using a passphrase\r
  protected ssh-key where VSCode will not properly track ssh-agent instances\r
  and continually ask for the passphrase.\r
> To resolve, start a bash terminal from the desktop and\r
  ${CYAN}run the following commands:${NC}\r
> cd ${YELLOW}\"$targetdir${LBLUE}{your repository}${YELLOW}\"${NC}\r
> ${YELLOW}~/VSCode_gitlab.sh${NC}"
fi
