#!/bin/bash
creer_bob() {
    groupadd dev
    useradd -m -g dev bob
    echo "bob:password123" | chpasswd
    echo 'bob ALL=(ALL) NOPASSWD: /usr/bin/apt, /usr/bin/apt-get' > /etc/sudoers.d/bob
    chmod 440 /etc/sudoers.d/bob
}
creer_bob

