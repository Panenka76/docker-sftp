# Description

Docker image for running an OpenSSH SFTP server on Ubuntu 16.04.

# Features

- run SSH daemon on startup and log to stdout instead of syslog
- chroot all sftp users into their homedir
- by default disable root login and only allow authentication by key.


# Usage

At [startup](./start.sh), if any additional config files are available at /opt/ssh/config, they will be used to override the [defaults](./sshd_config). It would generally be a good idea to include your HostKeys here such that when your container restarts or is scheduled on a different host, it doesn't change its hostkeys.

Then, all subdirectories of /opt/ssh/users will result in the creation of a user with the same name as the directory and with the 'authorized_keys' inside this user directory being used as the only means of authentication for this user.

```
/opt
  /ssh
    /users
      /user01
        authorized_keys
      /user02
        authorized_keys
```

For an example see the [tests](./test).
