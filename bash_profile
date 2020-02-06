if [ -x "$(command -v brew)" ] && [ -f $(brew --prefix)/etc/bash_completion.d/git-completion.bash ]; then
  . $(brew --prefix)/etc/bash_completion.d/git-completion.bash
fi

if [ -f "/usr/local/git/contrib/completion/git-prompt.sh" ]; then
  . /usr/local/git/contrib/completion/git-prompt.sh
else
  __git_ps1 ()
  {
    git rev-parse --abbrev-ref HEAD 2> /dev/null
  }
fi

# VIMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
set -o vi

# Magic PS1 does magical things when in a git repo
PS1='\[\033[32m\]\W\[\033[00m\]:\[\033[31m\]$(__git_ps1)\[\033[00m\] \$ '

# This is useful on OSX...
export PATH="/usr/local/bin:$PATH"

# Allow the g alias to work with auto-completion
complete -o default -o nospace -F _git git g

# Set the default editors for commit messages
export EDITOR='vim -v'

# General aliases
alias ls="ls -G"

# Keeping all code in /Volumes/Code, this is handy.
code ()
{
  cd "/Volumes/Code/$1"
}

# Add support for Postgres.app
export PATH=$PATH:/Applications/Postgres.app/Contents/Versions/9.4/bin

# Set CLICOLOR if you want Ansi Colors in iTerm2 
export CLICOLOR=1

# Set colors to match iTerm2 Terminal Colors
export TERM=xterm-256color

# Support dev
if [[ -f /opt/dev/dev.sh ]]; then source /opt/dev/dev.sh; fi

# Support GO
export GOPATH=$HOME
export PATH=$GOPATH/bin:$PATH

# Bring in chbrochure
if [[ -f ~/.chbrochure ]]; then source ~/.chbrochure; fi
