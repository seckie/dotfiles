# dotfiles for My Mac OS and Linux

## Install

```bash
$ git clone git@github.com:seckie/dotfiles.git ~/dotfiles
$ ln -s ~/dotfiles/.vim ~/.vim
$ ln -s ~/dotfiles/.vimrc ~/.vimrc
$ ln -s ~/dotfiles/.gvimrc ~/.gvimrc
$ ln -s ~/dotfiles/.gitignore ~/.gitignore
$ ln -s ~/dotfiles/.bash_profile ~/.bash_profile
```

## Setup VIM plugins

Using [dein.vim](https://github.com/Shougo/dein.vim) to manage VIM plugins.

```bash
$ curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
$ sh ./installer.sh ~/dotfiles/.vim/dein
```

```vim
:call dein#install()
```
