find /D/maven_repository/ -name "*.jar" -exec unzip -l '{}' \; | awk '{ if ($0 ~ /^Archive/ ) {lastjar=$NF} else if ($NF ~ /ControlException.class/ ) { exit } }; END {print lastjar}'

#Not quite:
find /C/Users/Morten/.m2/repository -name "*.jar" -exec unzip -l '{}' \; | awk 'BEGIN {result=""};{ if ($0 ~ /^Archive/ ) {print "Searching archive", $NF; lastjar=$NF} if ($0 ~ /\/ControlException\.class/ ) { print $NF; result=result lastjar } }; END {print result}'
# Something fishy happens with the resulting string!

# Lots of output:
searchClass="DefaultPluginManager"; searchDir="/C/Users/Morten/.m2/repository" ; find ${searchDir} -name "*.jar" -exec echo "...Searching: {}" \; -exec jar -tf '{}' \; | egrep -e "^\.\.\.Searching|${searchClass}"
