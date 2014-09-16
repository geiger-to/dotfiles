CWD := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

bash:
	rm -f ~/.bash_profile
	ln -s $(CWD)/bash_profile ~/.bash_profile
	
git:
	rm -f ~/.gitconfig ~/.gitignore
	ln -s $(CWD)/gitconfig ~/.gitconfig
	ln -s $(CWD)/gitignore ~/.gitignore

all: bash git
