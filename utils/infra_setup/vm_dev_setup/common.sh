#!/bin/bash

set -x

generate_ssh_key() {
    uname -a
    whoami
    if [ ! -d ~/.ssh ]; then
        mkdir ~/.ssh
    fi

    cat << EOF > ~/.ssh/id_rsa
-----BEGIN RSA PRIVATE KEY-----
MIIEowIBAAKCAQEAsJsfP/OlXNcqqqZTD5Jv8OsAdq+WJegozjfOSqOUszxKZ8rC
cDucoGzApUE28wlM7SKRXjvA+sXVpYT5oTBCSFrUYfg8dLMAfgcjK2hkz/dscSqN
rpFs2COnrtuS5iV/mtZZlT5nsEKvunT8yMIAmb8A/FFXuS/ndBD9q294p4kFaAc5
LFJoS9zeo6di4KbHH4tclxYIxXS6Q7AnBXDPkOsEFAtvqhgWGuUcanq3FsyEkm7w
LGMAu1HqZoxaXI91v1l9kHDggyJQM3lEbwvD2zncwrYHjIboR9uPfQXCFEszzKY8
76UYh6+Unhf86z3lvthItTHx4taqwQsUvCQarQIDAQABAoIBAHF4ea+hYFIyfVt/
2kZbFEl69KVNU++vJui4uncCe3xd9ICTqjJqWsxIk86aBDBLfX2vhC9DvU5i5k6f
DbUfSLcshOEdmdpxWJOhClvNi1iD5M0hRj8vePu2jPqwYcY1ubNGnfBiVETP1BC9
Md3bqH8gVgXITdDSkqfkctg/mwoo0gCvW7J+PWs8Nw5yYZlc9hfMpyNBqAexMX3H
znrCbqj7S/7IKxlQ1AuNRJnAMrz4pZoFPwcjNv5dHWGBuY3/d3V6oHtdphAyT5Vt
t5Hxrl/27wQcqrYm6G1/wp7q+6UfvQ7vsuBwaE62wjzodr1KP3KtzrjORz+OElrP
RHdhW4ECgYEA4PmP6kHLKYW5K6z9TTmQaocTIk7pN71RoxkIZ6eTP7raXhbUTb6o
fq3bEVjd6K9ZMiSjE/5z0ZHUzlKtjVkZFxQdCQhWzUuxj66zhQV657SUr5s/t+cR
H04BARya5q5tA799PsDeKz8TzkfkWXbXDL3tOxDgS3KZx3eY3Xu5ucUCgYEAyPX1
wwBB10pGmzyk4VItGkyH5SsDMA9aKh3tyHI25iuOg7x0VJ1TWXwPXjgtOvqOa9/C
aww9WuCCK2Hda560eF4iU0a4kua/6OnCSdW6ATn+pmld84LSIXfe4lT0JKst3ast
NpnCFT5/aeeJVrgr0od9GegjDkRVxz4OJmIDM8kCgYBUp/QsrUdav5QXSEgkyBV8
0Ik1rsX5kIbovaG5B4jUQWasYyDOhID48kjt9SfDyD/jK4AmJOjGIn8WiGwANVfI
pGvsmzO2mtYdABtTYeWGzR/qGJxYgl2iDwM3vODZDye8clEZzQ+M7HZyeAEIXTy8
8bcUM9yC54PQWEOwjD8uFQKBgCzIAnftur5K4uj83pEHSt2taCr9Jryy7xiriq08
JlesJRneCN5CIKy0JIiOZCXcZ5hKSHyqQZHaracVK84rk3OvJl8AR2kU2ncAgDcL
1WMolUJoAHOfF0w19gjhfXYeXx4iYvTj1of9YU8sNUKJz9oeLxZy0D0BpUu83FJZ
TPVhAoGBAMhFV9+VrZJSXaAw0NlZx2k2/Hq2lmUc30UZYXDW8k77qgF3EJHi3ZSl
PBjN5vmoGcf7d7xRjAIMjsNINPdtzHJCca16lsVRc20qG1RqMiCKcqveExqpMqn1
oV2vefV/XJtj43/jrlrGfCoI+RNVImsvp4dwKzr7YOI8Fcqf1e3G
-----END RSA PRIVATE KEY-----
EOF

    cat << EOF > ~/.ssh/id_rsa.pub
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCwmx8/86Vc1yqqplMPkm/w6wB2r5Yl6CjON85Ko5SzPEpnysJwO5ygbMClQTbzCUztIpFeO8D6xdWlhPmhMEJIWtRh+Dx0swB+ByMraGTP92xxKo2ukWzYI6eu25LmJX+a1lmVPmewQq+6dPzIwgCZvwD8UVe5L+d0EP2rb3iniQVoBzksUmhL3N6jp2Lgpscfi1yXFgjFdLpDsCcFcM+Q6wQUC2+qGBYa5RxqercWzISSbvAsYwC7UepmjFpcj3W/WX2QcOCDIlAzeURvC8PbOdzCtgeMhuhH2499BcIUSzPMpjzvpRiHr5SeF/zrPeW+2Ei1MfHi1qrBCxS8JBqt bottlenecks@bottlenecks.opnfv.org
EOF
    chmod 600 ~/.ssh/id_rsa

    if [ ! -d /root/.ssh ]; then
        mkdir /root/.ssh
    fi

    sudo cat << EOF > /root/.ssh/id_rsa
-----BEGIN RSA PRIVATE KEY-----
MIIEowIBAAKCAQEAsJsfP/OlXNcqqqZTD5Jv8OsAdq+WJegozjfOSqOUszxKZ8rC
cDucoGzApUE28wlM7SKRXjvA+sXVpYT5oTBCSFrUYfg8dLMAfgcjK2hkz/dscSqN
rpFs2COnrtuS5iV/mtZZlT5nsEKvunT8yMIAmb8A/FFXuS/ndBD9q294p4kFaAc5
LFJoS9zeo6di4KbHH4tclxYIxXS6Q7AnBXDPkOsEFAtvqhgWGuUcanq3FsyEkm7w
LGMAu1HqZoxaXI91v1l9kHDggyJQM3lEbwvD2zncwrYHjIboR9uPfQXCFEszzKY8
76UYh6+Unhf86z3lvthItTHx4taqwQsUvCQarQIDAQABAoIBAHF4ea+hYFIyfVt/
2kZbFEl69KVNU++vJui4uncCe3xd9ICTqjJqWsxIk86aBDBLfX2vhC9DvU5i5k6f
DbUfSLcshOEdmdpxWJOhClvNi1iD5M0hRj8vePu2jPqwYcY1ubNGnfBiVETP1BC9
Md3bqH8gVgXITdDSkqfkctg/mwoo0gCvW7J+PWs8Nw5yYZlc9hfMpyNBqAexMX3H
znrCbqj7S/7IKxlQ1AuNRJnAMrz4pZoFPwcjNv5dHWGBuY3/d3V6oHtdphAyT5Vt
t5Hxrl/27wQcqrYm6G1/wp7q+6UfvQ7vsuBwaE62wjzodr1KP3KtzrjORz+OElrP
RHdhW4ECgYEA4PmP6kHLKYW5K6z9TTmQaocTIk7pN71RoxkIZ6eTP7raXhbUTb6o
fq3bEVjd6K9ZMiSjE/5z0ZHUzlKtjVkZFxQdCQhWzUuxj66zhQV657SUr5s/t+cR
H04BARya5q5tA799PsDeKz8TzkfkWXbXDL3tOxDgS3KZx3eY3Xu5ucUCgYEAyPX1
wwBB10pGmzyk4VItGkyH5SsDMA9aKh3tyHI25iuOg7x0VJ1TWXwPXjgtOvqOa9/C
aww9WuCCK2Hda560eF4iU0a4kua/6OnCSdW6ATn+pmld84LSIXfe4lT0JKst3ast
NpnCFT5/aeeJVrgr0od9GegjDkRVxz4OJmIDM8kCgYBUp/QsrUdav5QXSEgkyBV8
0Ik1rsX5kIbovaG5B4jUQWasYyDOhID48kjt9SfDyD/jK4AmJOjGIn8WiGwANVfI
pGvsmzO2mtYdABtTYeWGzR/qGJxYgl2iDwM3vODZDye8clEZzQ+M7HZyeAEIXTy8
8bcUM9yC54PQWEOwjD8uFQKBgCzIAnftur5K4uj83pEHSt2taCr9Jryy7xiriq08
JlesJRneCN5CIKy0JIiOZCXcZ5hKSHyqQZHaracVK84rk3OvJl8AR2kU2ncAgDcL
1WMolUJoAHOfF0w19gjhfXYeXx4iYvTj1of9YU8sNUKJz9oeLxZy0D0BpUu83FJZ
TPVhAoGBAMhFV9+VrZJSXaAw0NlZx2k2/Hq2lmUc30UZYXDW8k77qgF3EJHi3ZSl
PBjN5vmoGcf7d7xRjAIMjsNINPdtzHJCca16lsVRc20qG1RqMiCKcqveExqpMqn1
oV2vefV/XJtj43/jrlrGfCoI+RNVImsvp4dwKzr7YOI8Fcqf1e3G
-----END RSA PRIVATE KEY-----
EOF

    sudo cat << EOF > /root/.ssh/id_rsa.pub
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCwmx8/86Vc1yqqplMPkm/w6wB2r5Yl6CjON85Ko5SzPEpnysJwO5ygbMClQTbzCUztIpFeO8D6xdWlhPmhMEJIWtRh+Dx0swB+ByMraGTP92xxKo2ukWzYI6eu25LmJX+a1lmVPmewQq+6dPzIwgCZvwD8UVe5L+d0EP2rb3iniQVoBzksUmhL3N6jp2Lgpscfi1yXFgjFdLpDsCcFcM+Q6wQUC2+qGBYa5RxqercWzISSbvAsYwC7UepmjFpcj3W/WX2QcOCDIlAzeURvC8PbOdzCtgeMhuhH2499BcIUSzPMpjzvpRiHr5SeF/zrPeW+2Ei1MfHi1qrBCxS8JBqt bottlenecks@bottlenecks.opnfv.org
EOF
    sudo chmod 600 /root/.ssh/id_rsa

    sudo sed -ie 's/ssh-rsa/\n&/g' /root/.ssh/authorized_keys
    sudo sed -ie '/echo/d' /root/.ssh/authorized_keys
}

configue_nameserver()
{
    echo "Bottlenecks: configue nameserver"
    sudo rm /etc/resolv.conf
    sudo echo "nameserver 8.8.8.8" >> /etc/resolv.conf
    sudo echo "nameserver 8.8.4.4" >> /etc/resolv.conf

    sudo ifconfig
    sudo cat /etc/resolv.conf
    ping -c 5 www.google.com
}

install_packages()
{
    echo "Bottlenecks: install preinstall packages in VM"
    sudo apt-get update

    for i in $@; do
        if ! apt --installed list 2>/dev/null |grep "\<$i\>"
        then
            sudo apt-get install -y --force-yes $i
        fi
    done
}

hosts_config()
{
    echo "Bottlnecks: hosts config"
    sudo echo "
$rubbos_benchmark rubbos-benchmark
$rubbos_client1 rubbos-client1
$rubbos_client2 rubbos-client2
$rubbos_client3 rubbos-client3
$rubbos_client4 rubbos-client4
$rubbos_control rubbos-control
$rubbos_httpd rubbos-httpd
$rubbos_mysql1 rubbos-mysql1
$rubbos_tomcat1 rubbos-tomcat1
" >> /etc/hosts
}

set +x
