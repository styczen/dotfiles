# Fix Spotify fullscreen
alias fix_spotify='sed -i "/\b\(app.window.position\)\b/d" -- $HOME/.config/spotify/prefs'
