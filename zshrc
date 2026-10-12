proj() {
  mkdir -p ~/Projects/$1
  cd ~/Projects/$1
  tmux new-session -A -s $1
}

export DO_NOT_TRACK=1
export EDITOR=vim

if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

  # Not the best...
  chmod go-w $(brew --prefix)/share
  chmod -R go-w $(brew --prefix)/share/zsh

  autoload -Uz compinit
  compinit
fi

DOTFILES=${${(%):-%x}:A:h}

if [[ $(defaults read -g AppleInterfaceStyle 2>/dev/null) == Dark ]]; then
  CATPPUCCIN_FLAVOR=mocha
else
  CATPPUCCIN_FLAVOR=latte
fi

export LG_CONFIG_FILE=$DOTFILES/lazygit/$CATPPUCCIN_FLAVOR.yml
source $DOTFILES/zsh/catppuccin_$CATPPUCCIN_FLAVOR-zsh-syntax-highlighting.zsh

source $(brew --prefix)/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh
source $(brew --prefix)/share/zsh-system-clipboard/zsh-system-clipboard.zsh
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

if command -v mise >/dev/null 2>&1; then
  eval "$(mise activate zsh)"
fi

# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/geiger/.cache/lm-studio/bin"
# End of LM Studio CLI section


# Created by `pipx` on 2026-05-25 00:17:08
export PATH="$PATH:/Users/geiger/.local/bin"
