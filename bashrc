alias bashrc='vim ~/.bashrc && source ~/.bashrc'
export EDITOR=vim

source ~/.dotfiles/bash/git-completion.bash

alias lvi='vim -c "normal '\''0"'
alias ss=script/server
alias c=script/console
alias sc='vim ~/.bashrc && source ~/.bashrc'
alias e=emacs
alias b=script/build
alias rp="rake && git push"

# put this in your .bashrc or .profile
function parse_git_dirty {
 [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit (working directory clean)" ]] && echo "*"
}
function parse_git_branch {
 git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/[\1$(parse_git_dirty)]/"
}
PS1='\u@\h:\w $(parse_git_branch) $ '
