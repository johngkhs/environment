setopt interactive_comments

###############################################################################################################
#                                         environment variables                                               #
###############################################################################################################

export PATH="$HOME/usr/bin:$PATH"
export LD_LIBRARY_PATH="$HOME/usr/lib:$LD_LIBRARY_PATH"
export PYTHONPATH="$HOME/usr/lib/python:$PYTHONPATH"
export EDITOR=vim

###############################################################################################################
#                                           general settings                                                  #
###############################################################################################################

autoload -U colors && colors
setopt extended_glob
unsetopt correct_all

###############################################################################################################
#                                               history                                                       #
###############################################################################################################

export HISTFILE="$HOME/.history"
export HISTSIZE=3000
export SAVEHIST=3000
setopt append_history
setopt extended_history
setopt inc_append_history
setopt hist_ignore_all_dups
setopt share_history

###############################################################################################################
#                                            vim inner motions                                                #
###############################################################################################################

autoload -U select-quoted
autoload -U select-bracketed
zle -N select-quoted
zle -N select-bracketed

for mode in visual viopp; do
  for keymap in {a,i}{\',\",\`}; do
    bindkey -M "$mode" "$keymap" select-quoted
  done
done

for mode in visual viopp; do
  for keymap in {a,i}{\(,\),\[,\],\{,\},\<,\>,b,B}; do
    bindkey -M "$mode" "$keymap" select-bracketed
  done
done

###############################################################################################################
#                                               vim mode                                                      #
###############################################################################################################

bindkey -v
bindkey -M viins 'jk' vi-cmd-mode
bindkey "^?" backward-delete-char

###############################################################################################################
#                                            powerline prompt                                                 #
###############################################################################################################

source "$HOME/.config/powerline/source_powerline.zsh"
powerline-daemon -q

###############################################################################################################
#                                             tab completion                                                  #
###############################################################################################################

autoload -U compinit && compinit
setopt menu_complete
zmodload zsh/complist

zstyle ':completion:*' menu select=1
zstyle ':completion:*' matcher-list '' \
  'm:{a-z\-}={A-Z\_}' \
  'r:[^[:alpha:]]||[[:alpha:]]=** r:|=* m:{a-z\-}={A-Z\_}' \
  'r:[[:ascii:]]||[[:ascii:]]=** r:|=* m:{a-z\-}={A-Z\_}'
zstyle ':completion:*' completer _complete _approximate
zstyle ':completion:*:approximate:::' max-errors 1 numeric
zstyle -e ':completion:*:default' list-colors 'reply=("${PREFIX:+=(#bi)($PREFIX:t)(?)*==02=01}:${(s.:.)LS_COLORS}")'
zstyle ':completion:*:*:*:*:processes' command 'ps -u $USER -o pid,user,command -w -w'
zstyle ':completion:*' file-sort modification
bindkey -M menuselect '^[[Z' reverse-menu-complete

###############################################################################################################
#                                       zsh-history-substring-search                                          #
###############################################################################################################

source "$HOME/.zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh"
bindkey -M vicmd 'j' history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up

###############################################################################################################
#                                         zsh-syntax-highlighting                                             #
###############################################################################################################

source "$HOME/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=red,bold'
ZSH_HIGHLIGHT_STYLES[alias]='fg=green,bold'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=green,bold'
ZSH_HIGHLIGHT_STYLES[function]='fg=green,bold'
ZSH_HIGHLIGHT_STYLES[command]='fg=green,bold'
ZSH_HIGHLIGHT_STYLES[path]='fg=white,bold'
ZSH_HIGHLIGHT_STYLES[path_prefix]='fg=white,underline'
ZSH_HIGHLIGHT_STYLES[globbing]='fg=gray'

###############################################################################################################
#                                                z                                                            #
###############################################################################################################

source "$HOME/.zsh/plugins/z/z.sh"

###############################################################################################################
#                                            zsh-extract                                                      #
###############################################################################################################

source "$HOME/.zsh/plugins/zsh-extract/extract.plugin.zsh"

###############################################################################################################
#                                               fzf                                                           #
###############################################################################################################

export FZF_DEFAULT_COMMAND='ag -g ""'
export FZF_DEFAULT_OPTS="--reverse --bind=tab:down,btab:up"

###############################################################################################################
#                                             functions                                                       #
###############################################################################################################

function c() { cd "$(z -l | awk {'print $2}' | fzf)" }

###############################################################################################################
#                                              aliases                                                        #
###############################################################################################################

alias y='vim /tmp/pane.txt -c "normal! Gkk"'
alias ls='ls -Fa'
alias g='git'
alias m='unbuffer make -j8 |& less -R'