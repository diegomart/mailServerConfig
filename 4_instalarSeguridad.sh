#!/bin/bash
#Ejecutar en el servidor
sudo su
#Instalar el servicio de iptables y wget
yum install -y iptables-services wget
#Reiniciar la configuración de iptables
mv /etc/sysconfig/iptables /etc/sysconfig/iptables.def
#Abrir puerto 22
iptables -A INPUT -p tcp -m tcp --dport 22 -j ACCEPT
#Abrir puerto 465
iptables -A INPUT -p tcp -m tcp --dport 465 -j ACCEPT
#Abrir puerto 995
iptables -A INPUT -p tcp -m tcp --dport 995 -j ACCEPT
#Almacenar la configuracion de iptables
service iptables save
#Reiniciar iptables
service iptables restart

#Instalar fail2ban
wget dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-2.noarch.rpm
rpm -ivh epel-release-7-2.noarch.rpm
yum install -y fail2ban
#Copiar el archivo de configuracion de fail2ban
cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local

