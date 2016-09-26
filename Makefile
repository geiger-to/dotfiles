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
	vim +"call dein#install()" +qall

tmux:
	rm -f ~/.tmux.conf
	rm -f ~/.tmux
	ln -s $(CWD)/tmux.conf ~/.tmux.conf
	ln -s $(CWD)/tmux ~/.tmux

ycm: vim
	~/.vim/repos/github.com/Valloric/YouCompleteMe/install.py

deps:
	$(info )
	$(info You'll want to install the following:)
	$(info   - TMUX 1.9)
	$(info   - VIM 7.4)
	$(info   - Git 2.0)
	$(info   - Ag (the silver searcher))
	$(info   - reattach-to-user-namespace)


all:    bash git vim ycm tmux deps
.PHONY: bash git vim ycm tmux deps
