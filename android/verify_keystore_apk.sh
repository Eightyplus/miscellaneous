#/bin/sh
if [ -z "$1" ]
then
  echo "Please input the path to apk file"
  exit
fi

apk=$1
keystores=(`find . -iname "*.jks"`)
keystores+=(`find . -iname "*.keystone"`)
keystores+=(`find . -iname "*.keystore"`)

for (( i=0 ; i< ${#keystores[@]} ; i++ ))
do
    key=${keystores[i]}

    sign=`jarsigner -verify --keystore $key $apk`

    lines=`echo $sign | egrep "(Warning|error)" | wc -l | xargs`
    if [ "$lines" -lt 1 ];
    then
       echo "found signing in file $key"
       exit
    fi
done
