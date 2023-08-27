# vim:ft=zsh:

# Set up some reasonable defaults
export LANG=en_US.UTF-8

export PATH="$HOME/.local/bin:$HOME/bin:/usr/local/bin:/usr/local/bin:/usr/bin:/usr/sbin:/bin:/sbin"
export MANPATH="$HOME/.local/man:/usr/local/man:$MANPATH"

if command -v nvim 1>/dev/null; then
  export EDITOR=nvim
  alias vim=nvim
else
  export EDITOR=vi
fi

umask 022

# ZSH configuration
if [[ -e "$HOME/.oh-my-zsh" ]]; then
  export ZSH=$HOME/.oh-my-zsh
  ZSH_THEME="robbyrussell"
  DISABLE_AUTO_UPDATE="true"

  plugins=(vi-mode git tmux colored-man-pages fasd)
fi

# Theme
[[ "$TERM" != "linux" && -z "$TMUX" ]] && . "$HOME/.theme"

# Go
export GOBIN="$HOME/.local/bin"

# Nix
if [ -e /home/alde/.nix-profile/etc/profile.d/nix.sh ]; then
  . /home/alde/.nix-profile/etc/profile.d/nix.sh
fi

# WSL Configuration
if [[ -n "$WSLENV" ]]; then
  # Forward X11 to server on host
  export DISPLAY="$(awk '/^nameserver / { print $2; exit }' /etc/resolv.conf 2>/dev/null):0"
  export LIBGL_ALWAYS_INDIRECT=1
fi

# Configure fzf
if [[ -e "$HOME/.fzf" ]]; then
  export FZF_BASE="$HOME/.fzf"

  if command -v ag 1>/dev/null; then
    export FZF_DEFAULT_COMMAND='ag -g ""'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  fi

  [[ -n "$ZSH" ]] && plugins+=(fzf)
fi

# Configure pyenv
if [[ -e "$HOME/.pyenv" ]]; then
  export PYENV_ROOT="$HOME/.pyenv"

  [[ -n "$ZSH" ]] && plugins+=(pyenv)
fi

# Configure asdf
if [[ -e "$HOME/.asdf" ]]; then
  [[ -n "$ZSH" ]] && plugins+=(asdf)
fi

[[ -n "$ZSH" ]] && . $ZSH/oh-my-zsh.sh
