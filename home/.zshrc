# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=/Users/dh/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="racotecnic"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
	autojump
	aws
	bundler
	docker
	gem
	osx
	rake
	rbenv
	ruby
	tmux
	vagrant
)

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

# eval "$(chef shell-init zsh)" - old method creates chef shell every time

# should be faster
if test -e "${HOME}/.chefshellinit" && source "${HOME}/.chefshellinit"; then
	echo 'init chef shell'
else
	echo 'recreating chef shell'
	chef shell-init zsh >"${HOME}/.chefshellinit"
	chmod +x "${HOME}/.chefshellinit"
	source "${HOME}/.chefshellinit"
fi

# vault integration
export PATH=$PATH:/Applications
export VAULT_CACERT=/Users/dh/vault.bethel.jw.org.pem

# K8s variables
export KUBECONFIG=~/.kube/dh-test

# python
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
export PYENV_VIRTUALENV_DISABLE_PROMPT=1

if command -v pyenv 1>/dev/null 2>&1; then
	eval "$(pyenv init -)"
	eval "$(pyenv virtualenv-init -)"
fi

pyenv activate python3env

# completion
autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /Applications/vault vault

# execute all .zsh files in HOME directory - some custom functions
for ZFILE in $HOME/.zsh/*; do
	source $ZFILE
done
