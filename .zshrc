# start tmux as soon as possible
[[ -z "$TMUX" ]] && exec $(tmux attach || tmux)

# brew location

BREW_PREFIX=$(brew --prefix)

# aliases
source "${HOME}/.zsh/aliases/base"
# load linkedin aliases only on linkedin laptop
if type mint > /dev/null; then
    source "${HOME}/.zsh/aliases/linkedin"
    source "${HOME}/.zsh/conf.d/linkedin"
fi

# history settings
HISTFILESIZE=100000
HISTSIZE=100000
SAVEHIST=100000
# update history in real time
setopt INC_APPEND_HISTORY
# use extended history format
setopt EXTENDED_HISTORY
# ignore history duplicates when searching
setopt HIST_FIND_NO_DUPS

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

# enable az cli bash completions
if [[ -f "${BREW_PREFIX}/etc/bash_completion.d/az" ]]
then
    autoload -U +X bashcompinit && bashcompinit
    source "${BREW_PREFIX}/etc/bash_completion.d/az"
fi

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/${USER}/miniconda/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "${HOME}/miniconda/etc/profile.d/conda.sh" ]; then
        . "${HOME}/miniconda/etc/profile.d/conda.sh"
    else
        export PATH="${HOME}/miniconda/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# enable zsh-autosuggestions (brew)
source "${BREW_PREFIX}/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#696969,underline"

# enable zsh-syntax-highlighting (brew)
source "${BREW_PREFIX}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

# activate starship (brew)
eval "$(starship init zsh)"
