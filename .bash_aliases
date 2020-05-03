# alias
alias diff="colordiff"
alias rm="rm -i"
alias mv="mv -i"
alias cp="cp -i"
alias grep="grep --color"
alias ls="ls -G"
# alias for vi
alias vv="echo vi ~/.vimrc; vi ~/.vimrc"
alias vb="echo vi ~/.bashrc; vi ~/.bashrc"
alias vbe="echo vi ~/.bashenv; vi ~/.bashenv"
alias vt="echo vi ~/.tmux.conf; vi ~/.tmux.conf"
alias vg="echo vi ~/.gitconfig; vi ~/.gitconfig"
alias vd="echo vi ~/.vim/dein.toml; vi ~/.vim/dein.toml"
alias vdl="echo vi ~/.vim/dein_lazy.toml; vi ~/.vim/dein_lazy.toml"
# alias for source command
alias rb="echo . ~/.bashrc; . ~/.bashrc"
alias rt="echo tmux source-file ~/.tmux.conf; tmux source-file ~/.tmux.conf"
# alias for git
alias st="echo git status; git status"
alias gr="echo git graph; git graph"
alias cm="echo git commit -m ...; git commit -m $*"
alias pull="echo git pull; git pull"
alias push="echo git push; git push"

# PATH
export PATH="$PATH:~/bin/"

# LANGUAGE must be set by en_US
export LANGUAGE="en_US.UTF-8"
export LANG="${LANGUAGE}"
export LC_ALL="${LANGUAGE}"
export LC_CTYPE="${LANGUAGE}"

