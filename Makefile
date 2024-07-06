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

nvim:
	rm -rf ~/.config/nvim
	rm -rf ~/.local/share/nvim
	rm -rf ~/.local/state/nvim
	rm -rf ~/.cache/nvim
	ln -s $(CWD)/nvim ~/.config/nvim

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

all:    git vim nvim tmux
.PHONY: git vim nvim tmux
