# Exit if not running interactively
[[ $- != *i* ]] && return

########## History ##########

# Eternal, timestamped history
HISTCONTROL=ignoreboth
HISTFILE="$HOME/.bash_eternal_history"
HISTFILESIZE=
HISTSIZE=
HISTTIMEFORMAT="%F %T "

# Append, not overwrite
shopt -s histappend

# Save history after every command
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

# Keep terminal size accurate
shopt -s checkwinsize

########## Pager ##########

# Enhanced 'less'
if command -v lesspipe &>/dev/null; then
    eval "$(SHELL=/bin/sh lesspipe)"
fi

########## Prompt ##########

# colored user@host:path
#PS1='\[\e[1;32m\]\u@\h\[\e[0m\]:\[\e[1;34m\]\w\[\e[0m\]\$ '
PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\W\[\033[00m\]\$ '

########## Colors & Aliases ##########

# Color support
if command -v dircolors &>/dev/null; then
    if [[ -r "$HOME/.dircolors" ]]; then
        eval "$(dircolors -b "$HOME/.dircolors")"
    else
        eval "$(dircolors -b)"
    fi

    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Common ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Notification for long commands:  sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history | tail -n1 | sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

########## Completion ##########

if ! shopt -oq posix; then
  if [[ -f /usr/share/bash-completion/bash_completion ]]; then
    . /usr/share/bash-completion/bash_completion
  elif [[ -f /etc/bash_completion ]]; then
    . /etc/bash_completion
  fi
fi

########## PATH / Tools ##########

# Put ~/.local/bin at front
export PATH="$HOME/.local/bin:$PATH"

# Cargo / Rust
[[ -f "$HOME/.cargo/env" ]] && . "$HOME/.cargo/env"
