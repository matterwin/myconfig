[ -f ~/.fzf.bash ] && source ~/.fzf.bash

alias tmux="TERM=screen-256color-bce tmux"

copyfile() {
  if [ -z "$1" ]; then
    echo "Usage: copyfile filename"
    return 1
  fi
  cat "$1" | clip.exe
}

# Add these to bottom of bashrc
