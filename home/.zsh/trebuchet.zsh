#! /usr/local/bin/zsh
#   __           _               _             _
#  /  \ ____ ___| |    ___ ___ _| |_ _ __ _  _| |_  __  _ __
# | /\ |  __| __| |___/ _ \ __|_   _| '__|_ \_   ()/__\|  _ \
# | \/ | | |  |_|  _  | __/__ \ | | | || |/  \| | | \/ | | | |
#  \__/|_|  \___|_| |_|___|___/ |_| |_| \__/|_|_|_|\__/|_| |_|
#         Last Updated: 2017-12-19             WHQ.CD.AppSrvcs

function trebenv() {

	bethel_values=$(<~/bethel_values.json)

	export TREB_ZONE=$(echo $bethel_values | jq -r '.trebuchet.zone')
	export TREB_SPOT_MAX_PRICE=$(echo $bethel_values | jq -r '.trebuchet.max_spot_price')
	export TREB_NODE_COUNT=2
	export TREB_NODE_SIZE=t2.medium
	export TREB_MASTER_SIZE=t2.medium
	export TREB_CLUSTER_PREFIX=dh-test
	export TREB_SSH_ACCESS_ENABLED=true
	export TREB_CL_OWNER=dh
	export TREB_CL_PROJECT=$(echo $bethel_values | jq -r '.trebuchet.cl_project')
	export AWS_ACCOUNT=$(echo $bethel_values | jq -r '.aws.accounts.lab1')

	# kops env
	# export NAME=$(echo $bethel_values | jq -r '.kops.cluster_name')
	# export EDITOR=vim
	# export KOPS_STATE_STORE=$(echo $bethel_values | jq -r '.kops.default_state_store')
}
