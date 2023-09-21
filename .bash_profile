export PATH=$PATH:"C:\Users\davidcosman\executables" #change this to your PATH directory so it executes on bash startup

currentdir=$(pwd)
targetdir='Desktop/Repositories/Repositories - GitLab/'
LBLUE='\033[1;34m'
RED='\033[1;31m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m'

echo -e "> ${LBLUE}Your current directory:\n${NC}>> ${YELLOW}${currentdir}${NC}\n"

if [ "$SSH_AUTH_SOCK" ] ; then
	echo -e "${CYAN}Welcome to GitLab!${NC}"
else
	echo -e "> ${RED}Warning: ssh-agent inactive\r${NC}
> VSCode will not properly track ssh-agent instances and continually ask for\r
  the passphrase. To resolve:\r
> 1. close VSCode,\r
> 2. start a bash terminal from the desktop, and\r
> 3. ${CYAN}run the following commands:${NC}\r
> cd ${YELLOW}\"$targetdir${LBLUE}{your repository}${YELLOW}\"${NC}\r
> ${YELLOW}~/VSCode_gitlab.sh${NC}"
fi

#the following is only necessary if you connect to AWS with MFA
set-aws-mfa () {
  AWS_CLI_PROFILE=$1
  MFA_TOKEN=$2

  # Clean up any existing environment variables
  unset AWS_ACCESS_KEY_ID
  unset AWS_SECRET_ACCESS_KEY
  unset AWS_SESSION_TOKEN

  # Set the AWS profile
  export AWS_PROFILE=${AWS_CLI_PROFILE}

  if [ "$MFA_TOKEN" ]; then
    MFA_ARN=$( cat ~/.aws/mfa.conf | jq -r ".[] | select( .profile == \"$AWS_CLI_PROFILE\" ).arn" )
    
    # get the MFA session tokens
    MFA_RAW=$(aws --profile $AWS_CLI_PROFILE sts get-session-token --serial-number $MFA_ARN --token-code $MFA_TOKEN --output json)
    MFA_JSON=$(echo $MFA_RAW | jq -r .Credentials)

    MFA_ACCESS_KEY_ID=$(echo $MFA_JSON | jq -r .AccessKeyId)
    MFA_SECRET_ACCESS_KEY=$(echo $MFA_JSON | jq -r .SecretAccessKey)
    MFA_SESSION_TOKEN=$(echo $MFA_JSON | jq -r .SessionToken)

    export AWS_ACCESS_KEY_ID=${MFA_ACCESS_KEY_ID}
    export AWS_SECRET_ACCESS_KEY=${MFA_SECRET_ACCESS_KEY}
    export AWS_SESSION_TOKEN=${MFA_SESSION_TOKEN}
    
	creds="~/.aws/credentials.${AWS_CLI_PROFILE}"
	printf "[%s]\n" "${AWS_PROFILE}" > ~/.aws/credentials.${AWS_CLI_PROFILE}
	printf "aws_access_key_id=%s\n" "$MFA_ACCESS_KEY_ID"  >> ~/.aws/credentials.${AWS_CLI_PROFILE}
	printf "aws_secret_access_key=%s\n" "$MFA_SECRET_ACCESS_KEY" >> ~/.aws/credentials.${AWS_CLI_PROFILE}
	printf "aws_session_token=%s\n" "$MFA_SESSION_TOKEN" >> ~/.aws/credentials.${AWS_CLI_PROFILE}
	
	echo "Successfully updated credentials for ${AWS_CLI_PROFILE}"
  fi
}
