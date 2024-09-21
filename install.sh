#!/bin/bash

# Inspired by https://github.com/michaeljsmalley/dotfiles/blob/master/makesymlinks.sh
dotfiles="dotfiles"                                       # dotfiles directory
home_dotfiles="$HOME/.dotfiles"                               # home dotfiles directory
dotfiles_old="$HOME/.dotfiles_old_$(date +%Y-%m-%d-%H-%M-%S)"  # old dotfiles backup directory

files=()                          # list of files/folders to symlink in homedir
while IFS=  read -r -d $'\0'; do
  files+=("$REPLY")
done < <(find $dotfiles -maxdepth 1 -print0)

echo "Files ${files}"

##########

# create dotfiles_old in homedir
echo -n "Creating $dotfiles_old for backup of any existing dotfiles in $HOME ..."
mkdir -p $dotfiles_old
echo "done"

# move any existing dotfiles in homedir to dotfiles_old directory
for file in $files; do
  echo "Moving any existing dotfiles from $HOME to $dotfiles_old"
  mv $HOME/$file $dotfiles_old/ 
done

# copy the dotfiles directory to the homedir
cp -r $dotfiles $home_dotfiles

# change to the home_dotfiles directory
echo -n "Changing to the $home_dotfiles directory ..."
cd $home_dotfiles
echo "done"

# create symlinks from the homedir to any files in the $HOME/dotfiles directory specified in $files
for file in $files; do
  echo "Creating symlink to $file in home directory."
  ln -s $home_dotfiles/$file $HOME/$file
done
