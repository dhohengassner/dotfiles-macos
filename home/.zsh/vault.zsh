#! /usr/local/bin/zsh
# Vault & AWS account login script
# Useage: <this_script> [username2]
#   __           _               _             _
#  /  \ ____ ___| |    ___ ___ _| |_ _ __ _  _| |_  __  _ __
# | /\ |  __| __| |___/ _ \ __|_   _| '__|_ \_   ()/__\|  _ \
# | \/ | | |  |_|  _  | __/__ \ | | | || |/  \| | | \/ | | | |
#  \__/|_|  \___|_| |_|___|___/ |_| |_| \__/|_|_|_|\__/|_| |_|
#         Last Updated: 2017-12-19             WHQ.CD.AppSrvcs

function vt() {

	if [ -z "$1" ]; then
		echo "Argument for user is missing" 1>&2
		return 1
	fi

	vaulty_authy() {
		if [ $(command -v jq) ]; then
			export VAULT_ADDR=$(echo $3 | jq -r '.vault.address')
			export AWS_REGION=$(echo $3 | jq -r '.aws.region')
			export AWS_DEFAULT_REGION=$(echo $3 | jq -r '.aws.region')
			unset VAULT_TOKEN
			vault login -method=ldap username="$2"
			export VAULT_TOKEN=`cat ~/.vault-token`
		else
			printf "You must have jq installed to use this script.\n"
			$?=1
		fi

		if [ $?==0 ]; then
			data=$(vault read -format=json "$1")
			export AWS_ACCESS_KEY_ID=$(echo $data | jq -r '.data.access_key')
			export AWS_SECRET_ACCESS_KEY=$(echo $data | jq -r '.data.secret_key')
		fi
	}

	awsaccounts=(lab1 lab2 hyperloop)
	bethel_values=$(<~/bethel_values.json)

	PS3='Select an account: '
	select opt in "${awsaccounts[@]}"; do
		case "$opt" in
		lab1)
			vaulty_authy "$(echo $bethel_values | jq -r '.vault.environment_creds.lab1')" "$1" $bethel_values
			break
			;;
		lab2)
			vaulty_authy "$(echo $bethel_values | jq -r '.vault.environment_creds.lab2')" "$1" $bethel_values
			break
			;;
		hyperloop)
			vaulty_authy "$(echo $bethel_values | jq -r '.vault.environment_creds.hyperloop')" "$1" $bethel_values
			break
			;;
		*)
			printf "Invalid selection. Please try again.\n"
			;;
		esac
	done

}

# alias for own user
alias vtm='vt dhohengassner2'
