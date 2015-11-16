#!/usr/bin/env bash
set -o errexit
set -o nounset
set -o xtrace

./install-home-dir.sh
./install-i3.sh
./install-tmux.sh
./install-zshrc.sh
./install-vim.sh
