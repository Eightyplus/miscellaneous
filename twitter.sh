rawurldecode() {
  printf -v REPLY '%b' "${1//%/\\x}"
  echo "${REPLY}"
}

rawurlencode() {
  local string="${1}"
  local strlen=${#string}
  local encoded=""
  local pos c o

  for (( pos=0 ; pos<strlen ; pos++ )); do
     c=${string:$pos:1}
     case "$c" in
        [-_.~a-zA-Z0-9] ) o="${c}" ;;
        * )               printf -v o '%%%02X' "'$c"
     esac
     encoded+="${o}"
  done
  echo "${encoded}"    # You can either set a return variable (FASTER) 
  REPLY="${encoded}"   #+or echo the result (EASIER)... or both... :p
}

api_key=<API_KEY>
api_secret=<API_SECRET>
access_token=<ACCESS_TOKEN>
access_secret=<ACCESS_SECRET>
oauth_timestamp=`date +%s`
oauth_nonce=`date +%s%T | openssl base64 | sed -e s'/[+=/]//g'`

method='GET'
url='https://api.twitter.com/1.1/search/tweets.json'

q="%23<QUERY>" #QUERY
date="<DATE>" #format YYYY-MM-DD
count="100"
cursor="-1"
query=$( rawurlencode "$q" )

signature_key=$( rawurlencode "$api_secret" )"&"$( rawurlencode "$access_secret" )

keys=( "count" "cursor" "include_entities" "oauth_consumer_key" "oauth_nonce" "oauth_signature_method" "oauth_timestamp" "oauth_token" "oauth_version" "q" "since" )
values=( $count $cursor "false" $api_key $oauth_nonce "HMAC-SHA1" $oauth_timestamp $access_token "1.0" $q $date )

params=""
for (( i = 0 ; i < ${#keys[@]} ; i++ ))
do
    key=${keys[$i]}
    value=${values[$i]}

    if [[ $i -ne 0 ]]; then
        params=$params"&"
    fi
    params=$params$( rawurlencode "$key" )"="$( rawurlencode "$value" )
done

signature_base_string=$method"&"$( rawurlencode "$url" )"&"$( rawurlencode "$params" )

#oauth_signature=`echo -n ${signature_base_string} | openssl dgst -sha1 -hmac $signature_key -binary | openssl base64 | sed -e s'/+/%2B/' -e s'/\//%2F/' -e s'/=/%3D/'`
#oauth_signature=$( rawurlencode `echo -n ${signature_base_string} | openssl dgst -sha1 -hmac ${signature_key} -binary | openssl base64` )
oauth_signature=$( rawurlencode `echo "<?php echo base64_encode(hash_hmac('sha1', '$signature_base_string', '$signature_key', true));?>" | php` )

result=`curl --GET "$url" \
     --data "q=$query&count=$count&cursor=$cursor&include_entities=false&since=$date" \
     --header "Authorization: OAuth oauth_consumer_key=\"$api_key\", oauth_nonce=\"$oauth_nonce\", oauth_signature=\"$oauth_signature\", oauth_signature_method=\"HMAC-SHA1\", oauth_timestamp=\"$oauth_timestamp\", oauth_token=\"$access_token\", oauth_version=\"1.0\""`

echo $result > tmp.txt

