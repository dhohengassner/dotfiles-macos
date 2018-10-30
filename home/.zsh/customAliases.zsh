#! /usr/local/bin/zsh

# tmux aliases
alias t='tmux'
alias tn='tmux new -s myname'
alias ta='tmux attach'
alias tan='tmux a -t'
alias tls='tmux ls'
alias tksn='tmux kill-session -t'
alias tk!='tmux kill-server'

# own kitchen aliases
alias kc='kitchen converge'
alias kd='kitchen destroy'
alias kcr='kitchen create'
alias kl='kitchen list'
alias kssh='kitchen login'
alias kv='kitchen verify'

# other often used aliases
alias dlv='delivery local verify'

# Docker aliases
alias db='docker build .'
alias dcr='docker create'
alias ds='docker start'
alias drm='docker rm'
alias drmf='docker rm -f'
alias drmi='docker rmi'
alias dei='docker exec -it'

dbash() { docker exec -it $(docker ps -aqf "name=$1") /bin/bash; }
dsh() { docker exec -it $(docker ps -aqf "name=$1") /bin/sh; }

alias drm!='docker rm -f $(docker ps -a -q)'
alias dk!='docker kill $(docker ps -a -q)'
alias drmi!='docker rmi $(docker images -q)'

alias di='docker images'
alias dia='docker images -a'
alias dps='docker ps'
alias dpsa='docker ps -a'

alias dip!='docker image prune -a'
alias dsp!='docker system prune -a'

alias dcup='docker-compose up'
alias dcupd='docker-compose up -d'
alias dcstop='docker-compose stop'
alias dcdown='docker-compose down'
alias dckill='docker-compose kill'

# config aliases
alias zshconfig="vim ~/.zshrc"
alias ohmyzsh="vim ~/.oh-my-zsh"
alias dhgitconfig="vim ~/.zsh/git.zsh"
alias dhcustom="vim ~/.zsh/customFunctions.zsh"
alias dhvault="vim ~/.zsh/vault.zsh"

alias czshconfig="code ~/.zshrc"
alias cohmyzsh="code ~/.oh-my-zsh"
alias cdhgitconfig="code ~/.zsh/git.zsh"
alias cdhcustom="code ~/.zsh/customFunctions.zsh"
alias cdhvault="code ~/.zsh/vault.zsh"
