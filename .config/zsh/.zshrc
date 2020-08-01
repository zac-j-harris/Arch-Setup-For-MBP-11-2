#!/bin/sh

# aliases
source $HOME/.config/zsh/aliasrc

# run scripts as binary
export PATH=$PATH:$HOME/.config/scripts

# plugins
source $HOME/.local/share/zsh/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
source $HOME/.local/share/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $HOME/.local/share/zsh/directory.zsh

# history conf
HISTFILE=$HOME/.zsh_history
HISTSIZE=10000000
SAVEHIST=10000000
setopt EXTENDED_HISTORY
setopt INC_APPEND_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt SHARE_HISTORY
setopt HIST_BEEP

# keybindings
bindkey '^a' beginning-of-line
bindkey '^b' backward-char
bindkey '^e' end-of-line
bindkey '^f' forward-char
bindkey '^u' kill-whole-line

# case insensitive autocomplete
autoload -U compinit && compinit
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' '+l:|=* r:|=*'

# prompt
PROMPT='%~ >> '
setopt prompt_subst
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
RPROMPT=\$vcs_info_msg_0_
zstyle ':vcs_info:git:*' formats '%F{green}(%b)%f'
zstyle ':vcs_info:*' enable git
