# Fix Spotify fullscreen
alias fix_spotify='sed -i "/\b\(app.window.position\)\b/d" -- $HOME/.config/spotify/prefs'

# user@host:dir with nice colors
PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\W\[\033[00m\]\$ '

# Dark theme
export GTK_THEME=Adwaita:dark

# Temporary fix to turn on built in display
alias fix_display='xrandr --output eDP-1-1 --auto'

# O3DE - generate compile_commands.json file
alias o3de_compile_commands='cmake -B build_without_unity -G "Ninja Multi-Config" -DLY_UNITY_BUILD=OFF -DCMAKE_EXPORT_COMPILE_COMMANDS=1 && cp build_without_unity/compile_commands.json . && rm -rf build_without_unity'

