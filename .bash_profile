# .bash_profile
# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi
# User specific environment and startup programs
PATH=$PATH:$HOME/.local/bin:$HOME/bin
export PATH
export TERM=xterm-256color
# Get additional aliases and functions
if [ -f ~/.profile ]; then
	. ~/.profile
fi
# git completion
if [ -f /etc/bash_completion.d/git ]; then
  source /etc/bash_completion.d/git
fi
