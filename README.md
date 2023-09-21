# personal-bash-scripts
Scripts used to automate tasks on bash startup.

## How to use
These scripts are intended to be used with bash terminals. They are to help automate secure connections to different services.

If you wish to use them, any directory references need to be changed to match your computer.

## Current use cases
* Connects using SSH agent to Gitlab repositories (supports SSH private key).
* Automatically starts an SSH session and opens VSCode with that session with only that agent active (`VSCode_gitlab.sh` script).
* Function to set aws-mfa from bash terminal (requires AWS MFA set up first).
* On bash logout, cleans up and kills all running ssh-agent processes.

~David Cosman
