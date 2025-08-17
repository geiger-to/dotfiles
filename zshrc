proj() {
  mkdir -p ~/Projects/$1
  cd ~/Projects/$1
  tmux new-session -A -s $1
}

export DO_NOT_TRACK=1
