find /C/temp/outlook_export/ -type f -name "*.csv" -exec grep -i pgrad '{}' \; | awk 'BEGIN { FS = ";" } ; { print $NF }' | sed s#\"##g | sed s#,#.#g | awk '{ total = total + $1; print $0 }; END { print "TOTAL = ", total}'