
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

# grepした結果をpecoで選択してviで開く
function vig() {
    local strings=""   # vifに渡される文字列
    local result=""    # git grep/grep後の結果
    local file=""      # pecoフィルタ後のファイルパス
    local line=""      # 行番号
    local force_grep=0 # git grep:0, grep:1

    # オプションがなければ、異常終了
    if [[ $# -eq 0 ]]; then
        echo "Error: no param"
        return 1
    fi

    if [[ $1 = "-f" ]]; then
        # -fが指定された
        shift
        local force_grep=1
    elif ! is_in_git; then
        # git外なのでgit grepは使えない
        local force_grep=1
    fi
    strings="$*"

    if [[ $force_grep -eq 1 ]]; then
        # grep
        #   -n: 行番号表示
        #   -I: バイナリ除外
        #   -i: 大文字小文字無視
        #   -a: テキストとみなす Binary file (standard input) matches回避
        # peco
        #   --select-1 : 候補が1つしかなければ、そのまま決定
        result="$(grep -rnIia "$strings" ./.* 2> /dev/null | peco --select-1 --query $1)"
    else
        # git grep
        result="$(git grep -i -n "$strings" 2> /dev/null | peco --select-1 --query $1)"
    fi

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
