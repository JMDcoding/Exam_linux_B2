#bin/bash

#ajouter un crontjob qui appel toutes les deux minutes en tant que bob le script de filtrage
crontab -e
*/2 * * * * /chemin/complet/vers/script_filtrage.sh
