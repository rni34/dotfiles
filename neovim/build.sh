#!/bin/bash

cd ~
git clone https://github.com/neovim/neovim || git -C ~/neovim pull
cd neovim
sudo make distclean
sudo make CMAKE_BUILD_TYPE=Release install
sudo mv ~/neovim/build/bin/nvim /usr/local/bin/nvim
sudo rm -rf ~/neovim/build/
cd ~
