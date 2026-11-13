# POSIX login fallback when the live user is not using zsh.
if [ -z "${WAYLAND_DISPLAY:-}" ] && [ -z "${DISPLAY:-}" ] && [ "${XDG_VTNR:-}" = 1 ]; then
  exec /usr/local/bin/silica-session
fi
