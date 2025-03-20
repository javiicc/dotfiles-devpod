# --------------- Environment Variables ---------------

# Directories
export REPOS="$HOME/repos"
export DOTFILES="$HOME/workspace/dotfiles-devpod"

# History settings
export HISTFILE=~/.zsh_history
export HISTTIMEFORMAT="%Y/%m/%d %H:%M:%S:   "
export HISTSIZE=50000        # History lines stored in mememory.
export SAVEHIST=50000        # History lines stored on disk.
setopt INC_APPEND_HISTORY    # Immediately append commands to history file.
setopt HIST_IGNORE_ALL_DUPS  # Never add duplicate entries.
setopt HIST_IGNORE_SPACE     # Ignore commands that start with a space.
setopt HIST_REDUCE_BLANKS    # Remove unnecessary blank lines.

# Zsh-autosuggestions settings
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=238"
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20


# ---------------- Aliases ----------------

alias cdot="cd $DOTFILES"

alias ls='ls -la'


# --------------- Sourcing ---------------

source <(kubectl completion zsh)
