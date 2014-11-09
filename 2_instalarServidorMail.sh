#!/bin/bash
#Ejecutar en el servidor
#Poner el nombre del usuario a crear
USER=jonx

sudo su

#Actualizar el SO
yum update -y
#Instalar el software
yum install -y vim postfix dovecot cyrus-sasl cyrus-sasl-devel cyrus-sasl-gssapi cyrus-sasl-md5 cyrus-sasl-plain

#Crear llaves ssl para el servicio de smtp
mkdir /etc/postfix/ssl
cd /etc/postfix/ssl/
openssl genrsa -des3 -rand /etc/hosts -out smtpd.key 1024
chmod 600 smtpd.key
openssl req -new -key smtpd.key -out smtpd.csr
openssl x509 -req -days 365 -in smtpd.csr -signkey smtpd.key -out smtpd.crt
openssl rsa -in smtpd.key -out smtpd.key.unencrypted
mv -f smtpd.key.unencrypted smtpd.key
openssl req -new -x509 -extensions v3_ca -keyout cakey.pem -out cacert.pem -days 365

#Crear usuario de correo
useradd -m $USER -s /sbin/nologin
#Establecer la contrasena del usuario
passwd $USER

#reiniciar servicios
service postfix restart
service dovecot restart
service saslauthd restart
#indicar que deben de arrancar los servicios al iniciar el SO
chkconfig --level 235 postfix on
chkconfig --level 235 dovecot on
chkconfig --level 235 saslauthd on

