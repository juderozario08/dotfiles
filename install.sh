#!/bin/bash

OS=$(uname)

if [ "$OS" == "Linux" ]; then
    source ./arch_install.sh
else
    source ./mac_install.sh
fi
