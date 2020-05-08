
# PATH
export PATH="$PATH:~/bin/"
typeset -gx -U path
path=( \
    ~/specific/bin(N-/) \
    ~/bin(N-/) \
    "$path[@]" \
    )


# LANGUAGE must be set by en_US
export LANGUAGE="en_US.UTF-8"
export LANG="${LANGUAGE}"
export LC_ALL="${LANGUAGE}"
export LC_CTYPE="${LANGUAGE}"

# 補完機能
autoload -U compinit && compinit -u
# 補完候補を一覧表示にする
setopt auto_list
# TAB で順に補完候補を切り替える
setopt auto_menu
# 補完候補を一覧表示したとき、Tabや矢印で選択できるようにする
zstyle ':completion:*:default' menu select=1
# 補完候補の色づけ
LS_COLORS='no=00;37:fi=00:di=00;33:ln=04;36:pi=40;33:so=01;35:bd=40;33;01:'
export LS_COLORS
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# gtagsでパース時、pygmentsを使うようにする
export GTAGSLABEL=pygments
