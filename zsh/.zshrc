# Set up the path
export PATH=/opt/homebrew/bin/:/Users/rshe/.pyenv/shims/:/usr/bin:/bin:/usr/sbin:/sbin:

# Determine if we're in dark mode
if [[ "$(uname -s)" == "Darwin" ]]; then
  if [[ $(defaults read -g AppleInterfaceStyle 2>/dev/null) == "Dark" ]]; then
    DARK_MODE=true
  else
    DARK_MODE=false
  fi
else
  # TODO: Handle linux
fi

if [[ ${DARK_MODE} == "true" ]]; then
  ZSH_SYNTAX_SCRIPT=~/.zsh/catppuccin_macchiato-zsh-syntax-highlighting.zsh
  export LS_COLORS="$(vivid generate catppuccin-macchiato)"
else
  ZSH_SYNTAX_SCRIPT=~/.zsh/catppuccin_latte-zsh-syntax-highlighting.zsh
  export LS_COLORS="$(vivid generate catppuccin-latte)"
fi

# Set brew variables appropriately
eval "$(brew shellenv)"

# Enable autocomplete
autoload -Uz compinit
compinit

# Initialise Starship Prompt
eval "$(starship init zsh)"

# Configure atuin to initialise after zsh is running
zvm_after_init_commands+=(eval "$(atuin init zsh --disable-up-arrow)")

# Configure zsh plugins
source $(brew --prefix)/opt/zsh-vi-mode/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
source ${ZSH_SYNTAX_SCRIPT}
source ~/.zsh/git.plugin.zsh
source ~/.zsh/kubectl.plugin.zsh
source <(kubectl completion zsh)
#source <(fzf --zsh)
source ~/.zsh/fuzzy-find.zsh

# Enable  menus in autocomplete
zstyle ':completion:*' menu select

# This must be the last entry
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

alias ll='lsd -l'
alias ls=lsd
alias vi=nvim

if [[ -f ~/.zshrc.local ]]; then
  source ~/.zshrc.local
fi

export EDITOR=nvim
