if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi
export PATH="$HOME/bin:$PATH"

. "$HOME/.cargo/env"
