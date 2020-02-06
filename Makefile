CWD := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

bash:
	rm -f ~/.bash_profile
	ln -s $(CWD)/bash_profile ~/.bash_profile
	
git:
	rm -f ~/.gitconfig ~/.gitignore
	ln -s $(CWD)/gitconfig ~/.gitconfig
	ln -s $(CWD)/gitignore ~/.gitignore
	rm -f ~/.git-completion.bash
	ln -s $(CWD)/git-completion.bash ~/.git-completion.bash

vim:
	rm -f ~/.vimrc
	rm -rf ~/.vim
	ln -s $(CWD)/vimrc ~/.vimrc
	ln -s $(CWD)/vim ~/.vim
	vim +"call dein#install()" +qall

tmux:
	rm -f ~/.tmux.conf
	rm -f ~/.tmux
	ln -s $(CWD)/tmux.conf ~/.tmux.conf
	ln -s $(CWD)/tmux ~/.tmux

hyper:
	rm -f ~/.hyper.js
	ln -s $(CWD)/hyper.js ~/.hyper.js

brew:
	brew bundle

apt:
	apt install git vim tmux silversearcher-ag

snap:
	snap install firefox chromium

all:    bash git vim tmux
.PHONY: bash git vim tmux
