kill $(ps | grep ssh-agent | tr -s " " | cut -d " " -f 2)
