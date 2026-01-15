# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

export CODEX_TRACKER_SOCKET="/run/user/1000/agent-tracker.sock"

conda() {
    unset -f conda
    if [ -f "/home/immortal-pc1/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/immortal-pc1/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/immortal-pc1/miniconda3/bin:$PATH"
    fi
    conda "$@"
}

export NVM_DIR="$HOME/.nvm"
nvm() {
    unset -f nvm
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    nvm "$@"
}

export ZSH_DISABLE_COMPFIX=true
export ZSH_COMPDUMP="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompdump"
mkdir -p "${ZSH_COMPDUMP:h}"
autoload -Uz compinit
compinit -C -d "$ZSH_COMPDUMP"
compinit() { :; }
