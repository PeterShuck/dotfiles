# Aliases
alias ll='ls -alF'
alias psg='ps -ef | grep -v grep | grep'
alias h='history'
alias gvim="mvim"

alias be='bundle exec'
# git prompt
. ~/.git-prompt.sh
export PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ '

# bump ulimit the way apache does
ulimit -S -n `ulimit -H -n`

# time zone
# export TZ=America/New_York  # breaks unit tests that depend on GMT

# editor for bundle open, etc.
export EDITOR=vim
