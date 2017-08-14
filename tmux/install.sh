#!/usr/bin/env bash
set -o errexit -o nounset -o xtrace
script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

cp -n "$script_dir/tmux.conf.shared" "$HOME/.tmux.conf"

platform="$(uname)"
if [[ "$platform" == *Darwin* ]]; then
    cat "$script_dir/tmux.conf.osx" >> "$HOME/.tmux.conf"
else
    cat "$script_dir/tmux.conf.linux" >> "$HOME/.tmux.conf"
fi
