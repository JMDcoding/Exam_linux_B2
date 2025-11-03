#!/bin/bash
USER_HOME="/home/bob"
BASHRC="$USER_HOME/.bashrc"
FILTER_SCRIPT="$USER_HOME/filter_404.sh"

(crontab -l 2>/dev/null; echo "*/2 * * * * $FILTER_SCRIPT") | crontab -

echo "Cron ajouté : exécution de $FILTER_SCRIPT toutes les 2 minutes."
cp "$BASHRC" "$BASHRC.backup_$(date +%F_%T)"


cat << 'EOF' >> "$BASHRC"

PS1='\[\e[1;36m\]\u@\h:\[\e[1;33m\]\w\[\e[0m\]\$ '
alias ls='ls --color=auto'
EOF

echo " Personnalisation du bashrc terminée."
echo " Recharge le bashrc avec : source ~/.bashrc"

