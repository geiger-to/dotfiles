INSTALL_DIR=~/.vim

install:
	rsync -av -f "+ *vimrc" -f "- .*" .git . $(INSTALL_DIR)
