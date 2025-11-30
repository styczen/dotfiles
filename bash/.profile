export PATH="$HOME/.local/bin:$PATH"

# Rust / Cargo
if [ -f "$HOME/.cargo/env" ]; then
    . "$HOME/.cargo/env"
fi

# If this shell is bash, load .bashrc for interactive stuff
if [ -n "$BASH_VERSION" ] && [ -f "$HOME/.bashrc" ]; then
    . "$HOME/.bashrc"
fi
