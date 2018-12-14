#!/bin/bash

id=
pw=
location=

id2=
pw2=
location2=

curl -u $id:$pw "ftp://$location/" | tr -s " "| cut -d " " -f9 > list.txt
buff=""
while IFS='' read -r line || [[ -n "$line" ]]; do
    buff="$(grep "$line" downloaded.txt)"
    buff=${buff%%+([[:space:]])}
    if [ -z "$buff" ]; then
        curl -u $id:$pw "ftp://$location/$line" > $line
        sshpass -p $pw2 scp $line $pw2@$location2:~/buff/ && rm $line
        echo $line >> downloaded.txt
    fi
done < list.txt
echo "end"
