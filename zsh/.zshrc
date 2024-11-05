# Set up the path

# Set up OS specific things
if [[ "$(uname -s)" == "Darwin" ]]; then
  export PATH=/opt/homebrew/bin/:/Users/rshe/.pyenv/shims/:/usr/bin:/bin:/usr/sbin:/sbin:
  if [[ $(defaults read -g AppleInterfaceStyle 2>/dev/null) == "Dark" ]]; then
    DARK_MODE=true
    HAS_BREW=true
  else
    DARK_MODE=false
    HAS_BREW=false
  fi
else
  # TODO: Handle linux
  export PATH=~/.nix-profile/bin:~/.pyenv/shims/:/usr/bin:/bin:/usr/sbin:/sbin:
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
if [[ ${HAS_BREW} ]]; then
  source $(brew --prefix)/opt/zsh-vi-mode/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
else
  source ~/.local/share/zsh/plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh  
fi
source ${ZSH_SYNTAX_SCRIPT}
source ~/.zsh/git.plugin.zsh
source ~/.zsh/kubectl.plugin.zsh
source <(kubectl completion zsh)
#source <(fzf --zsh)
source ~/.zsh/fuzzy-find.zsh

# Enable  menus in autocomplete
zstyle ':completion:*' menu select

# This must be the last entry
if [[ ${HAS_BREW} ]]; then
  source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
else
  source ~/.local/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

alias ll='lsd -l'
alias ls=lsd
alias vi=nvim

if [[ -f ~/.zshrc.local ]]; then
  source ~/.zshrc.local
fi

export EDITOR=nvim
