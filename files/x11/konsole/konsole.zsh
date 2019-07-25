# Konsole color changing
# Source: https://askubuntu.com/questions/416572/switch-profile-in-konsole-from-command-line

konsole-theme-night() {
  switch-term-color "colors=PaperColorDark"
}

konsole-theme-light() {
  switch-term-color "colors=PaperColorLight"
}

switch-term-color() {
  arg="${1:-colors=PaperColorLight}"
  if [[ -z "$TMUX" ]]
  then
    konsoleprofile "$arg"
  else
    printf '\033Ptmux;\033\033]50;%s\007\033\\' "$arg"
  fi
}
