#!/bin/bash
#Ejecutar en el equipo local
USER="root"
HOST="192.168.1.115"
KEY="./"$USER"_key"

#Copiar al servidor la configuracion de postfix
scp -i $KEY ./config/main.cf $USER@$HOST:/etc/postfix/main.cf
scp -i $KEY ./config/master.cf $USER@$HOST:/etc/postfix/master.cf
#Reiniciar el servicio de postfix
ssh -i $KEY $USER@$HOST 'service postfix restart'

#Copiar al servidor la configuracion de dovecot
scp -i $KEY ./config/dovecot.conf $USER@$HOST:/etc/dovecot/dovecot.conf
scp -i $KEY ./config/10-mail.conf $USER@$HOST:/etc/dovecot/conf.d/10-mail.conf
scp -i $KEY ./config/20-pop3.conf $USER@$HOST:/etc/dovecot/conf.d/20-pop3.conf
#Reiniciar el servicio de dovecot
ssh -i $KEY $USER@$HOST 'service dovecot restart'
