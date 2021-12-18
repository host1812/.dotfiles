# start tmux as soon as possible
[[ -z "$TMUX" ]] && exec `tmux attach || tmux`

# aliases
source ~/.zsh/aliases/base

# seach history with up/down keys
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search # Up
bindkey "^[[B" down-line-or-beginning-search # Down

# moving back/forward by words
autoload -U select-word-style
select-word-style bash

# highlight section with tab complition
autoload -Uz compinit
compinit
zstyle ':completion:*' menu yes select


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/${USER}/miniconda/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/${USER}/miniconda/etc/profile.d/conda.sh" ]; then
        . "/Users/${USER}/miniconda/etc/profile.d/conda.sh"
    else
        export PATH="/Users/${USER}/miniconda/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# enable zsh-autosuggestions (brew)
source ${HOMEBREW_PREFIX}/share/zsh-autosuggestions/zsh-autosuggestions.zsh
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#696969,underline"

# enable zsh-syntax-highlighting (brew)
source ${HOMEBREW_PREFIX}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# activate starship (brew)
eval "$(starship init zsh)"

