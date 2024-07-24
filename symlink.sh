TARGET=$1
LINK=$2
if [ -z "$TARGET" ]; then
    echo "No target specified"
    return 1
fi
if [ -z "$LINK" ]; then
    echo "No link specified"
    return 1
fi
if [ ! -L "$LINK" ]; then
    ln -s $TARGET $LINK
    echo "Symlink created: $LINK -> $TARGET"
else
    echo "Symlink already exists: $LINK"
fi
