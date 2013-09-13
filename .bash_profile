export SVN_EDITOR=vim

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

##
# Your previous /Users/naokis/.bash_profile file was backed up as /Users/naokis/.bash_profile.macports-saved_2013-05-19_at_11:08:33
##

# MacPorts Installer addition on 2013-05-19_at_11:08:33: adding an appropriate PATH variable for use with MacPorts.
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
# Finished adapting your PATH environment variable for use with MacPorts.

# Additional PATH
export PATH=/Users/naokis/android-sdk-macosx/tools:/Users/naokis/android-sdk-macosx/platform-tools:/Applications/MAMP/bin/php/php5.4.10/bin:$PATH

# git subcommand completion
source /usr/local/git/contrib/completion/git-completion.bash

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
