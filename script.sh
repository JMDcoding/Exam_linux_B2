#!/bin/bash
installer_mariadb() {
    echo "Installation de MariaDB..."
    apt update
    apt install -y mariadb-server
    echo "MariaDB installé avec succès !"
}
if ! command -v mariadb >/dev/null 2>&1; then
    echo "MariaDB non trouvé. Installation..."
    installer_mariadb
else
    echo "MariaDB est déjà installé."
fi
