#! /usr/local/bin/zsh

# important startup
alias sdocker='source ~/start_docker.zsh'
alias edocker='eval "$(docker-machine env dh-docker-toolbox)"'

# tmux aliases
alias t='tmux attach || tmux new -s main'
alias tn='tmux new -s'
alias ta='tmux attach'
alias tan='tmux a -t'
alias tls='tmux ls'
alias tksn='tmux kill-session -t'
alias tk!='tmux kill-server'

# go aliases
alias gor='go run'
alias gob='go build'
alias gog='GIT_TERMINAL_PROMPT=1 go get'
alias goga='GIT_TERMINAL_PROMPT=1 go get -d -t .'
alias gogr='GIT_TERMINAL_PROMPT=1 go get -d -v -t ./...'
alias gogm='GIT_TERMINAL_PROMPT=1 go get -d -v ./...'
alias cdg="cd $GOPATH/src"
alias gt='go test'
alias gtr='go test -v ./...'
alias gomv='go mod verify'
alias gomt='go mod tidy'


# own kitchen aliases
alias kic='kitchen converge'
alias kid='kitchen destroy'
alias kicr='kitchen create'
alias kil='kitchen list'
alias kissh='kitchen login'
alias kiv='kitchen verify'

# other often used aliases
alias dlv='delivery local verify'

# Docker aliases
alias db='docker build .'
alias dcr='docker create'
alias ds='docker start'
alias dk='docker kill'
alias drm='docker rm'
alias drmf='docker rm -f'
alias drmi='docker rmi'
alias dei='docker exec -it'

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

alias dlogecr='eval $(aws ecr get-login --no-include-email)'

# terraform
alias tf='terraform'
alias tfi='terraform init'
alias tfp='terraform plan'
alias tfa='terraform apply'
alias tfa!='terraform apply -auto-approve'

# ssh-agent
alias ssha='ssh-add'
alias sshl='ssh-add -l'
alias sshd='ssh-add -D'

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

# ssh into docker toolbox vm
alias dtssh='docker-machine ssh dh-docker-toolbox'
#alias dtssh="ssh -i ~/.docker/machine/machines/dh-docker-toolbox/id_rsa -p 49775 docker@localhost"

# k8s
alias kcdt='kubectl -n kube-system describe secret kubernetes-dashboard-token | awk '"'"'$1=="token:"{print $2}'"'"' | pbcopy'
alias kpfm='kubectl port-forward $(kubectl get pods -n ingress-nginx -o name -l app=monitoring-ingress-nginx | head -n 1) 8443:443 -n ingress-nginx'

# exa
# http://zsh.sourceforge.net/Doc/Release/Expansion.html#Parameter-Expansion
(( $+commands[exa] )) && {
    alias el='exa'
    alias ela='exa -la'
    alias ell='exa -lag'
    alias elg='exa -bghHliS --git'
}

# Homebrew
alias brews='brew list -1'
alias bubo='brew update && brew outdated'
alias bubc='brew upgrade && brew cleanup'
alias bubu='bubo && bubc'

# Antibody
alias antiup='antibody bundle < ~/.zsh_plugins.txt > ~/.zsh_plugins.sh'

# Ruby
alias be='bundle exec'

# some other stuff
alias re='/bin/zsh --login'
alias h='history'