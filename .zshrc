
export PATH="$PATH:~/bin/"

# 補完機能
autoload -U compinit
compinit

# プロンプト
if [ $UID -eq 0 ]; then
    # ルートユーザーの場合
    PROMPT="%f%F{green}%~%f %% "
    #PROMPT="%F{red}%n:%f%F{green}%~%f %% "
else
    # ルートユーザー以外の場合
    PROMPT="%f%F{green}%~%f %% "
    #PROMPT="%F{cyan}%n:%f%F{green}%~%f %% "
fi

# コマンド履歴
HISTFILE=~/.zsh_history
HISTSIZE=6000000
SAVEHIST=6000000
setopt hist_ignore_dups     # ignore duplication command history list

# .zshhistoryの共有
setopt share_history
# 履歴をインクリメンタルに追加
setopt inc_append_history

# コマンド履歴検索
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end


# https://sanoto-nittc.hatenablog.com/entry/2017/12/16/213735
# zplug
if [[ ! -d ~/.zplug ]];then
  git clone https://github.com/zplug/zplug ~/.zplug
fi
source ~/.zplug/init.zsh

# https://tshst.tumblr.com/post/151599091861/zshの環境を整える
#-- zsh-syntax-highlighting
zplug "zsh-users/zsh-syntax-highlighting"
#-- zsh-completions
zplug "zsh-users/zsh-completions"
#-- zsh-autosuggestions
zplug "zsh-users/zsh-autosuggestions"
#-- zsh-git-prompt
zplug "olivierverdier/zsh-git-prompt"

# ls --colorのためにlinux環境のlsを入れる
# brew install coreutils
#export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
#export LS_COLORS=gxBxhxDxfxhxhxhxhxcxcx

# peco history selection (ctrl + r)
function peco-select-history() {
    # historyを番号なし、逆順、最初から表示。
    # 順番を保持して重複を削除。
    # カーソルの左側の文字列をクエリにしてpecoを起動
    # \nを改行に変換
    BUFFER="$(history -nr 1 | awk '!a[$0]++' | peco --query "$LBUFFER" | sed 's/\\n/\n/')"
    CURSOR=$#BUFFER             # カーソルを文末に移動
    zle -R -c                   # refresh
}
zle -N peco-select-history
bindkey '^R' peco-select-history

# load .zsh/
source ~/.zsh/[0-9]*.zsh

