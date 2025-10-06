# Git Completion
source ~/.zsh/git-prompt.sh

fpath=(~/.zsh $fpath)
zstyle ':completion:*:*:git:*' script ~/.zsh/git-completion.bash
autoload -Uz compinit && compinit

# Volta
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

# NPM
# export NPM_TOKEN=ghp_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx


# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/naoki.sekiguchi/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/naoki.sekiguchi/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/naoki.sekiguchi/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/naoki.sekiguchi/google-cloud-sdk/completion.zsh.inc'; fi

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /opt/homebrew/bin/terraform terraform

# Read private settings
if [[ -f ~/.zshrc.local ]]; then
  source ~/.zshrc.local
fi
