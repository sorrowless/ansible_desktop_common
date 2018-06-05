# Cautiously export 'vim' as an editor - it will immediately break ^R and so on
# keybindings in some cases.
export EDITOR="vim"

# Use zgen (https://github.com/tarjoilija/zgen.git) to manage plugins for zsh.
# We try to automatically download it if it doesn't exists and also will auto
# apply it for current shell
#
# Export needed variables
ZGEN_GHUB='https://github.com/tarjoilija/zgen.git'
ZGEN_HOME="${HOME}/.zgen"
ZGEN_FILE="${ZGEN_HOME}/zgen.zsh"
RC=1
#
# Check if zgen directory exists, if not - install zgen
if [ ! -d "${ZGEN_HOME}" ]; then
  echo "zgen plugins manager directory ${ZGEN_HOME} not found, try to install zgen"
  type git 1>/dev/null 2>&1
  RC=$?
  if [ "$RC" -ne 0 ]; then
    echo "cannot find git, skip installing zgen"
  else
    git clone ${ZGEN_GHUB} ${ZGEN_HOME}
    RC=$?
    if [ "$RC" -ne 0 ]; then
      echo "cannot clone zgen repository from ${ZGEN_GHUB}, skip installing zgen"
    fi
  fi
else
  RC=0
fi
if [ -f "${ZGEN_FILE}" ] && [ "$RC" -eq 0 ]; then
  #
  # Load zgen
  source "${HOME}/.zgen/zgen.zsh"
  # If the init scipt doesn't exist
  if ! zgen saved; then

    # Plugins list here
    zgen load marzocchi/zsh-notify
    zgen load zsh-users/zsh-syntax-highlighting
    zgen load supercrabtree/k

    # Generate the init script from plugins above
    zgen save
  fi

  # Settings for zsh-notify plugin
  zstyle ':notify:*' error-title Error
  zstyle ':notify:*' success-title Success
  zstyle ':notify:*' command-complete-timeout 5
  # End settings for zsh-notify plugin
else
  echo "zgen plugins manager main file ${ZGEN_FILE} doesn't exists, skip plugins initialization"
fi
# End zgen plugins manager initialization

autoload zkbd
[[ ! -d ~/.zkbd ]] && mkdir ~/.zkbd
if [[ ! -f ~/.zkbd/$TERM-${${DISPLAY:t}:-$VENDOR-$OSTYPE} ]]; then
  zkbd
else
  source ~/.zkbd/$TERM-${${DISPLAY:t}:-$VENDOR-$OSTYPE}
  #setup key accordingly
  [[ -n "${key[Home]}"    ]]  && bindkey  "${key[Home]}"    beginning-of-line
  [[ -n "${key[End]}"     ]]  && bindkey  "${key[End]}"     end-of-line
  [[ -n "${key[Insert]}"  ]]  && bindkey  "${key[Insert]}"  overwrite-mode
  [[ -n "${key[Delete]}"  ]]  && bindkey  "${key[Delete]}"  delete-char
  [[ -n "${key[Up]}"      ]]  && bindkey  "${key[Up]}"      up-line-or-history
  [[ -n "${key[Down]}"    ]]  && bindkey  "${key[Down]}"    down-line-or-history
  [[ -n "${key[Left]}"    ]]  && bindkey  "${key[Left]}"    backward-char
  [[ -n "${key[Right]}"   ]]  && bindkey  "${key[Right]}"   forward-char
fi

# History options
export HISTSIZE=10000
export HISTFILE="$HOME/.history"
export SAVEHIST=$HISTSIZE
setopt inc_append_history
setopt hist_ignore_dups
setopt hist_ignore_space

setopt noflowcontrol
# if you will not set promptsubst then your prompt will be computed only one time
# when it will be set first time
setopt promptsubst

autoload -Uz compinit
compinit

# Actually, I hate default zsh autoselect, so - no select
zstyle ':completion:::*:default' menu no select

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' completer _expand _complete _ignored _approximate
zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'
zstyle ':completion::complete:*' use-cache 1
zstyle ':completion:*:descriptions' format '%U%F{cyan}%d%f%u'

#autoload -U promptinit
#promptinit
#prompt adam2 cyan blue cyan black
autoload -U colors && colors

function who_am_i {
    # this function shows who I am and where I'm sitting now
    # %n is $USERNAME variable. %m is The hostname up to the first ‘.’
    echo "%{$fg[magenta]%}%n%{$reset_color%} %{$fg[white]%}at%{$reset_color%} %{$fg[yellow]%}%m%{$reset_color%}"
}

function happy_sad {
    # next line is just ternary operator in zsh. It shows ^_^ if last command was true
    # and o_O if it was false
    echo "%(?.%{$fg[green]%}^_^%{$reset_color%}.%{$fg[red]%}o_O%{$reset_color%})"
}

function red_green {
    # The same as for happy_sad but for '>' prompt
    echo "%(?.%{$fg[green]%}>%{$reset_color%}.%{$fg[red]%}>%{$reset_color%})"
}

function gitbranch {
    # find current git branch
    local ret="$(git rev-parse --abbrev-ref HEAD 2>/dev/null)"
    # and test that it is not null. If not null - then print it.
    [ $ret ] && echo "%{$reset_color%}[%{$fg[red]%}$ret%{$reset_color%}]"
}

