
# ctrl-a, ctrl-e
bindkey -e

# peco history selection (ctrl + r)
function _peco-select-history() {
    # historyを番号なし、逆順、最初から表示。
    # 順番を保持して重複を削除。
    # カーソルの左側の文字列をクエリにしてpecoを起動
    # \nを改行に変換
    BUFFER="$(history -nr 1 | awk '!a[$0]++' | peco --query "$LBUFFER" | sed 's/\\n/\n/')"
    CURSOR=$#BUFFER             # カーソルを文末に移動
    zle -R -c                   # refresh
}
zle -N _peco-select-history
bindkey '^R' _peco-select-history

# start/stop tmux toggle (ctrl + ])
_start_tmux_if_stopped() {
    if ! is_tmux_runnning; then
        BUFFER="tmux attach"

        # カーソルの位置情報、「0」は行頭､「$」は行末｡
        # つまり、「カーソルの位置は､BUFFERの行末に」というもの｡
        CURSOR=$#BUFFER
        zle accept-line
    else
        tmux detach
    fi
}
zle -N _start_tmux_if_stopped
bindkey '^]' _start_tmux_if_stopped

