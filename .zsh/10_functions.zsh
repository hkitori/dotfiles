
# gitリポジトリ内か調べる
is_in_git() {
    git rev-parse --is-inside-work-tree &> /dev/null
    return $status
}


# findした結果をpecoで選択してviで開く
function vif() {
    local file="" # フィルタ後のファイルパスが入る

    # オプションがなければ、異常終了
    if [[ $# -eq 0 ]]; then
        echo "Error: ${0} needs a parameter at least"
        return 1
    fi

    # git ls-filesが使えるかどうか調べる
    if is_in_git; then
        # git内なので使える
        file="$(git ls-files 2> /dev/null | peco --query $1)"
    else
        # git外なので使えない
        file="$(find . -type f 2> /dev/null | peco --query $1)"
    fi

    # head -1を入れたのはgrepの結果に\nが入っていると、
    # pecoが改行してしまい、意図せず複数行になるためその防止
    if [[ -n "$file" ]]; then
        # $fileが空白でないならviで開く
        # pecoの画面でESCなどを使って何も選択しないときを考慮

        # silentで"Press ENTER or type command to continue"の表示防止
        echo "vim -c silent $file"
        # あとで履歴から引けるように、~/.zsh_historyに追加する
        print -S "vim $file"
        vim -c silent $file
    fi
}

# grepした結果をpecoで選択してviで開く
function vig() {
    local result="" # git grep/grep直後の結果が入る
    local file="" # フィルタ後のファイルパスが入る
    local line="" # ヒットした行番号が入る

    # オプションがなければ、異常終了
    if [[ $# -eq 0 ]]; then
        echo "Error: ${0} needs a parameter at least"
        return 1
    fi

    local strings="$*"
    # 半角全角の判定
    local enc=`echo $strings | nkf -g`
    if [[ $enc == "ASCII" ]]; then
        # 半角: stringsがasciiのみで構成される
        echo "Info: strings is ascii"
    else
        # 全角: stringsがascii以外が含まれる
        echo "Info: strings is not ascii"
    fi

    # git grepが使えるかどうか調べる
    if is_in_git; then
        # git内なので使える
        # -n: 行番号表示
        # -i: 大文字小文字無視
        result+="$(git grep -i -n "$strings" 2> /dev/null | peco --query $1)"
    else
        # git外なので使えない
        # -n: 行番号表示
        # -I: バイナリ除外
        # -i: 大文字小文字無視
        # さらに、grepがテキストファイルをバイナリとみなし、
        # "Binary file ... matches"を吐き出すことがあるので除外
        result+="$(grep -rni -I "$strings" 2> /dev/null | grep -v "Binary file " | peco --query $1)"
    fi

    file="$(echo $result | head -1 | cut -d: -f1)"
    line="$(echo $result | head -1 | cut -d: -f2)"

    # head -1を入れたのはgrepの結果に\nが入っていると、
    # pecoが改行してしまい、意図せず複数行になるためその防止
    if [[ -n "$file" ]]; then
        # $fileが空白でないならviで開く
        # pecoの画面でESCなどを使って何も選択しないときを考慮

        # silentで"Press ENTER or type command to continue"の表示防止
        echo "vim -c silent -c /\"$1\" -c $file"
        # あとで履歴から引けるように、~/.zsh_historyに追加する
        print -S "vim -c $file"
        print -S "vim -c /\"$1\" -c $line $file"
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
