#!/bin/bash
# Automatically expand all aliases:
# - don't forget the actual commands
# - don't confuse your pairing partner


preexec_functions=()

function expand_aliases () {
    BUFFER=$1
    ESCAPED_BUFFER=$(printf %s "$BUFFER" | sed 's/[][()\.^$?*+]/\\&/g')
    ALIAS=`alias | grep -e "=[\'\"]\?${ESCAPED_BUFFER}[\'\"]\?$"`
    if [ "$ALIAS" != "" ]; then
      echo
      echo "You have this alias:"
      echo
      echo $ALIAS
      echo
      echo "Use it!"
    fi
}
preexec_functions+=(expand_aliases)
