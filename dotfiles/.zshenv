# from https://unix.stackexchange.com/questions/71253/what-should-shouldnt-go-in-zshenv-zshrc-zlogin-zprofile-zlogout
#
# .zshenv is always sourced. It often contains exported variables that should be
# available to other programs. For example, $PATH, $EDITOR, and $PAGER are often
# set in .zshenv. Also, you can set $ZDOTDIR in .zshenv to specify an
# alternative location for the rest of your zsh configuration.

# prevent loading macOS's default startup files
#
# this is done because the /etc/zprofile startup file runs macOS's path helper
# AFTER .zshenv, reverting the order of things added to $PATH, making it
# impossible to override things like git with Homebrew versions
setopt no_global_rcs

# only set up the environment in top-level shells
#
# if you don't do this, then $PATH will be appended to again when you open a
# sub-shell
if [[ $SHLVL = 1 ]]; then
  if [[ -n $SSH_CONNECTION ]]; then
    # use vim as the editor when using SSH
    export EDITOR="vim"
  else
    # use neovim as the editor when not using SSH
    export EDITOR="nvim"
  fi

  # default options for less
	# I didn't write this, and I can't recall where it came from
  #
  # -g   = highlight single search matches instead of all matches
  # -i   = ignore case in searches if the search string is all lowercase
  # -M   = more verbose prompt
  # -R   = display raw control characters while maintaining screen appearance
  # -S   = chop long lines instead of folding
  # -w   = highlight the first new line after a forward page movement
  # -z-4 = set the scrolling window size to 4 lines less than the screen size
  export LESS="-g -i -M -R -S -w -z-4"

  # automatically update Homebrew every 5 minutes
  export HOMEBREW_AUTO_UPDATE_SECS=300

  # execute the macOS path helper, which adds OS-level things to $PATH
  if [[ -x /usr/libexec/path_helper ]]; then
    eval "$(/usr/libexec/path_helper -s)"
  fi

  # add Homebrew's shell environment additions
  # Homebrew is installed to a different path on Apple Silicon vs Intel Macs
  if [[ -e /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [[ -e /usr/local/bin/brew ]]; then
    eval "$(/usr/local/bin/brew shellenv)"
  fi

  # add custom functions to $FPATH
  export FPATH="$HOME/.functions:$FPATH"

  # add custom binaries to $PATH
  export PATH="/Library/Frameworks/Mono.framework/Versions/Current/bin:$PATH"
  export PATH="$HOME/go/bin:$PATH"
  export PATH="$HOME/bin:$PATH"
  export PATH="$HOME/.asdf/shims:$PATH"

  # Silence direnv output
  export DIRENV_LOG_FORMAT=

  # Node.js
  export ASDF_NODEJS_AUTO_ENABLE_COREPACK=true
  export ASDF_NODEJS_LEGACY_FILE_DYNAMIC_STRATEGY=latest_installed
  export NODE_OPTIONS="--disable-warning=DeprecationWarning --disable-warning=ExperimentalWarning"

  # include private env vars
  source "$HOME/.zshenv.private"

  # include extension env vars
  setopt nullglob
  for FILE in "$HOME/dotfiles/extensions/"*/dotfiles/.zshenv; do
    source "$FILE"
  done
  unsetopt nullglob
fi
