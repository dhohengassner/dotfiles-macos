# debug startup time
# zmodload zsh/zprof

# Path to your oh-my-zsh installation.

export ZSH=/Users/dh/.oh-my-zsh

# set code as editor
export EDITOR=code

# avoid german outputs :)
export LANG="en_US.UTF-8"

# See https://github.com/dhohengassner/zsh-theme-racotecnic
ZSH_THEME="racotecnic"

# lazy load any custom functions
lazyload_fpath=$HOME/.zsh/autoload
fpath=($lazyload_fpath $fpath)
if [[ -d "$lazyload_fpath" ]]; then
    for func in $lazyload_fpath/*; do
        autoload -Uz ${func:t}
    done
fi
unset lazyload_fpath

# completion
autoload -Uz compinit
typeset -i updated_at=$(date +'%j' -r ~/.zcompdump 2>/dev/null || stat -f '%Sm' -t '%j' ~/.zcompdump 2>/dev/null)
if [ $(date +'%j') != $updated_at ]; then
    compinit -i
else
    compinit -C -i
fi

# stolen autocomplete tweaks from https://github.com/webframp/dotfiles/blob/master/home/.zshrc
unsetopt menu_complete

# completion performance improvements
# Force prefix matching, avoid partial globbing on path
zstyle ':completion:*' accept-exact '*(N)'
# enable completion cache
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.local/share/zsh/cache

# Ignore completion for non-existent commands
zstyle ':completion:*:functions' ignored-patterns '(_*|pre(cmd|exec))'
#zstyle ':completion:*:functions' ignored-patterns '_*'


# completion behavior adjustments
# Case insensitive, partial-word and substring competion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
# zstyle ':completion:*:*:*:*:*' menu select
# zstyle ':completion:*' special-dirs true

# # Colors in the completion list
# zstyle ':completion:*' list-colors ''
# zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'

# from: vault -autocomplete-install
# autoload -U +X bashcompinit && bashcompinit
# complete -o nospace -C /usr/local/bin/vault vault

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
# plugins=(
# 	autojump
# 	aws
# 	bundler
# 	# https://github.com/popstas/zsh-command-time
# 	command-time
# 	docker
# 	helm
# 	kubectl
# 	osx
# 	rbenv
# 	ruby
# 	tmux
# 	# git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
# 	zsh-autosuggestions
# )

# alias tips
source ~/.oh-my-zsh/plugins/alias-tips/alias-tips.plugin.zsh

# command-time
export ZSH_COMMAND_TIME_MIN_SECONDS=1
export ZSH_COMMAND_TIME_COLOR="yellow"

# homeshick integration
source "$HOME/.homesick/repos/homeshick/homeshick.sh"
fpath=($HOME/.homesick/repos/homeshick/completions $fpath)

source $ZSH/oh-my-zsh.sh

# iterm2 shell integration
source ~/.iterm2_shell_integration.zsh

# User configuration

# custom key bindings
bindkey "[D" backward-word
bindkey "[C" forward-word

# ssh
export SSH_KEY_PATH="~/.ssh/rsa_id"

# chef integration
export PATH="/opt/chefdk/embedded/bin:$PATH"

# gitlab token for scripting and querying appsgit
export GITLAB_TOKEN="$(echo $(<~/dh_values.json) | jq -r '.gitlab.scriptToken')"

# vault integration
export PATH=$PATH:/Applications

# K8s variables
export KUBECONFIG=~/.kube/dh-test

# ruby
eval "$(rbenv init -)"
export RBENV_ROOT="$HOME/.rbenv"

# python
# export PYENV_ROOT="$HOME/.pyenv"
# export PATH="$PYENV_ROOT/bin:$PATH"
# export PYENV_VIRTUALENV_DISABLE_PROMPT=1

# GO
### test with multiple GOPATHs
# export GOPATH=/Users/dh/go:/Users/dh/src/gopath
# export GOROOT=/usr/local/opt/go/libexec
# export PATH="$PATH:$GOPATH/bin"
# export PATH="$PATH:$GOROOT/bin"

export GOPATH=/Users/dh/go
export PATH="$PATH:$GOPATH/bin"

# Groovy
export GROOVY_HOME=/usr/local/opt/groovy/libexec

# Python
# if command -v pyenv 1>/dev/null 2>&1; then
# 	eval "$(pyenv init -)"
# 	eval "$(pyenv virtualenv-init -)"
# fi
# pyenv activate python3env 1>/dev/null 2>&1

# direnv
eval "$(direnv hook zsh)"

# execute all .zsh files in HOME directory - some custom functions
for ZFILE in $HOME/.zsh/*; do
	source $ZFILE
done

export ZSH_AUTOSUGGEST_USE_ASYNC=1
## Source plugins last
# static method, after updates run:
# antibody bundle <~/.zsh_plugins.txt > ~/.zsh_plugins.sh
source ~/.zsh_plugins.sh

# enable docker
dmstatus=$(docker-machine status dh-docker-toolbox)
if [ "$dmstatus" != "Running" ]; then sdocker; else edocker; fi

# show startup time
# zprof