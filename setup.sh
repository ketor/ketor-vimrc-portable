#!/bin/bash
# |------------------------|
# |      ketor VIMRC       |
# |------------------------|
# |           _            |
# |   __   __(_)___ ___    |
# |   | | / / / __ `__ \   |
# |   | |/ / / / / / / /   |
# |   |___/_/_/ /_/ /_/    |
# |                        |
# |------------------------|
#
# | ---------------------- | ---------------------- |
# | vimrc安装脚本          |                        |
# | ---------------------- | ---------------------- |
# | 说明                   |                        |
# | ---------------------- | ---------------------- |
# | vim_path               | vimrc安装目录的父目录  |
# | vim_dir                | vimrc安装目录名        |
# | ---------------------- | ---------------------- |
vim_path=.vim
vim_dir=$HOME

#setup.sh start here, do not modify
vim_fullpath=$vim_dir/$vim_path        # vimrc安装到的目录
vim_init_file=$vim_fullpath/vimrc.init # vimrc标志文件，记录安装的日期
vim_pwd=$PWD

color_print() {
    printf '\033[0;31m%s\033[0m\n' "$1"
}

warn() {
    color_print "$1" >&2
}

die() {
    warn "$1"
    exit 1
}

logo() {
    color_print "Thank you for installing ketor-vimrc-portable!"
    color_print '            _         '
    color_print '    __   __(_)___ ___ '
    color_print '    | | / / / __ `__ \'
    color_print '    | |/ / / / / / / /'
    color_print '    |___/_/_/ /_/ /_/ '
    color_print '                      '
}

require() {
    color_print "Checking requirements for vimrc..."
    color_print "Checking vim version..."
    vim_exec="vim"
    if [ `uname` == "Darwin" ]; then
        echo "OS_TYPE is Darwin"
        if [ `command -v mvim` ]; then
            vim_exec="mvim"
            echo "MacVim installed, use mvim for requirements"
        else
            vim_exec="vim"
            echo "Use vim for requirements"
        fi
    fi
    vim_version=$($vim_exec --version | head -n 1 | grep -oE '[0-9]+\.[0-9]+' | head -1)
    vim_major=$(echo "$vim_version" | cut -d. -f1)
    vim_minor=$(echo "$vim_version" | cut -d. -f2)
    if [ -z "$vim_major" ] || [ "$vim_major" -lt 8 ] || { [ "$vim_major" -eq 8 ] && [ "$vim_minor" -lt 1 ]; }; then
        die "Your vim's version($vim_version) is too low! Vim 8.1+ is required. Please download from http://www.vim.org/download.php"
    fi
    $vim_exec --version | grep -q '+python3' || die "Your vim does not have +python3 support"
    color_print "Checking if git exists..."
    which git || die "No git installed!\nPlease install git from http://git-scm.com/downloads/"
}

help() {
    echo "setup.sh -- setup vimrc"
    echo "Usage: setup.sh -i/-u/-b/-l"
    echo "-i -- install vimrc"
    echo "-u -- update vimrc's plugins"
    echo "-b -- backup ~/.vim"
    echo "-r -- update submodules from github"
    echo "-l -- link ~/.vim/vimrc to ~/.vimrc and make vim-proc, for green install from tar.gz"
    exit 0
}

make_vimrc() {
    if [ -L $HOME/.vimrc ]; then
        unlink $HOME/.vimrc
    fi
    if [ -f $HOME/.vimrc ]; then
        /bin/rm -f $HOME/.vimrc
    fi
    echo "source $vim_fullpath/vimrc" > $HOME/.vimrc
    echo "colorscheme jellybeans" >> $HOME/.vimrc
    color_print "Make vimrc finished"
}

backup_vimrc() {
    cd $vim_dir
    backup_date=`date +%Y%m%d`
    color_print $backup_date
    tar --exclude .git --exclude YouCompleteMe -czvf vimrc-$backup_date-portable.tar.gz $vim_path/bundle $vim_path/fonts $vim_path/vimrc* $vim_path/setup.sh $vim_path/.tmux.conf
    cd $vim_pwd
    color_print "Backup Finished "$backup_date
}

