# installing and running neovim (v0.12.0) from absolute scratch (--verbose version)

1. install neovim (v0.12.0):
    ```bash
    mkdir -p ~/apps/neovim && cd ~/apps/neovim
    wget -O nvim.appimage https://github.com/neovim/neovim/releases/download/v0.12.0/nvim-linux-x86_64.appimage
    chmod u+x nvim.appimage
    ```
2. install a virtual environment (if it already exists, delete it and start fresh):
    ```bash
    mkdir ~/.virtualenvs && cd ~/.virtualenvs
    python3 -m venv nvim
    ```
3. install the necessary python packages in the virtual environment for nvim and python lsp purposes:
    ```bash
    cd ~/.virtualenvs/nvim
    source bin/activate
    ./pip install pynvim  # https://github.com/neovim/pynvim
    ./pip install zuban   # https://github.com/zubanls/zuban (or to upgrade: `pip install zuban --upgrade`)
    ./pip install ruff
    ./pip install darker  # https://github.com/akaihola/darker
    ./pip install darker[isort]  # https://github.com/PyCQA/isort
    deactivate
    ```
4. for an init configuration template to get you started:
    ```bash
    mkdir ~/dotfiles/ && cd ~/dotfiles
    git clone https://github.com/benewberg/nvim_config.git nvim
    ```
5. add symlinks from the dotfiles dir to the neovim config dir:
    ```bash
    mkdir -p $HOME/.config/nvim
    ln -sf $HOME/dotfiles/nvim/init.lua $HOME/.config/nvim/init.lua
    ln -sf $HOME/dotfiles/nvim/lua $HOME/.config/nvim/lua
    ln -sf $HOME/dotfiles/nvim/ftplugin $HOME/.config/nvim/ftplugin
    ```
6. make a new script which will launch this version of neovim:
    ```bash
    mkdir -p $HOME/.local/bin
    vi $HOME/.local/bin/nvim
    ```
    - add the below into the file (ignore the back-ticks) and save
    ```bash
    #!/bin/bash

    if [ ! "$#" -gt 0 ] ; then
        ~/apps/neovim/nvim.appimage
    else
        ~/apps/neovim/nvim.appimage "$@"
    fi
    ```
    - then, `chmod u+x $HOME/.local/bin/nvim`
    - finally, make sure `$HOME~/.local/bin` is in your path (it should be)
7. install the tree-sitter-cli (now required by nvim-treesitter): `sudo apt install tree-sitter-cli`
    -or-  # if the package manager doesn't have v0.26.1 as required:
    ```bash
    wget -O $HOME/.local/bin/tree-sitter-cli-linux-x64.zip https://github.com/tree-sitter/tree-sitter/releases/download/v0.26.7/tree-sitter-cli-linux-x64.zip
    unzip $HOME/.local/bin/tree-sitter-cli-linux-x64.zip -d $HOME/.local/bin/.
    rm $HOME/.local/bin/tree-sitter-cli-linux-x64.zip
    ```
8. launch neovim now
    - vim.pack will download and install the plugins. wait for it to complete
    - if treesitter doesn't automatically install the parsers: `:TSInstall <language[,s]>`

## troubleshooting:
- if you can't run the nvim.appimage binary, install fuse:
    ```bash
    sudo apt-get install fuse
    sudo apt-get install fuse-libs
    ```

- if fzf is not installed:
    ```bash
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install
    ```
    - enter `y` or enter at the 3 prompts to enable fuzzy auto-complete, key bindings, and update shell config
    - source your .bashrc: `. ~/.bashrc`

- if ripgrep is not installed: `sudo apt-get install ripgrep`

- in neovim, run `:checkhealth` to check for any other issues

- if treesitter is reporting issues in `:checkhealth`:  
    a. completely remove the nvim-treesitter plugin: `rm -rf $HOME/.local/share/nvim/site/pack/core/opt/nvim-treesitter`  
    b. delete all of the directories (if they exist) at this path: `rm -rf $HOME/.local/share/nvim/site/parser $HOME/.local/share/nvim/site/parser-info $HOME/.local/share/nvim/site/queries`  
    c. launch nvim, wait for vim.pack to re-install nvim-treesitter, and run `:TSInstall <language[,s]>`  

## optional:
- add nvim as the default editor in git: `git config --global core.editor nvim`

- add nvim as the default editor in psql:
    a. add this line to your .bashrc: `export PSQL_EDITOR=nvim`
    b. source your .bashrc: `. ~/.bashrc`

- add the nerdfont-patched intel one mono font: `https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/IntelOneMono`

### optional rust tools:
- install cargo: `sudo apt-get install cargo`

- eza (modern, maintained replacement for `ls` -- https://github.com/eza-community/eza):
    - `cargo install eza`
    - add the following lines to your .bashrc and source it:
    ```bash
        alias ll='eza --long --icons'
        alias lll='eza --long --tree --icons'
    ```

- fd (simple, fast and user-friendly alternative to `find` -- https://github.com/sharkdp/fd): `cargo install fd-find`

## misc how-to:
- install ctags and generate a tabs file:
    a. `sudo apt-get install ctags`  
    b. ensure Exuberant Ctags is what we just installed: `ctags --version`  
    c. generate the tags file: `ctags -R --languages=python -f ~/.config/nvim/tags /HIGHEST_GIT_LEVEL_PATH/.`  
    d. in nvim, add this to your init somewhere: `vim.opt.tags = vim.env.HOME .. '/.config/nvim/tags'`  
    e. if you have fzf-lua plugin installed, then from neovim: `:FzfLua tags` or `:FzfLua tags_live_grep`  

- how i migrated from lazy to vim.pack after nvim v0.12.0 was released
    a. `rm -rf $HOME/.local/share/nvim/lazy`  # remove all lazy plugins manually  
    b. `rm -rf $HOME/.local/share/nvim/site/parser $HOME/.local/share/nvim/site/parser-info $HOME/.local/share/nvim/site/queries`  # remove any treesitter assets  
    c. made all relevant updates to init.lua; removing lazy setup commands and moved everything into vim.pack.add()  
    d. launch nvim and allow vim.pack to install everything; external (non-github) plugins will fail  
    e. one plugin (leap.nvim) was hosted by codeberg, not github, so i had to do the following:  
    ```bash
    mkdir -p $HOME/.local/share/nvim/site/pack/ext/opt
    git clone https://codeberg.org/<maintainer/<plugin> $HOME/.local/share/nvim/site/pack/ext/opt/<plugin>
    ```
    f. re-launch nvim and install the treesitter parsers using `:TSInstall <language[,s]>`  
