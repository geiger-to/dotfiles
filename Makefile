CWD := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
	
git:
	rm -f ~/.gitconfig ~/.gitignore
	ln -s $(CWD)/gitconfig ~/.gitconfig
	ln -s $(CWD)/gitignore ~/.gitignore

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

brew:
	brew bundle

apt:
	apt install git vim tmux silversearcher-ag

snap:
	snap install firefox chromium

all:    git vim tmux
.PHONY: git vim tmux
