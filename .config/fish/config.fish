# Aliases
alias vi='nvim'
alias vim='nvim'
<<<<<<< HEAD
if test -x /opt/homebrew/bin/brew
    eval (/opt/homebrew/bin/brew shellenv)
end
=======

>>>>>>> 3fd96df89a7462c2d328efaeae30f61463e03ddf
# Source additional configuration (equivalent to source ~/.envrc)
# Note: Fish uses 'source' command like zsh, but the file extension might need to be .fish
if test -f ~/.envrc.fish
    source ~/.envrc.fish
end

# Set environment variables
set -x EDITOR nvim
<<<<<<< HEAD
set -x PYTHON_PATH ~/.local/share/mise/installs/python/3.12/bin
=======
set -x PYTHON_PATH ~/.local/share/mise/installs/python/3.13/bin
set -x NIXPKGS_ALLOW_UNFREE 1
>>>>>>> 3fd96df89a7462c2d328efaeae30f61463e03ddf

# Modify PATH
fish_add_path $PYTHON_PATH
fish_add_path ~/.local/share/mise/shims
<<<<<<< HEAD
fish_add_path ~/.rustup/toolchains/stable-aarch64-apple-darwin/bin
fish_add_path ~/.cargo/bin


=======
fish_add_path ~/.nix-profile/bin
fish_add_path ~/.local/bin
fish_add_path ~/.local/share/coursier/bin
fish_add_path /nix/var/nix/profiles/default/bin
>>>>>>> 3fd96df89a7462c2d328efaeae30f61463e03ddf
# Set up direnv hook (assuming direnv is installed)
if command -v direnv >/dev/null
    direnv hook fish | source
end

if status is-interactive
end
# Fishline configuration
if type -q fishline
    function fish_prompt
        fishline -s $status
    end

    # Customize your fishline prompt
    set -g FLINE_PATH_STYLE segments
    set -g FLINE_PATH_MAX_LENGTH 20
    set -g FLINE_PROMPT_CHAR_VI_DEFAULT '❯'
    set -g FLINE_PROMPT_CHAR_VI_INSERT '❮'

    # Enable some built-in themes (uncomment the ones you want)
    # set FLINE_THEME git jobs vi_mode
    # set FLINE_THEME pwd git vi_mode

    # Or create a custom theme
    set FLINE_THEME pwd git jobs vi_mode arrow
end
