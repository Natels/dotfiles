# load custom functions
autoload -Uz "$HOME/.functions/"*(:t)

# initialize completions
autoload -Uz compinit && compinit

# add completions support for commands that only support bash (e.g. Grit v1)
autoload -Uz bashcompinit && bashcompinit

# include Grit completions
# see https://github.com/jmalloc/grit#:~:text=eval%20%22%24(grit-,shell%2Dintegration,-)%22
eval "$(grit shell-integration)"
# include direnv
eval "$(direnv hook zsh)"

# don't add commands with leading spaces to history
setopt hist_ignore_space
# prevent the "file exists" warning when using shell redirection
setopt clobber
# don't automatically change directory when a command is not found, and a
# matching directory exists
unsetopt autocd
# don't attempt to auto-correct command names, just fail immediately
unsetopt correct

# treat underscores as part of words in the line editor
# this matches the behavior of code editors like VSCode
export WORDCHARS="_"

# check that Touch ID for sudo is still enabled
touchid-sudo-check

# include extension config
setopt nullglob
for FILE in "$HOME/dotfiles/extensions/"*/dotfiles/.zshrc; do
  source "$FILE"
done
unsetopt nullglob
