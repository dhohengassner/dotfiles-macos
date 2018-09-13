#! /usr/local/bin/zsh

bethel_values=$(<~/bethel_values.json)

c() {
	if [ $# -eq 0 ]; then
		code .
	else
		code $1
	fi
}

enableDockerVM() {
	alias docker='ssh vagrant@192.168.100.22 docker'
}

devssh() {
	ssh vagrant@192.168.100.22
}

devvssh() {
	export VAGRANT_CWD='/Users/dh/src/dev-env'
	vagrant ssh
	unset VAGRANT_CWD
}

devstop() {
	export VAGRANT_CWD='/Users/dh/src/dev-env'
	vagrant halt
	unset VAGRANT_CWD
}

devup() {
	export VAGRANT_CWD='/Users/dh/src/dev-env'
	vagrant up
	unset VAGRANT_CWD
}

devreload() {
	export VAGRANT_CWD='/Users/dh/src/dev-env'
	vagrant reload
	unset VAGRANT_CWD
}

devdestroy() {
	export VAGRANT_CWD='/Users/dh/src/dev-env'
	vagrant destroy
	unset VAGRANT_CWD
}

sdocker() {
	source ~/start_docker.zsh
}

edocker() {
	eval "$(docker-machine env default)"
}

pyvirtenvvup() {
	. ~/src/pythonworkspace/bin/activate
}

pyvirtenvdown() {
	deactivate
}

h() {
	history
}

lab2access() {
	saml2aws login

	export AWS_REGION=$(echo $bethel_values | jq -r '.aws.region')
	export AWS_DEFAULT_REGION=$(echo $bethel_values | jq -r '.aws.region')

	json=$(aws sts assume-role --role-arn $(echo $bethel_values | jq -r '.aws.role') --role-session-name "dhlab2access" --profile 'samllab2')
	export AWS_ACCESS_KEY_ID=$(echo $json | jq .Credentials.AccessKeyId --raw-output)
	export AWS_SECRET_ACCESS_KEY=$(echo $json | jq .Credentials.SecretAccessKey --raw-output)
	export AWS_SESSION_TOKEN=$(echo $json | jq .Credentials.SessionToken --raw-output)
}

install_bethel_certs() {
	wget -q $(echo $bethel_values | jq -r '.bethel.cert_url') -O ~/install_certs.sh
	chmod +x ~/install_certs.sh
	~/install_certs.sh
}

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
alias db='docker build'
alias dcr='docker create'
alias ds='docker start'
alias drm='docker rm'
alias drmf='docker rm -f'
alias drmi='docker rmi'

alias di='docker images'
alias dia='docker images -a'
alias dps='docker ps'
alias dpsa='docker ps -a'

alias dip!='docker image prune -a'
alias dsp!='docker system prune -a'

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
