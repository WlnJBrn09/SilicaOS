# Start Hyprland on the graphical live TTY when no session is running.
if [[ -z ${WAYLAND_DISPLAY:-} && -z ${DISPLAY:-} && ${XDG_VTNR:-} == 1 ]]; then
  exec /usr/local/bin/silica-session
fi
