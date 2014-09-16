if [ -f "/usr/local/git/contrib/completion/git-completion.bash" ]; then
  . /usr/local/git/contrib/completion/git-completion.bash
fi

if [ -f "/usr/local/git/contrib/completion/git-prompt.sh" ]; then
  . /usr/local/git/contrib/completion/git-prompt.sh
else
  __git_ps1 ()
  {
    git rev-parse --abbrev-ref HEAD 2> /dev/null
  }
fi

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
