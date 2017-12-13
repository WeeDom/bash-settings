#!/bin/bash

echo "you do have your keys set up, right?"
echo "This script will try to set up git, bashrc and vim with Dom's favourite settings"
echo "set up git correctly"

echo "cd ~"
cd ~

echo "git config --global core.editor 'vim'"
git config --global core.editor 'vim'
echo "git config --global user.name 'Dominic Pain'"
git config --global user.name 'Dominic Pain'
echo "git config --global user.email 'dominic@flowmo.co'"
git config --global user.email 'dominic@flowmo.co'
echo "rm .bashrc"
rm .bashrc
echo "ln -s bash-settings/bashrc .bashrc"
ln -s bash-settings/bashrc .bashrc
echo "rm .vimrc"
rm .vimrc
echo "ln -s bash-settings/vimrc .vimrc"
ln -s bash-settings/vimrc .vimrc
echo "rm -rf .vim"
rm -rf .vim
echo "ln -s bash-settings/vim .vim"
ln -s bash-settings/vim .vim
echo "sudo apt-get update"
sudo apt-get update
echo "sudo apt-get -y install tmux"
sudo apt-get -y install tmux
echo "rm .tmux.conf"
rm .tmux.conf
echo "ln -s bash-settings/tmux.conf .tmux.conf"
ln -s bash-settings/tmux.conf .tmux.conf
