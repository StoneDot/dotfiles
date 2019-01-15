function ghq-cd() {
  local selected_dir=$(ghq list -p | fzf)
  if [ -n "$selected_dir" ]; then
    BUFFER="cd ${selected_dir}"
    zle accept-line
  fi
}

zle -N ghq-cd
bindkey '^]' ghq-cd
