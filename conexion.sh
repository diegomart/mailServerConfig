#!/bin/bash
USER="roboto"
HOST="192.168.1.115"
KEY="./"$USER"_key"

ssh-keygen -t rsa -f $KEY
ssh-copy-id -i $KEY.pub $USER@$HOST
scp -i $KEY ./config/sshd_config $USER@$HOST:/etc/ssh/sshd_config
ssh $USER@$HOST 'service sshd restart'
