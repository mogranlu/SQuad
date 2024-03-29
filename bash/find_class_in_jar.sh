#======================================================================================================
# Explanation:
# - This script comes in three variants (with various complexity and output).
# 
# * Variant #1 - The first is giving little output, but may give weird output in Git BASH on Windows.
# * Variant #2 - Slightly more verbose, but works better on Windows machines.    
# * Variant #3 - Lots of line-breaks to look good in the slideshow presentation. Works great in both
#                Git BASH (Windows) and in gnome-terminal.
#  
#======================================================================================================

# Variant #1 : (Weird behaviour in git bash, but works in linux bash shells like gnome-terminal)
find /usr/share/openoffice/basis3.2/help/ -name "*.jar" -exec unzip -l '{}' \; | awk 'BEGIN {result="Found in: "};{ if ($0 ~ /^Archive/ ) {print "Searching archive", $NF; lastjar=$NF} if ($0 ~ /03090800.xhp/ ) { print $NF; result=result "\n" lastjar } }; END {print result}'

# Variant #2 : Lots of output, but works OK in git bash on Windows machines:
searchClass="DefaultPluginManager"; searchDir="/C/Users/Morten/.m2/repository" ; find ${searchDir} -name "*.jar" -exec echo "...Searching: {}" \; -exec jar -tf '{}' \; | egrep -e "^\.\.\.Searching|${searchClass}"

# Variant #3 : (unzip command must be available/installed): 
find /D/maven_repository/ -name "*.jar" \
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
                print $NF; result=result "\n" lastjar \
            } \
        }; \
        # Finally, print result \
        END {print result} \
    '
