#!/bin/bash
#Ejecutar en el equipo local
USER="root"
HOST="192.168.1.115"
KEY="./"$USER"_key"

#generar llave para conexion ssh
ssh-keygen -t rsa -f $KEY
#subir llave al servidor
ssh-copy-id -i $KEY.pub $USER@$HOST
#subir configuracion del ssh al servidor
scp -i $KEY ./config/sshd_config $USER@$HOST:/etc/ssh/sshd_config
#reiniciar el servicio ssh
ssh $USER@$HOST 'service sshd restart'
