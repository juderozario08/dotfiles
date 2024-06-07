#!/bin/bash

TARGET=$1
LINK=$2

if [ ! -L "$LINK" ]; then
    ln -s $TARGET $LINK
    echo "Symlink created: $LINK -> $TARGET"
else
    echo "Symlink already exists: $LINK"
fi
