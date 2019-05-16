#
## Execute command at login before zshrc
#
if [[ -z "$LANG" ]]; then
    export LANG='en_US.UTF-8'
    export LANGUAGE=en_US.UTF-8
fi

export LC_COLLATE=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export LC_MESSAGES=en_US.UTF-8
export LC_MONETARY=en_US.UTF-8
export LC_NUMERIC=en_US.UTF-8
export LC_TIME=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LESSCHARSET=utf-8

# set important paths
export GOPATH=$HOME/go
export PATH="$GOPATH/bin:/usr/local/bin:/opt/chefdk/embedded/bin:/usr/bin:/usr/sbin:/bin:/sbin:/Applications"