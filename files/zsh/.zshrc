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

# For code of used in prompt functions, look at ~/.rc/zsh-functions file.
# it MUST be in singlequotes. Otherwise, promptsubst will not be working
# $(who_am_i) %{$fg[white]%}in%{$reset_color%} %{$fg_no_bold[cyan]%}%3~%{$reset_color%} $(gitbranch)
PROMPT='
%{$fg_no_bold[cyan]%}%3~%{$reset_color%} $(gitbranch) $(pyvenv)
$(red_green) '

del-prompt-on-enter() {
  PROMPT='
$(red_green) '
  zle reset-prompt
  PROMPT='
%{$fg_no_bold[cyan]%}%3~%{$reset_color%} $(gitbranch) $(pyvenv)
$(red_green) '
  zle accept-line
}

# set right prompt side
function zle-line-init zle-keymap-select {
    VIM_PROMPT="%{$fg_bold[yellow]%} [% NORMAL]% %{$reset_color%}"
    RPS1="${${KEYMAP/vicmd/$VIM_PROMPT}/(main|)/}"
    zle reset-prompt
}

# To avoid getting this rc file bigger, just get settings from other files
for FILE in ~/.rc/* ; do
  source $FILE
done
