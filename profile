# Fix Spotify fullscreen
alias fix_spotify='sed -i "/\b\(app.window.position\)\b/d" -- $HOME/.config/spotify/prefs'

# user@host:dir with nice colors
PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\W\[\033[00m\]\$ '

# Dark theme
export GTK_THEME=Adwaita:dark
