#!/bin/bash
#Ejecutar en el equipo local
USER="root"
HOST="192.168.1.115"
KEY="./"$USER"_key"

#Subir al servidor la configuracion de fail2ban
scp -i $KEY ./config/jail.local $USER@$HOST:/etc/fail2ban/jail.local
#Reiniciar el servicio de fail2ban
ssh -i $KEY $USER@$HOST 'service fail2ban restart'
