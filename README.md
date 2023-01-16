Best vimrc for ketor, used for C/C++, Python, PHP and Go.

The design principle of ketor vimrc is portable, cross-platform. ketor vimrc is designed running well on Linux and Mac, all plugins is written in vimscript except YouCompleteMe which is optional. And also ketor vimrc can be copied and installed anywhere by just a tarball.

Enjoy it.

![alt tag](https://github.com/ketor/ketor-vimrc-portable/blob/master/screenshot-1.png?raw=true)

# Requirements

* Mac use terminal vim:

```
brew install cmake go node mono rust
brew install vim
```

* Mac use MacVim:

```
brew install cmake go node mono rust
```

Download macvim from [https://github.com/macvim-dev/macvim/releases/latest] and install it to /Applications .

Do not install macvim from brew.

* Linux user:

Only vim 7.4.1578+ is required.

# Install

* vimrc will install to ~/.vim, require ~/.vim does not exist.

```
bash -c "$( curl https://raw.githubusercontent.com/ketor/ketor-vimrc-portable/master/setup.sh )"
```

# ShortCuts

| Key            | Function                                            |
| -------------- | --------------------------------------------------- |
| F2             | Paste mode toggle(normal/paste)                     |
| F3             | NerdTREE toggle                                     |
| F4             | Tagbar toggle                                       |
| F5             | LineNumber Model Switch                             |
| F6             | Whether or not show listchar                        |
| F7             | Update ctags                                        |
| F8             | Open undotree                                       |
| F9             | Enter multi-cursor-mode                             |
| F10            | Enter Rankring clipboard                            |
| F12            | Mouse mode switch (mouse=a/-a)                      |
| SpaceSpace     | Activate CtrlP Mixed Search                         |
| Ctrl+h/j/k/l   | Switch between windows.                             |
| Ctrl+c         | Completely quit vim without saving                  |

The leader key is ','.

# Quick Commands

| Cmd     | Function                     |
| ------- | ---------------------------- |
| Ctags   | Genrate ctags for pwd        |
| Gtags   | Genrate gtags for pwd        |
| Gotags  | Genrate gotags for pwd       |
| Cscope  | Genrate cscope files for pwd |
| Phptags | Genrate phptags for pwd      |
| Hex/Asc | Swtich between Asc and Hex   |
| Hexmode | Toggle Hex/Asc mode          |
| Cswp    | Clear swp files              |

# FAQ

- *How should I install vimrc on a Linux server with no internet*

    Vim version 7.4+ is needed on your Linux server, then the steps:

    1) You need install vimrc on a Mac/Linux with internet first.

    2) Then run "~/.vim/setup.sh -b", a "vimrc-2023xxxx-portable.tar.gz" file will appear in your ~ dir.

    3) Copy the "vimrc-2023xxxx-portable.tar.gz" to your user's home dir on Linux server.

    4) Run "cd ~;rm -rf ~/.vim;tar -zxvf vimrc-2023xxxx-portable.tar.gz;.vim/setup.sh -l"

    You now get full-featured vimrc on your Linux server.

- *My state line has strange characters*

    You should install the powerline fonts into your system and update the config of your terminal to use powerline fonts to display the Non-ASCII characters.

    In the fonts dir, there is some powerline fonts you could choose.

    You could found more powerline fonts in [powerline_fonts]

    Remarks: 1. The SourceCodePro-Regular.otf contains all unicode character and new powerline glyphs. If you use a font that not contains powerline glyphs, you could setup your iTerm to use a different font for Non-ASCII text to use SourceCodePro-Regular.
             2. The Menlo-OldPowerline.otf contains old powerline glyphs, installing it will make old powerline display correct on Mac OSX.
             3. The SFMono is licensed to registered third-party developers for the design and development of applications for iOS, macOS and watchOS, please note that it is forbidden to use this typeface for your commercial project.

- *My vim is ugly, it seems some color are missing*

    You should set your env TERM=xterm-256color, you can do this by the following two ways:

    1) run ~/.vim/install.sh, it will set TERM to xterm-256color for bash/zsh. If you use other shells, you need to set TERM yourself.

    2) Your terminal util like iterm is also needed to set for xterm-256color too. You need set it yourself too.

- *Install all YouCompleteMe dependencies*

    If you use Mac OS and brew:

    ```
    brew install cmake go node mono rust
    ```

- *MacVim Caught deadly signal SEGV*

    If you install macvim from brew, when you running mvim, you may seee "Caught deadly signal SEGV".

    The reason is brew macvim use the wrong python.

    To solve this problem, we suggest you download MacVim from [http://macvim-dev.github.io/macvim/]


    But after install from [http://macvim-dev.github.io/macvim/], if you also installed python3 on your Mac OS, this MacVim is going to have some new problem of python3.

    To solve this problem, if you want use MacVim with python2.7, just add this config in your ~/.vimrc file:

    ```
    if has('gui_macvim')
        let $PYTHONHOME="/usr/local/Frameworks/Python.framework/Versions/2.7"
    endif
    ```

    Or if you want use MacVim with python3.6:

    1.Compile YouCompleteMe using python3:

    ```
    cd ~/.vim/bundle/YouCompleteMe
    python3 ./install.py --all
    ```

    2.Add this config in your ~/.vimrc file:

    ```
    if has('gui_macvim')
        let $PYTHONHOME="/usr/local/Frameworks/Python.framework/Versions/3.6"
    endif
    ```

    The PYTHONHOME dir is like:
    ```
    Headers   Python    Resources bin       include   lib       share
    ```

