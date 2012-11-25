autoload -U colors
autoload -U add-zsh-hook
autoload -Uz vcs_info
autoload -U compinit
autoload history-search-end

# Prompt
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "+"
zstyle ':vcs_info:git:*' unstagedstr "-"
zstyle ':vcs_info:git:*' formats '(%b)%c%u'
zstyle ':vcs_info:git:*' actionformats '(%b|%a)%c%u'
function _update_vcs_info_msg() {
  psvar=()
  LANG=en_US.UTF-8 vcs_info
  [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
}
add-zsh-hook precmd _update_vcs_info_msg
colors
PROMPT="%{${fg[yellow]}%}✘╹◡╹✘%{${reset_color}%} "
PROMPT2="%{${fg[blue]}%}%_> %{${reset_color}%}"
SPROMPT="%{${fg[red]}%}correct: %R -> %r [nyae]? %{${reset_color}%}"
VCS_PROMPT="%1(v|%F{green} %1v%f|)"
DIR_PROMPT="%{${fg[blue]}%}[%~]%{${reset_color}%}"
RPROMPT="$VCS_PROMPT $DIR_PROMPT"
export MYSQL_PS1="$(echo -e "<\\\U> [\\\d]\\\n(L:\\\c) \e[33m✘╹◡╹✘\e[m ")"

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
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

compinit
zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' max-errors 50
zstyle ':completion:*' list-colors ''
zstyle :compinstall filename "$HOME/.zshrc"

if zle -la | grep -q '^history-incremental-pattern-search'; then
  bindkey '^R' history-incremental-pattern-search-backward
  bindkey '^S' history-incremental-pattern-search-forward
fi

# ENV
export PATH="/usr/local/bin:$PATH"
export PATH="$HOME/bin:$PATH"
export EDITOR=vim
export CLICOLOR=YES
export GITHUB_HOST=github.cookpad.com

alias ls='ls -1'
alias git='hub'
alias g='git'
alias x='xargs'
alias b='bundle exec'
alias p='pbcopy'
alias o='open'
alias c='open .'
alias v='open -a macvim "$@"'
#alias v='vim'
alias sub='open -a "Sublime Text 2" "$@"'
alias d='git diff'
alias s='git status --short'
alias t='tig'
alias n='screen'
alias r='bundle exec rspec -f d'
alias q='exit'
alias z='v ~/.zshrc'
alias zz='. ~/.zshrc'
alias vv='v ~/.vimrc'
alias gg='git grep'
alias src='cd ~/Dropbox/src'
alias blog='open ~/Dropbox/Apps/hakolog/entries'
alias snip='open ~/.vim/bundle/snipMate/snippets'
alias br='git symbolic-ref HEAD | cut -b 12-'
alias sha1='git rev-parse HEAD'
alias l='ls'
alias copy='tmux save - | pbcopy'
alias chrome='open -a "Google Chrome" "$@"'
alias con='git rebase --continue'
a() { git add . $1; git status --short }
m() { git commit -m "$*" }
u() { cd ./$(git rev-parse --show-cdup)/$1 }
ga() {
  if [ $# -eq 1 ]; then
      git add `git status -s -b | grep -v "^#" | awk '{print$1="";print}' | grep -v "^$" | awk "NR==$1"`
  fi
}
gd() {
  if [ $# -eq 1 ]; then
      git diff -- `git status -s -b | grep -v "^#" | awk '{print$1="";print}' | grep -v "^$" | awk "NR==$1"`
  fi
}
gv() {
  if [ $# -eq 1 ]; then
      v `git status -s -b | grep -v "^#" | awk '{print$1="";print}' | grep -v "^$" | awk "NR==$1"`
  fi
}
gr() {
  if [ $# -eq 1 ]; then
      git reset `git status -s -b | grep -v "^#" | awk '{print$1="";print}' | grep -v "^$" | awk "NR==$1"`
  fi
}

copy-line() { print -rn $BUFFER | pbcopy; zle -M "Copied: ${BUFFER}" }
zle -N copy-line
bindkey '1~' copy-line

# Ruby
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
case "${TERM}" in screen) preexec() { echo -ne "\ek${1%% *}\e\\" } esac
PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

export NODE_PATH='/usr/local/lib/node_modules/'

[ -f ~/.zshrc.local ] && source ~/.zshrc.local
