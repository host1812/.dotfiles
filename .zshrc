# start tmux as soon as possible
TERM=tmux-256color
COLORTERM=truecolor
# [[ -z "$TMUX" ]] && exec $(/usr/bin/tmux attach || /usr/bin/tmux)
# if [ -z "$TMUX" ]
# then
    # tmux attach -t TMUX || tmux new -s TMUX
    # exec $(tmux attach || tmux)
# fi
if [ -t 0 ] && [[ -z $TMUX ]] && [[ $- = *i* ]]; then exec tmux; fi

# brew location

ZSH_PLUGINS_PREFIX=~/.zsh/plugins

# aliases
source "${HOME}/.zsh/aliases/base"
# load linkedin aliases only on linkedin laptop
if type mint > /dev/null; then
    source "${HOME}/.zsh/aliases/linkedin"
    source "${HOME}/.zsh/conf.d/linkedin.macos"
fi

# load microsoft aliases
if [ $(uname -r | sed -n 's/.*\( *Microsoft *\).*/\1/ip') ]; then
    source "${HOME}/.zsh/aliases/microsoft"
    source "${HOME}/.zsh/conf.d/microsoft.wsl2"
else
    source "${HOME}/.zsh/conf.d/personal.macos"
fi

# history settings
HISTFILESIZE=100000
HISTSIZE=100000
SAVEHIST=100000
HISTFILE=~/.zsh_history
# update history in real time
setopt INC_APPEND_HISTORY
# use extended history format
setopt EXTENDED_HISTORY
# ignore history duplicates when searching
setopt HIST_FIND_NO_DUPS

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

# enable partial search
source "${ZSH_PLUGINS_PREFIX}/zsh-history-substring-search/zsh-history-substring-search.zsh"

# enable zsh-autosuggestions
source "${ZSH_PLUGINS_PREFIX}/zsh-autosuggestions/zsh-autosuggestions.zsh"
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#696969,underline"

# enable zsh-syntax-highlighting
source "${ZSH_PLUGINS_PREFIX}/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

# kubernetes autocomplitionss
source <(kubectl completion zsh)

# activate starship (brew)
eval "$(starship init zsh)"