# it MUST be in singlequotes. Otherwise, promptsubst will not be working
PROMPT='
$(who_am_i) %{$fg[white]%}in%{$reset_color%} %{$fg_no_bold[cyan]%}%d%{$reset_color%} $(gitbranch)
$(red_green) '
# set right prompt side
function zle-line-init zle-keymap-select {
    VIM_PROMPT="%{$fg_bold[yellow]%} [% NORMAL]% %{$reset_color%}"
    RPS1="${${KEYMAP/vicmd/$VIM_PROMPT}/(main|)/}"
    zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select
bindkey -e
bindkey 'ii' vi-cmd-mode
bindkey ',,' insert-last-word
bindkey '^[.' insert-last-word
bindkey '^R' history-incremental-search-backward
bindkey '<<' history-incremental-search-backward
bindkey '^H' backward-kill-word
bindkey '^b' backward-word
bindkey '^f' forward-word

alias cp='cp -iv'
alias rcp='rsync -v --progress'
alias rmv='rsync -v --progress --remove-source-files'
alias mv='mv -iv'
alias rm='rm -iv'
alias rmdir='rmdir -v'
alias ln='ln -v'
alias chmod="chmod -c"
alias chown="chown -c"
alias du='du -hc'
alias df='df -h'
alias svim='sudo vim'
alias scat='openssl x509 -text -noout -in'
alias sctl='systemctl'
alias sclu='systemctl list-units'
alias ipsave='sudo iptables-save'
if command -v colordiff > /dev/null 2>&1; then
    alias diff="colordiff -Nar"
    alias diffy="colordiff -Nar -y --suppress-common-lines"
else
    alias diff="diff -Nar"
    alias diffy="diff -Nar -y --suppress-common-lines"
fi
alias grep='grep --colour=auto'
alias egrep='egrep --colour=auto'
alias clip='fc -e - 2>/dev/null | xsel -i -b'
alias speedtest="curl -s -w 'Testing Website Response Time for: %{url_effective}\n\nLookup Time:\t\t%{time_namelookup}\nConnect Time:\t\t%{time_connect}\nPre-transfer Time:\t%{time_pretransfer}\nStart-transfer Time:\t%{time_starttransfer}\n\nTotal Time:\t\t%{time_total}\n' -o /dev/null"

# Git aliases
alias gst='git status'
alias gco='git checkout'
alias grv='git remote -v'

# Translation aliases
alias enru='trans en:ru -b'
alias ruen='trans ru:en -b'

# Docker aliases
alias dps='sudo docker ps'
alias dpsa='sudo docker ps --all'
alias dips='sudo docker images'

# Ansible aliases
alias aved='ansible-vault edit'
alias avdec='ansible-vault decrypt'
alias avenc='ansible-vault encrypt'
alias apl='ansible-playbook'

# Fzf aliases
fkill() {
  local pid
  pid=$(ps -ef | sed 1d | /usr/bin/fzf -m | awk '{print $2}')

  if [ "x$pid" != "x" ]
  then
    echo $pid | xargs kill -${1:-9}
  fi
}
alias fzf='fzf --height 70% --border --preview "head -100 {}"'
alias vif='vim $(fzf)'
alias open='xdg-open "$(fzf)" 2>/dev/null'

PLATFORM=`uname`
if [ "${PLATFORM}" != "Darwin" ]; then
  alias ls='ls --color=auto --human-readable --group-directories-first --classify'
  alias ip='ip -4 -o'
else
  alias ls='ls -G'
fi
alias feh='feh -x -F -Y'
alias less='less -S'
# you know, that's funny ;)
alias fuck='sudo $(fc -ln -1)'
alias wttr='curl http://wttr.in/'

# Export more specific variables for less
# export LESS='-srSCmqPm--Less--(?eEND:%pb\%.)'

# VirtualenvWrapper
export WORKON_HOME=~/.virtualenvs
if [ -f /usr/bin/virtualenvwrapper.sh ]; then
  source /usr/bin/virtualenvwrapper.sh
else
  echo "virtualenvwrapper script for Python not found, skip load it"
fi
#unset GREP_OPTIONS

# set 256 colors for terminal
export TERM=screen-256color

# SSH-related funcs
check-ssh-agent() {
  if [ ! -S ~/.ssh/ssh_auth_sock ]; then
    echo "ssh-agent not running, run it"
    eval `ssh-agent`
    ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock
    echo "ran ssh-agent"
  fi
}

check-ssh-add() {
  export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock
  if ! ssh-add -l >/dev/null; then
    ssh-add -t 8h
    echo "Keys were added to an agent"
  fi
}

ssh() {
  check-ssh-agent
  check-ssh-add
  /usr/bin/ssh $@
}

# M-b and M-f (backward-word and forward-word) would jump over each word separated by a '/'
export WORDCHARS='*?_[]~=&;!#$%^(){}'

# use 'up' script instead of typing cd ../../../.. endlessly
UPTOOL="${HOME}/.config/up/up.sh"
if [ ! -f "${UPTOOL}" ]; then
  echo "'up' script does not exist, download it"
  curl --create-dirs -o "${UPTOOL}" https://raw.githubusercontent.com/sorrowless/up/master/up.sh 2>/dev/null
  chmod u+x "${UPTOOL}"
  source "${UPTOOL}"
else
  source "${UPTOOL}"
fi

# I always use tmux, so put it here
TPM="${HOME}/.tmux/plugins/tpm"
if [ ! -d "${TPM}" ]; then
  echo "Tmux plugin manager does not loaded, download it"
  git clone https://github.com/tmux-plugins/tpm "${TPM}"
fi

# To avoid getting this rc file bigger, just get settings from other files
for FILE in ~/.rc/* ; do
  source $FILE
done
