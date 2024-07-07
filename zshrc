proj() {
  mkdir -p ~/Code/$1
  cd ~/Code/$1
  tmux new-session -A -s $1
}
