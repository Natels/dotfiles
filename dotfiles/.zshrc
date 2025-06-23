# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# load custom functions
autoload -Uz "$HOME/.functions/"*(:t)

# include Powerlevel10k instant prompt
# see https://github.com/romkatv/powerlevel10k#instant-prompt
source-if-exists "$HOME/.cache/p10k-instant-prompt-${(%):-%n}.zsh"
# include z
# see https://github.com/rupa/z
source-if-exists "$(brew --prefix)/etc/profile.d/z.sh"
# include prezto
# see https://github.com/sorin-ionescu/prezto
source-if-exists "$HOME/.zprezto/init.zsh"
# include Powerlevel10k
# see https://github.com/romkatv/powerlevel10k
source-if-exists "$HOME/.p10k.zsh"

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

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
