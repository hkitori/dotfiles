
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

# cdなしでディレクトリ名を直接指定して移動
setopt auto_cd

# コマンド履歴
HISTFILE=~/.zsh_history
HISTSIZE=6000000
SAVEHIST=6000000
setopt hist_ignore_dups     # ignore duplication command history list

# .zshhistoryの共有
setopt share_history
# 履歴をインクリメンタルに追加
setopt inc_append_history

# https://sanoto-nittc.hatenablog.com/entry/2017/12/16/213735
# zplug
if [[ ! -d ~/.zplug ]]; then
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

# Install p10k
# https://github.com/romkatv/powerlevel10k
# https://qiita.com/szk07/items/b15c38ec73e547a23439
if [[ -f ~/.p10k.zsh ]]; then
    # To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
    source ~/.p10k.zsh
elif [[ -f ~/specific/.p10k.zsh ]]; then
    # use pre-configured .p10k.zsh
    source ~/specific/.p10k.zsh
else
    # Intall MesloLGS NF Regular.ttf font for p10k
    if [[ ! -d ~/.p10k/powerlevel10k-media ]]; then
        git clone https://github.com/romkatv/powerlevel10k-media ~/.p10k/powerlevel10k-media
        sudo cp ~/.p10k/powerlevel10k-media/MesloLGS\ NF\ Regular.ttf /usr/share/fonts/truetype/
        # for MAC
        # Double-click on each file and click "Install". This will make MesloLGS NF font available
        # to all applications on your system. Configure your terminal to use this font:
        #   MesloLGS NF Regular.ttf
        #   MesloLGS NF Bold.ttf
        #   MesloLGS NF Italic.ttf
        #   MesloLGS NF Bold Italic.ttf
        # Or cp them to ~/Library/Fonts ?
        # iTerm2: Open iTerm2 → Preferences → Profiles → Text and set Font to MesloLGS NF.
        # Alternatively, type p10k configure and answer Yes when asked whether to install Meslo Nerd Font.
    fi

    # Install p10k
    if [[ ! -d ~/.p10k/powerlevel10k ]]; then
        git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.p10k/powerlevel10k
    fi
fi
# enable p10k
source ~/.p10k/powerlevel10k/powerlevel10k.zsh-theme

# load .zsh/
source ~/.zsh/[0-9]*.zsh
for zsh in ~/.zsh/[0-9]*.zsh; do
    source "$zsh"
done

# PATH
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
# 部分一致の有効化
# https://stackoverflow.com/questions/22600259/zsh-autocomplete-from-the-middle-of-filename
zstyle ':completion:*' completer _complete
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' '+l:|=* r:|=*'
# 補完機能を有効化して、実行する
autoload -U compinit && compinit -u

# gtagsでパース時、pygmentsを使うようにする
export GTAGSLABEL=pygments

# anyenv起動(pyenv, rbenv...)
eval "$(anyenv init -)"

# nodebrew for node.js
export PATH=$HOME/.nodebrew/current/bin:$PATH

# for pip3
#export PATH=$HOME/Library/Python/3.8/bin:$PATH

# backspace+tabでtab補完を逆順にする
bindkey '^[[Z' reverse-menu-complete

# Rust
source $HOME/.cargo/env

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

