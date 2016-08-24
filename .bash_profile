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

# for Nodebrew
export PATH=$HOME/.nodebrew/current/bin:$PATH

# git subcommand completion
source /usr/local/git/contrib/completion/git-completion.bash

# for Karma test
ulimit -n 2048

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# for Node
export NODE_PATH=$NODE_PATH:/usr/local/lib/node_modules
