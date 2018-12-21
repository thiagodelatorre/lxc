#!/bin/bash

lxc launch ubuntu:18.04 bareos

# install packages
lxc file push bareos.list bareos/etc/apt/sources.list.d/
lxc exec bareos -- "wget -q http://download.bareos.org/bareos/release/18.2/xUbuntu_18.04/Release.key -O- > /tmp/key"
lxc exec bareos -- apt-key add /tmp/key
lxc exec bareos -- apt update
lxc exec bareos -- DEBIAN_FRONTEND=noninteractive apt install -yq bareos bareos-webui postgresql

# Populate database
lxc exec bareos -- /usr/lib/bareos/scripts/create_bareos_database
lxc exec bareos -- /usr/lib/bareos/scripts/make_bareos_tables
lxc exec bareos -- /usr/lib/bareos/scripts/grant_bareos_privileges
