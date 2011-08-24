#!/bin/bash

#----------------------------------------------------------------------------------
# Author: Morten Granlund <morten.granlund@capgemini.com>
# Date: 2009-12-02
# Version: 1.0
#
# Description: Sends e-mail!
#
# USAGE:
# 1) email <mail-body> <recipient1,recipient2,...,recipientN> <subject>
# ...or...
# 2) email <file-with-mail-body>
# ...or...
# 3) email <'This is the body! Remember to use single quotes!'>
# (If the first parameter is not a readable file, the first param itself will be
#       used as the e-mail body (remember to use single quotes, e.g. 'disk full').
# (If the second or third parameter is missing, then default values will be used.)
#----------------------------------------------------------------------------------

# Default values:
subject="Automail from $(uname --nodename)"
recipients="morten.granlund@capgemini.com,someotherdude@dummycustomer.org"
contentfile="/home/auto/mail/DUMMYFILE.TXT"

# Print usage when first param is empty, "-h", or "--help"
if [ -z "$1" ] || [ "$1" == "-h" ] || [ "$1" == "--help" ]; then
    echo 'Help!' >&2
    echo -n "Usage: $0 " >&2
    echo '<mail-body> <recipient1,recipient2,...,recipientN> <subject>' >&2
    echo '  (If the first param is not a readable file, then the first param itself will be used as body.' >&2
    echo '  (Recipient list and subject are both optional. Default ones will be used!' >&2
    echo ' ' >&2
    exit 1
fi

# Try to use the parameters (which will override the default values):
[ -n "$1" ] && contentfile=$1
[ -n "$2" ] && recipients=$2
[ -n "$3" ] && subject=$3

# If first param is a readable file, e-mail the content of that file...
if [ -r "$contentfile" ]; then
# Send file content as body in mail:
mail -s "${subject}" ${recipients} << EOF
$(cat $contentfile)
EOF
else
# Send first param as body in mail:
mail -s "${subject}" ${recipients} << EOF
$1
EOF
fi
