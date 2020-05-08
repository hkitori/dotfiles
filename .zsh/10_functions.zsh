
# gitリポジトリ内か調べる
is_in_git()
{
    git rev-parse --is-inside-work-tree &> /dev/null
    return $status
}


# findした結果をpecoで選択してviで開く
function vif()
{
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
    echo $file

    # head -1を入れたのはgrepの結果に\nが入っていると、
    # pecoが改行してしまい、意図せず複数行になるためその防止
    if [[ -n "$file" ]]; then
        # $fileが空白でないならviで開く
        # pecoの画面でESCなどを使って何も選択しないときを考慮

        # silentで"Press ENTER or type command to continue"の表示防止
        echo "vim -c silent $file"
        # あとで履歴から引けるように、~/.zsh_historyに追加する
        print -S "vim $file"
        "vim -c silent $file"
    fi
}

