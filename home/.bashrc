source ~/git-prompt.sh

PROMPT_COMMAND='__posh_git_ps1 "\u@\h:\w " "\\\$ ";'$PROMPT_COMMAND

echo 'bash'

complete -C /Applications/vault vault
