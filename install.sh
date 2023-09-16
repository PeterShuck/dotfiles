#!/bin/bash

set -ex

pushd $HOME

# install bash-it
git clone --depth=1 https://github.com/Bash-it/bash-it.git .bash_it
.bash_it/install.sh --silent

# link dotfiles
# this function makes everything on the machine a dotfile, find a different way of setup
# repo_dir=$(dirname $0)
repo_dir=dotfiles
 for dotfile in $(find $repo_dir -type f -name '.[a-zA-Z]*'); do
 	file=$(basename $dotfile)
   if [ -e $file ]; then
     mv $file ${file}.bak
   fi
 	ln -sf $dotfile
done

popd

exit 0
