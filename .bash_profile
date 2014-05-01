export SVN_EDITOR=vim
export EDITOR=vim

export MAMPVHOST=/Applications/MAMP/conf/apache/extra
export JSTESTDRIVER_HOME=~/bin

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
source /usr/local/git/contrib/completion/git-completion.bash

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
