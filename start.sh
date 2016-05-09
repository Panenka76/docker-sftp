#!/bin/sh

# ensure the sftponly group exists
getent group sftponly || groupadd sftponly

# ensure all our users exist
if [ -d /opt/ssh/authorized_keys ]; then
	for USER in `ls -1 /opt/ssh/authorized_keys`; do
		ID=`id -u "$USER"`
		HOMEDIR="/opt/ssh/data/$USER"
		if [ -z "$ID" ]; then
			useradd -g sftponly -d $HOMEDIR "$USER"
		fi
		mkdir -p $HOMEDIR && chown -R "$USER" $HOMEDIR
		chown root:root $HOMEDIR
		mkdir -p $HOMEDIR/upload
		chown $USER $HOMEDIR/upload
		chmod 0750 $HOMEDIR/upload
		chown $USER /opt/ssh/authorized_keys/$USER
		chmod 0600 /opt/ssh/authorized_keys/$USER
	done
fi

chmod 600 /opt/ssh/server-keys/*
chmod 644 /opt/ssh/server-keys/*.pub
chmod 755 /opt/ssh/authorized_keys

/usr/sbin/sshd -e -D -f /opt/ssh/config/sshd
