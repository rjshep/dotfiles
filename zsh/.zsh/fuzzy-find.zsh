fuzzy-find() {
  vim $(fzf -e --preview="bat --color=always {}")
}
zle -N fuzzy-find
bindkey -M vicmd '^T' fuzzy-find
bindkey -M viins '^T' fuzzy-find
