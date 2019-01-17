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

dbash() { docker exec -it $(docker ps -aqf "name=$1") /bin/bash; }

dsh() { docker exec -it $(docker ps -aqf "name=$1") /bin/sh; }

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
	eval "$(docker-machine env dh-docker-toolbox)"
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

ggc() {
	if [ $# -eq 1 ]; then
		ggpath=$1
		currGoPrj=$(echo ${ggpath#*@} | sed 's/.\{4\}$//' | tr : /)
		GIT_TERMINAL_PROMPT=1 go get -d -v -t $currGoPrj
		cd "$GOPATH/src/$currGoPrj"
	else
		echo "odd parameter - parameter count (should be 1): $#"
	fi
}

lab2access() {
	saml2aws login

	export AWS_REGION=$(echo $bethel_values | jq -r '.aws.region')
	export AWS_DEFAULT_REGION=$(echo $bethel_values | jq -r '.aws.region')

	json=$(aws sts assume-role --role-arn $(echo $bethel_values | jq -r '.aws.accounts.lab2.role') --role-session-name "dhlab2access" --profile 'saml2aws')
	export AWS_ACCESS_KEY_ID=$(echo $json | jq .Credentials.AccessKeyId --raw-output)
	export AWS_SECRET_ACCESS_KEY=$(echo $json | jq .Credentials.SecretAccessKey --raw-output)
	export AWS_SESSION_TOKEN=$(echo $json | jq .Credentials.SessionToken --raw-output)
}

hyperloopaccess() {
	saml2aws login

	export AWS_REGION=$(echo $bethel_values | jq -r '.aws.region')
	export AWS_DEFAULT_REGION=$(echo $bethel_values | jq -r '.aws.region')

	json=$(aws sts assume-role --role-arn $(echo $bethel_values | jq -r '.aws.accounts.hyperloop.role') --role-session-name "dhhyperloopaccess" --profile 'saml2aws')
	export AWS_ACCESS_KEY_ID=$(echo $json | jq .Credentials.AccessKeyId --raw-output)
	export AWS_SECRET_ACCESS_KEY=$(echo $json | jq .Credentials.SecretAccessKey --raw-output)
	export AWS_SESSION_TOKEN=$(echo $json | jq .Credentials.SessionToken --raw-output)
}

install_bethel_certs() {
	wget -q $(echo $bethel_values | jq -r '.bethel.cert_url') -O ~/install_certs.sh
	chmod +x ~/install_certs.sh
	~/install_certs.sh
}
