### git extensions for bash

## newest file from git.git
. ~/git/git/contrib/completion/git-completion.bash
. ~/git/git/contrib/completion/git-prompt.sh

## show staged changes
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWSTASHSTATE=1
GIT_PS1_SHOWUPSTREAM="auto"
GIT_PS1_SHOWCOLORHINTS=1
GIT_PS1_SHOWUNTRACKEDFILES=1
#GIT_PS1_SHOWUPSTREAM="verbose"

## extend regular prompt with git-prompt
_orig_ps1="$PS1"
__fmt_exit_code() { test "$1" -ne 0 && printf '\[\033[31m\]✘ \[\033[0m\]' "$1"; }
__show_exit_code() {
	local dollar='\$ '
	PS1="$(__fmt_exit_code $1)${_orig_ps1%"$dollar"}$dollar"
}
__git_prompt(){
	local dollar='\$ '
	__git_ps1 "${PS1%"$dollar"}" "\n$dollar"
}
PROMPT_COMMAND="ec=\$?;${PROMPT_COMMAND:-:};__show_exit_code \$ec;__git_prompt"

## single letters are so neat!
alias g='git'

## extend completion for our alias g
complete -o bashdefault -o default -o nospace -F __git_wrap__git_main g 2>/dev/null \
	|| complete -o default -o nospace -F _git_wrap__git_main g

