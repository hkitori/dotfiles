

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
        # Double-click on each file and click "Install". This will make MesloLGS NF font available to all applications on your system. Configure your terminal to use this font:
        #   MesloLGS NF Regular.ttf
        #   MesloLGS NF Bold.ttf
        #   MesloLGS NF Italic.ttf
        #   MesloLGS NF Bold Italic.ttf
        # Or cp them to ~/Library/Fonts ?
        # iTerm2: Open iTerm2 → Preferences → Profiles → Text and set Font to MesloLGS NF. Alternatively, type p10k configure and answer Yes when asked whether to install Meslo Nerd Font.
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