append_if_missing() {
    local line="$1"
    local file="$2"
    # Create file if it doesn't exist
    if [ ! -f "$file" ]; then
        touch "$file"
    fi
    # Use -x for exact line match to prevent partial matches
    if grep -qxF "$line" "$file" 2>/dev/null; then
        color_print "'$line' already exists in $file, skip"
    else
        echo "$line" >> "$file"
        color_print "Added '$line' to $file"
    fi
}

check_term() {
    if [ x$TERM != x"xterm-256color" ]
    then
        color_print "TERM is not xterm-256color, will set TERM=xterm-256color now"

        is_zsh=`echo $SHELL|grep 'zsh'|wc -l`
        is_bash=`echo $SHELL|grep 'bash'|wc -l`

        if [ $is_zsh -eq 1 ]
        then
            color_print "Your shell is zsh, set TERM in ~/.zshrc"
            append_if_missing "export TERM=xterm-256color" ~/.zshrc
            color_print "Set TERM OK, please execute:"
            color_print "    source ~/.zshrc"
        elif [ $is_bash -eq 1 ]
        then
            color_print "Your shell is bash, set TERM in ~/.bash_profile"
            append_if_missing "export TERM=xterm-256color" ~/.bash_profile
            color_print "Set TERM OK, please execute:"
            color_print "    source ~/.bash_profile"
        else
            color_print "Your shell cannot set TERM automatically, please set TERM to xterm-256color by yourself"
        fi
    else
        color_print "TERM is xterm-256color, OK"
    fi
}

check_lang() {
    is_zsh=`echo $SHELL|grep 'zsh'|wc -l`
    is_bash=`echo $SHELL|grep 'bash'|wc -l`

    if [ $is_zsh -eq 1 ]; then
        rc_file=~/.zshrc
    elif [ $is_bash -eq 1 ]; then
        rc_file=~/.bash_profile
    else
        rc_file=""
    fi

    if [ x$LANG != x"en_US.UTF-8" ]
    then
        color_print "LANG is not en_US.UTF-8, will set LANG=en_US.UTF-8"
        if [ -n "$rc_file" ]; then
            append_if_missing "export LANG=en_US.UTF-8" "$rc_file"
        else
            color_print "Your shell cannot set LANG automatically, please set LANG to en_US.UTF-8 by yourself"
        fi
    else
        color_print "LANG is en_US.UTF-8, OK"
    fi

    if [ x$LC_ALL != x"en_US.UTF-8" ]
    then
        color_print "LC_ALL is not en_US.UTF-8, will set LC_ALL=en_US.UTF-8"
        if [ -n "$rc_file" ]; then
            append_if_missing "export LC_ALL=en_US.UTF-8" "$rc_file"
        else
            color_print "Your shell cannot set LC_ALL automatically, please set LC_ALL to en_US.UTF-8 by yourself"
        fi
    else
        color_print "LC_ALL is en_US.UTF-8, OK"
    fi

    if [ -n "$rc_file" ]; then
        color_print "Please execute: source $rc_file"
    fi
}

install() {
    color_print "Start install"

    git clone https://github.com/ketor/ketor-vimrc-portable $vim_fullpath;
    if [ $? -eq 0 ]; then
        cd $vim_fullpath
        git submodule update --init --recursive
        cd $vim_pwd
        color_print "All plugins init finished!"
    else
        echo $?
        color_print "Install failed! "
        exit -1
    fi
}

update() {
    cd $vim_fullpath
    git pull
    git submodule update --init --recursive
    color_print "Update finished!"
    cd $vim_pwd
}

update_remote() {
    UPDATE_DATE=`date +%Y%m%d`
    cd $vim_fullpath
    git pull
    git submodule update --init --recursive
    git submodule update --remote
    git commit -s -a -m "submodule: Update submodule $UPDATE_DATE."
    git push
    color_print "Update Remote finished!"
    cd $vim_pwd
}

if [ $# -ne 1 ]; then
    logo
    require
    check_term
    check_lang
    install
    make_vimrc
    help
fi

while getopts ":iurbln" opts; do
    case $opts in
        i)
            logo
            require
            check_term
            check_lang
            install
            make_vimrc
            ;;
        u)
            logo
            require
            update
            ;;
        r)
            logo
            require
            update_remote
            ;;
        b)
            logo
            backup_vimrc
            ;;
        l)
            logo
            require
            check_term
            check_lang
            make_vimrc
            ;;
        n)
            logo
            make_vimrc
            ;;
        :)
            help;;
        ?)
            help;;
    esac
done
