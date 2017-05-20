#!/bin/sh

echo "Running zip align"
alias zipalign="<PATH_TO_ANDROID_SDK>/tools/zipalign"

apps=(`find . -iname "*.apk"`)

for (( i=0 ; i< ${#apps[@]} ; i++ ))
do
  app=${apps[i]}
  date=`stat -l -t '%F' "$app" | cut -d" " -f6-6`
  app_rename=`echo ${apps[i]} | sed 's/.apk//'`
  app_rename=$app_rename"_"$date".apk";

  zipalign -v 4 $app $app_rename 2>&1 > /dev/null;

  echo "  $app  (zipalign) -> $app_rename"

  if [ -f $app_rename ]
  then
    rm $app;
  fi

done;
