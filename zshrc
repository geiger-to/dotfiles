proj() {
  mkdir -p ~/Projects/$1
  cd ~/Projects/$1
  tmux new-session -A -s $1
}

export DO_NOT_TRACK=1
export EDITOR=vim

source $HOMEBREW_PREFIX/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh
source $HOMEBREW_PREFIX/share/zsh-system-clipboard/zsh-system-clipboard.zsh
source $HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
