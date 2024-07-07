proj() {
  cd ~/Code/$1
  tmux new-session -A -s $1
}
