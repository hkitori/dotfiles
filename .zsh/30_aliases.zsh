
# alias
alias rm="rm -i"
alias mv="mv -i"
alias cp="cp -i"
alias grep="grep --color"
# alias for vi
alias vv="echo vi ~/.vimrc; vi ~/.vimrc"
alias vz="echo vi ~/.zshrc; vi ~/.zshrc"
alias vzf="echo vi ~/.zsh/10_functions.zsh; vi ~/.zsh/10_functions.zsh"
alias vzk="echo vi ~/.zsh/20_keybinds.zsh; vi ~/.zsh/20_keybinds.zsh"
alias vza="echo vi ~/.zsh/30_aliases.zsh; vi ~/.zsh/30_aliases.zsh"
alias vt="echo vi ~/.tmux.conf; vi ~/.tmux.conf"
alias vg="echo vi ~/.gitconfig; vi ~/.gitconfig"
alias vd="echo vi ~/.vim/dein.toml; vi ~/.vim/dein.toml"
alias vdl="echo vi ~/.vim/dein_lazy.toml; vi ~/.vim/dein_lazy.toml"
alias vn="echo vi ~/.netrc; vi ~/.netrc"
# alias for source command
alias rz="echo source ~/.zshrc; source ~/.zshrc"
alias rt="echo tmux source-file ~/.tmux.conf; tmux source-file ~/.tmux.conf"
# alias for git
alias st="echo git status; git status"
alias add="echo git add ...; git add"
alias gr="echo git graph; git graph"
alias cm="echo git commit -m ...; git commit -m"
alias cma="echo git commit --amend -m ...; git commit --amend -m"
alias pull="echo git pull; git pull"
alias gpr="echo git pull --rebase; git pull --rebase"
alias push="echo git push; git push"
alias gd="echo git diff; git diff"
alias gdc="echo git diff --cached; git diff --cached"
alias gdw="echo git diff --word-diff; git diff --word-diff" # diff per word
alias git-undo="git reset --soft HEAD^" # 直前のコミットをやめる

alias war="~/bin/watch-and-run"

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    if command -v xsel >/dev/null 2>&1; then
        alias pbcopy='xsel --clipboard --input'   # copy to clipboard
        alias pbpaste='xsel --clipboard --output' # paste to clipboard
    fi
    if command -v wl-copy >/dev/null 2>&1; then
        alias pbcopy='wl-copy'
    fi
    if command -v wl-paste >/dev/null 2>&1; then
        alias pbpaste='wl-paste'
    fi
fi
alias g='google' # google defined at .zsh/10_functions.zsh

# OS specific
case ${OSTYPE} in
    darwin*)
        #[[ -f ~/.zshrc.darwin ]] && source ~/.zshrc.darwin
        alias ls="ls -G"
        alias diff="colordiff"
        ;;
    linux*)
        #[[ -f ~/.zshrc.linux ]] && source ~/.zshrc.linux
        alias ls="ls --color"
        alias diff="diff --color"
        ;;
esac
