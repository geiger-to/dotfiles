CWD := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

bash:
	rm -f ~/.bash_profile
	ln -s $(CWD)/bash_profile ~/.bash_profile
	
git:
	rm -f ~/.gitconfig ~/.gitignore
	ln -s $(CWD)/gitconfig ~/.gitconfig
	ln -s $(CWD)/gitignore ~/.gitignore

vim:
	rm -f ~/.vimrc
	rm -f ~/.vim
	ln -s $(CWD)/vimrc ~/.vimrc
	ln -s $(CWD)/vim ~/.vim
	
all: bash git vim
.PHONY: bash git vim
