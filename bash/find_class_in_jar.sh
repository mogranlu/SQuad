#Attempt #1 : (fails)
find /D/maven_repository/ -name "*.jar" -exec unzip -l '{}' \; | awk '{ if ($0 ~ /^Archive/ ) {lastjar=$NF} else if ($NF ~ /ControlException.class/ ) { exit } }; END {print lastjar}'

#Attempt #2 : (Weird behaviour in git bash, but works in linux bash shells like gnome-terminal)
find /usr/share/openoffice/basis3.2/help/ -name "*.jar" -exec unzip -l '{}' \; | awk 'BEGIN {result="Found in: "};{ if ($0 ~ /^Archive/ ) {print "Searching archive", $NF; lastjar=$NF} if ($0 ~ /03090800.xhp/ ) { print $NF; result=result "\n" lastjar } }; END {print result}'

# Attempt #3 : Lots of output, but works OK in git bash on Windows machines:
searchClass="DefaultPluginManager"; searchDir="/C/Users/Morten/.m2/repository" ; find ${searchDir} -name "*.jar" -exec echo "...Searching: {}" \; -exec jar -tf '{}' \; | egrep -e "^\.\.\.Searching|${searchClass}"


$ find /D/maven_repository/ -name "*.jar" \
    -exec unzip -l '{}' \; \
    | awk ' \
        # Init: \
        BEGIN { \
            result="Found in: " \
        }; \
        # For each line in result, do the following: \
        { \
            if ($0 ~ /^Archive/ ) { \
                print "Searching archive", $NF; lastjar=$NF \
            } \
            # Enter search criteria here: \
            if ($0 ~ /\/StringUtils.class/ ) { \
                print $NF; result=result '\n' lastjar \
            } \
        }; \
        # Finally, print result \
        END {print result} \
    '
