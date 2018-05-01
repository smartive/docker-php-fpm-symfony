#!/usr/bin/env bash

ssh-agent-check () {
    [ -S "$SSH_AUTH_SOCK" ] && { ssh-add -l >& /dev/null || [ $? -ne 2 ]; }
}

ssh-agent-start () {
    SSH_AGENT_ENV_FILE=/var/tmp/ssh-agent.env
    [ ! -f $SSH_AGENT_ENV_FILE ] && touch $SSH_AGENT_ENV_FILE

    ssh-agent-check || export SSH_AUTH_SOCK="$(< $SSH_AGENT_ENV_FILE)"
    ssh-agent-check || {
        eval "$(ssh-agent -s)" > /dev/null
        echo "$SSH_AUTH_SOCK" > $SSH_AGENT_ENV_FILE
    }
}

ssh-agent-bashrc () {
    grep -q "# added by ssh-agent\.sh" /root/.bashrc || {
        echo -e "\nsource /root/ssh-agent.sh; ssh-agent-start # added by ssh-agent.sh\n" \
            >> /root/.bashrc
    }
}

ssh-agent-key-exists () {
    ssh-add -l | grep -q "/root/.ssh/id_rsa"
}
