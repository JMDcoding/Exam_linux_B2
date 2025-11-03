# Partie 2 - APPLICATIF
 
## Fichiers créés :
- `/home/bob/test_apache.sh` - Script de test Apache
- `/home/bob/filter_404.sh` - Script de filtrage 404
- `/etc/profile.d/start_apache.sh` - Démarrage auto Apache
 
## Configurations modifiées :
- Apache écoute sur port 8080
- Apache démarre automatiquement
 
## Commandes exécutées :
            a. En tant que bob, installer et lancer apache
# Se connecter en tant que bob
su - bob
 
# Installer Apache
sudo apt update
sudo apt install apache2 -y
 
# Démarrer Apache
sudo service apache2 start
 
# Vérifier que ça tourne
sudo service apache2 status
 
            b. Modifier la configuration pour que le serveur apache se lance sur le port
8080
 
# Éditer le fichier des ports
sudo nano /etc/apache2/ports.conf
#Dans nano, j'ai changé Listen 80 en Listen 8080, puis sauvegardé (Ctrl+O, Entrée, Ctrl+X).
# Éditer le VirtualHost
sudo nano /etc/apache2/sites-available/000-default.conf
#Changé <VirtualHost *:80> en <VirtualHost *:8080>, puis sauvegardé.
# Redémarrer Apache
sudo service apache2 restart
 
            c. Créer un script avec une boucle for faisant 20 appels curl sur le serveur
apache sur la route / (return code http 200) et la route /test (return code
http 404)
 
# Créer le fichier
nano ~/test_apache.sh
 
#mis ce contenue :
#!/bin/bash
 
for i in {1..20}; do
    echo "=== Appel $i ==="
    echo "Test de la route /"
    curl -s -o /dev/null -w "Code HTTP: %{http_code}\n" http://localhost:8080/
    echo "Test de la route /test"
    curl -s -o /dev/null -w "Code HTTP: %{http_code}\n" http://localhost:8080/test
    echo ""
done
 
echo "Tests terminés !"
 
#sauvegarde et rend executable
chmod +x ~/test_apache.sh
#lancer le script
~/test_apache.sh
 
            d. Créer un script filtrant les code http 404 des logs apaches et redirigeant les
logs associés dans le home de bob
#Créer le script de filtrage des 404
# Ajouter bob au groupe adm pour lire les logs
sudo usermod -a -G adm bob
 
# Se reconnecter pour appliquer le groupe
exit
su - bob
 
# Créer le script
nano ~/filter_404.sh
 
#mis ce contenu
#!/bin/bash
 
LOG_FILE="/var/log/apache2/access.log"
OUTPUT_FILE="/home/bob/apache_404.log"
 
grep " 404 " "$LOG_FILE" > "$OUTPUT_FILE"
 
echo "Filtrage des erreurs 404 terminé. Résultats dans $OUTPUT_FILE"
#rend executable et test :
chmod +x ~/filter_404.sh
~/filter_404.sh
cat ~/apache_404.log
 
            e. Modifier le service apache pour qu’il se lance au lancement de la machine
 
sudo systemctl enable apache2
echo "service apache2 start" | sudo tee -a /etc/profile.d/start_apache.sh
sudo chmod +x /etc/profile.d/start_apache.sh
 