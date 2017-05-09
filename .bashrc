export PS1='\[\033[01;32m\]\t \u\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
export HISTFILESIZE=1000
export HISTSIZE=2000

export PATH="$PATH:/usr/local/heroku/bin:/Library/Java/sdk"
export ANDROID_HOME=/usr/local/opt/android-sdk

export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

alias ll='ls -alhF'
alias l='ls -aF'
alias d='ls -aF | grep "/"'
alias ss='screen -S'
alias sr='screen -r'
alias sl='screen -list'
alias shareip='dns-sd -G v4v6 MACNAME.local'

alias convavi2mp4='ffmpeg -i input.avi -acodec libfaac -b:a 128k -vcodec mpeg4 -b:v 1200k -flags +aic+mv4 output.mp4'
alias forfileinls='for file in `ls`; do echo $file; done'
alias dos2unix="perl -p -i -e 's/\r\n/\n/'"
alias stdredirect="mkdir hest && rm hest/* 2>&1"

alias mongostart="launchctl load /Library/LaunchDaemons/org.mongodb.mongod.plist && launchctl start org.mongodb.mongod"
alias mongostop="launchctl stop org.mongodb.mongod"

alias redistart="launchctl load -w ~/Library/LaunchAgents/io.redis.redis-server.plist"
alias redistop="launchctl unload -w ~/Library/LaunchAgents/io.redis.redis-server.plist"

alias verifypermissions="sudo /usr/libexec/repair_packages --verify --standard-pkgs /"
alias repairpermissions="sudo /usr/libexec/repair_packages --repair --standard-pkgs --volume /"

alias gitx="open -a /Applications/GitX.app ."
alias preview='open -a /Applications/Preview.app/'
alias Mail='open -a /Applications/Mail.app'
alias firefox='open -a /Applications/Firefox.app/'
alias xcode='open -a /Applications/Xcode.app/'
alias charm='open -a /Applications/PyCharm.app/'
alias wstorm='open -a /Applications/WebStorm.app .'
alias webstorm='open -a /Applications/WebStorm.app .'

alias prettyjson='python -m json.tool'
alias rsync_copy='rsync -zard <SRC> <DST>'
alias exiftool_copy="exiftool -o . '-Directory<CreateDate' -d $2/%y/%y%m -r $1" #$1(src) $2(dst)
alias rsync_copy='rsync -zard <SRC> <DST>'
# requires -E  (<some regex>) -> \1
alias sedreplace="sed -E 's/.*\"([a-z]*)\".*/\1/' > words.txt"
alias portuse="lsof -n -iTCP | grep LISTEN"

alias testdisk='dd if=/dev/zero bs=1024k of=tstfile count=1024'
alias patch_git0='git diff --no-prefix example/index.html > my.patch'
alias patch_git1='git diff example/index.html > new.patch'
alias patch_apply0='patch -p0 < my.patch'
alias patch_apply1='git apply new.patch'
