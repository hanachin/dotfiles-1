export CLICOLOR=YES
autoload -U colors
colors
PROMPT="%{${fg[yellow]}%}✘╹◡╹✘%{${reset_color}%} "
PROMPT2="%{${fg[blue]}%}%_> %{${reset_color}%}"
SPROMPT="%{${fg[red]}%}correct: %R -> %r [nyae]? %{${reset_color}%}"
RPROMPT="%{${fg[blue]}%}[%~]%{${reset_color}%}"

setopt auto_cd
setopt auto_pushd

# History
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000
setopt extended_history
setopt hist_expand
setopt hist_ignore_all_dups
setopt hist_ignore_space
bindkey -e
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

autoload -U compinit
compinit
zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' max-errors 50
zstyle ':completion:*' list-colors ''
zstyle :compinstall filename "$HOME/.zshrc"

if zle -la | grep -q '^history-incremental-pattern-search'; then
  bindkey '^R' history-incremental-pattern-search-backward
  bindkey '^S' history-incremental-pattern-search-forward
fi

# Move each word to press Ctrl + Arrow-key
bindkey ";5C" forward-word
bindkey ";5D" backward-word

# ENV
export PATH="$HOME/bin:$PATH"
export EDITOR=vim

alias g="git"
alias b='bundle exec'
alias p='pbcopy'
alias o='open'
alias c='open .'
alias v='open -a macvim "$@"'
alias d='git diff'
alias s='git status --short'
alias t='tig'
alias n='screen'
alias r='bundle exec rspec'
alias q='exit'
alias z='v ~/.zshrc'
alias zz='. ~/.zshrc'
alias src='cd ~/Dropbox/src'
alias blog='open ~/Dropbox/Apps/hakolog/entries'
alias snip='open ~/.vim/bundle/snipMate/snippets'
a() { git add . $1; git status --short }
m() { git commit -m "$*" }

copy-line() { print -rn $BUFFER | pbcopy; zle -M "Copied: ${BUFFER}" }
zle -N copy-line
bindkey '\@' copy-line

# Ruby
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
case "${TERM}" in screen) preexec() { echo -ne "\ek${1%% *}\e\\" } esac

# Personal
[[ -f "$HOME/.zshrc.mine" ]] && source "$HOME/.zshrc.mine"
