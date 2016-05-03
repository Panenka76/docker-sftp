# Description

Docker image for running an OpenSSH SFTP server on Ubuntu 16.04.

# Features

- run SSH daemon on startup and log to stdout instead of syslog
- chroot all sftp users into their homedir
- by default disable root login and only allow authentication by key.
- create users and import authorized_keys

# Usage

At [startup](./start.sh), if any additional config files are available at /opt/ssh/config, they will be used to override the [defaults](./sshd_config). It would generally be a good idea to include your HostKeys here such that when your container restarts or is scheduled on a different host, it doesn't change its hostkeys.

For each file in /opt/ssh/authorized_keys a user will be created with the name as the file. The contents of the file will be considered as the authorized_keys for this user. The user will be automatically restricted to sftp only, so has no shell access.

```
/opt
  /ssh
    /authorized_keys
      user01
      user02
```

For an example see the [tests](./test).
