#!/bin/bash

# Inspired by https://github.com/michaeljsmalley/dotfiles/blob/master/makesymlinks.sh
dir=dotfiles                                      # dotfiles directory
olddir=~/dotfiles_old_$(date +%Y-%m-%d-%H-%M-%S)  # old dotfiles backup directory

files=()                          # list of files/folders to symlink in homedir
while IFS=  read -r -d $'\0'; do
  files+=("$REPLY")
done < <(find dotfiles -maxdepth 1 -print0)


##########

# create dotfiles_old in homedir
echo -n "Creating $olddir for backup of any existing dotfiles in ~ ..."
mkdir -p $olddir
echo "done"

# change to the dotfiles directory
echo -n "Changing to the $dir directory ..."
cd $dir
echo "done"

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks from the homedir to any files in the ~/dotfiles directory specified in $files
for file in $files; do
  echo "Moving any existing dotfiles from ~ to $olddir"
  mv ~/$file $olddir/
  echo "Creating symlink to $file in home directory."
  ln -s $dir/$file ~/$file
done
