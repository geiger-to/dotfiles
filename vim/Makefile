INSTALL_DIR=~/.vim

install:
	rm ~/.vimrc
	rsync -av -f "+ *vimrc" -f "- .*" .git . $(INSTALL_DIR)
	ln -s $(INSTALL_DIR)/vimrc ~/.vimrc

