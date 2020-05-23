
# gitリポジトリ内か調べる
is_in_git() {
    git rev-parse --is-inside-work-tree &> /dev/null
    return $status
}

# findした結果をpecoで選択してviで開く
function vif() {
    local file="" # フィルタ後のファイルパスが入る
    local force_find=0 # git ls-files:0, find:1

    # オプションがなければ、異常終了
    if [[ $# -eq 0 ]]; then
        echo "Error: no param"
        return 1
    fi

    if [[ $1 = "-f" ]]; then
        # -fが指定された
        shift
        local force_find=1
    elif ! is_in_git; then
        # git外なのでgit ls-filesは使えない
        local force_find=1
    fi

    if [[ $force_find -eq 1 ]]; then
        # find
        #   --select-1 : 候補が1つしかなければ、そのまま決定
        #                しかし、queryにより候補が1つになった場合は機能しない
        file="$(find . -type f 2> /dev/null | peco --select-1 --query $1)"
    else
        # git ls-files
        file="$(git ls-files 2> /dev/null | peco --select-1 --query $1)"
    fi

    if [[ -n "$file" ]]; then
        # $fileが空白でないならviで開く
        # pecoの画面でESCなどを使って何も選択しないときを考慮

        # あとで履歴から引けるように、~/.zsh_historyに追加する
        print -S "vim $file"
        # silentで"Press ENTER or type command to continue"の表示防止
        echo "vim -c silent $file"
        vim -c silent $file
    fi
}

function viggf() {
    local vim_args=""

    if (type "ag" > /dev/null 2>&1;) then
        vim $( \
            ag $@ | \
            peco --prompt "[ag]" --query "$@" | \
            awk -F : '{print "-c " $2 " " $1}' \
            )
    else
        vim $( \
            grep -rn $@ * .* | \
            peco --prompt "[grep]" --query "$@" |\
            awk -F : '{print "-c " $2 " " $1}' \
            )
    fi
}

function vigg() {
    local vim_args=""

    if (is_in_git;) then
        vim $( \
            git grep -n $@ | \
            peco --prompt "[git-grep]" --query "$@" | \
            awk -F : '{print "-c " $2 " " $1}' \
            )
    else
        viggf
    fi
}

# grepした結果をpecoで選択してviで開く
function vig() {
    local result=""    # git grep/grep後の結果
    local file=""      # pecoフィルタ後のファイルパス
    local line=""      # 行番号

    # オプションがなければ、異常終了
    if [[ $# -eq 0 ]]; then
        echo "Error: no param"
        return 1
    fi

    if (type "ag" > /dev/null 2>&1;) then
        # agがあればagを使う
        grep_cmd="ag"
    else
        # grep
        #   -n: 行番号表示
        #   -I: バイナリ除外
        #   -i: 大文字小文字無視
        #   -a: テキストとみなす Binary file (standard input) matches回避
        grep_cmd="grep -rnIia"
    fi

    if [[ $1 = "-f" ]]; then
        # -fが指定されたらgit内でもgit grepは使わない
        shift
    elif is_in_git; then
        # git内ならgit grepを使う
        grep_cmd="git grep -nIia"
    fi

    # --select-1 : 候補が1つしかなければ、そのまま決定
    result="$(eval $grep_cmd $1 ./.* 2> /dev/null | peco --select-1 --query $1)"

    # head -1を入れたのはgrepの結果に\nが入っていると、
    # pecoが改行してしまい、意図せず複数行になるためその回避
    file="$(echo $result | head -1 | cut -d: -f1)"
    line="$(echo $result | head -1 | cut -d: -f2)"

    if [[ -n "$file" ]]; then
        # $fileが空白でないならviで開く
        # pecoの画面でESCなどを使って何も選択しないときを考慮

        # あとで履歴から引けるように、~/.zsh_historyに追加する
        print -S "vim -c /\"$1\" -c $line $file"
        # silentで"Press ENTER or type command to continue"の表示抑止
        # 抑止できていない？
        echo "vim -c silent -c /\"$1\" -c $file"
        vim -c silent -c /"$1" -c $line $file
    fi
}

# terminalからググる
google() {
    local str opt
    if [ $# != 0 ]; then
        for i in $*; do
            # $strが空じゃない場合、検索ワードを+記号でつなぐ(and検索)
            str="$str${str:++}$i"
        done
        opt='search?num=100'
        opt="${opt}&q=${str}"
    fi
    chromium-browser http://www.google.co.jp/$opt > /dev/null
    #google-chrome http://www.google.co.jp/$opt > /dev/null
}
