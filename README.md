LSync + RSync
-------------


How to use
==========

Create ssh folder for `from`

```
./ssh_from
  |- authorized_keys
  |- id_rsa
  |- id_rsa.pub
```

and `to`

```
./ssh_to
  |- authorized_keys
  |- id_rsa
  |- id_rsa.pub
```

Run from docker-compose
=======================

Create docker-compose.yml

```
version: '3'

services:

    lsync.from:
        image: mishamx/lsync:latest
        environment:
            SYNC_HOST: 'lsync.to'
        networks:
            - front
        volumes:
            - "./storage/from:/data"
            - "./ssh:/root/.ssh"
        # For swarm
        deploy:
            placement:
                constraints: [node.lable.lsync == from]

    lsync.to:
        image: mishamx/lsync:latest
        environment:
            SYNC_HOST:  'lsync.from'
        networks:
            - front
        volumes:
            - "./storage/to:/data"
            - "./ssh:/root/.ssh"
        # For swarm
        deploy:
            placement:
                constraints: [node.lable.lsync == to]
        command: /usr/bin/supervisord

networks:
    front:
        driver: bridge
```