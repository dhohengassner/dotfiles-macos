# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=/Users/dh/.oh-my-zsh

# set code as editor
export EDITOR=code

# avoid german outputs :)
export LANG="en_US.UTF-8"

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="racotecnic"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# install plugins
# https://github.com/getantibody/antibody
# source <(antibody init)
# antibody bundle < ~/.zsh_plugins.txt

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
	autojump
	aws
	bundler
	# https://github.com/popstas/zsh-command-time
	command-time
	docker
	helm
	kubectl
	osx
	rbenv
	ruby
	tmux
	# git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
	zsh-autosuggestions
)

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

if command -v pyenv 1>/dev/null 2>&1; then
	eval "$(pyenv init -)"
	eval "$(pyenv virtualenv-init -)"
fi

# pyenv activate python3env 1>/dev/null 2>&1

# completion
autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /Applications/vault vault

# direnv
eval "$(direnv hook zsh)"

# execute all .zsh files in HOME directory - some custom functions
for ZFILE in $HOME/.zsh/*; do
	source $ZFILE
done

# enable docker
dmstatus=$(docker-machine status dh-docker-toolbox)
if [ "$dmstatus" != "Running" ]; then sdocker; else edocker; fi
