proj() {
  mkdir -p ~/Projects/$1
  cd ~/Projects/$1
  tmux new-session -A -s $1
}

export DO_NOT_TRACK=1
export EDITOR=vim

if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

  chmod go-w $(brew --prefix)/share
  chmod -R go-w $(brew --prefix)/share/zsh

  autoload -Uz compinit
  compinit
fi

source $(brew --prefix)/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh
source $(brew --prefix)/share/zsh-system-clipboard/zsh-system-clipboard.zsh
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
