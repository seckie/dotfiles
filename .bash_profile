export SVN_EDITOR=vim
export EDITOR=vim

export CLICOLOR=1
export LSCOLORS=DxGxcxdxCxegedabagacad
export PS1="\[\e[1;34m\]\h:\w \u\$\[\e[00m\] "

# keychain
if [ -x /usr/bin/keychain ]; then
    keychain ~/.ssh/id_rsa
    . .keychain/${HOSTNAME}-sh
fi

# for HomeBrew
export PATH="/usr/local/bin:/usr/local/sbin:$PATH"

# Additional PATH
export PATH=/Users/naokis/android-sdk-macosx/tools:/Users/naokis/android-sdk-macosx/platform-tools:$PATH

# git subcommand completion
if [ -f '/Applications/Xcode.app/Contents/Developer/usr/share/git-core/git-completion.bash' ]; then . /Applications/Xcode.app/Contents/Developer/usr/share/git-core/git-completion.bash; fi
if [ -f '/Applications/Xcode.app/Contents/Developer/usr/share/git-core/git-prompt.sh' ]; then . /Applications/Xcode.app/Contents/Developer/usr/share/git-core/git-prompt.sh; fi

# for Karma test
ulimit -n 2048

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# for Node
export NODE_PATH=$NODE_PATH:/usr/local/lib/node_modules:/Users/naokis/.nodebrew/current/lib/node_modules

# for composer
export PATH=$HOME/.composer/vendor/bin:$PATH

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/naokis/google-cloud-sdk/path.bash.inc' ]; then source '/Users/naokis/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/naokis/google-cloud-sdk/completion.bash.inc' ]; then source '/Users/naokis/google-cloud-sdk/completion.bash.inc'; fi

# Load nodenv automatically by appending
# the following to ~/.bash_profile:

eval "$(nodenv init -)"

alias python=/usr/local/bin/python3

