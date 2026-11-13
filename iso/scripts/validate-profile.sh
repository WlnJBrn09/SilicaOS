#!/usr/bin/env bash
# Sanity-check the archiso profile without building an ISO.
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
PROFILE="$ROOT/iso/profile"
fail=0
need() {
  if [[ ! -e $1 ]]; then
    printf 'missing: %s\n' "$1" >&2
    fail=1
  fi
}
need "$PROFILE/profiledef.sh"
need "$PROFILE/packages.x86_64"
need "$PROFILE/pacman.conf"
need "$PROFILE/airootfs/etc/skel/.config/hypr/hyprland.conf"
need "$PROFILE/airootfs/etc/skel/.config/waybar/config.jsonc"
need "$PROFILE/airootfs/etc/skel/.config/waybar/style.css"
need "$PROFILE/airootfs/etc/skel/.config/foot/foot.ini"
need "$PROFILE/airootfs/usr/share/silicaos/hypr/bindings.conf"
need "$PROFILE/airootfs/usr/share/fonts/silicaos/omarchy.ttf"
need "$PROFILE/airootfs/usr/share/silicaos/theme-registry/LICENSE"
need "$PROFILE/airootfs/usr/local/bin/silica-menu"
need "$ROOT/iso/pkgbuilds/omarchy-screensaver/PKGBUILD"
need "$ROOT/iso/pkgbuilds/omarchy-hyprland-titlebars/PKGBUILD"
need "$ROOT/iso/pkgbuilds/folio/PKGBUILD"
need "$ROOT/iso/pkgbuilds/omasnap/PKGBUILD"
need "$ROOT/iso/vendor/omarchy-waybar/LICENSE"
need "$ROOT/iso/build.sh"
grep -q '^hyprland$' "$PROFILE/packages.x86_64" || { echo 'packages.x86_64 missing hyprland'; fail=1; }
grep -q '^waybar$' "$PROFILE/packages.x86_64" || { echo 'packages.x86_64 missing waybar'; fail=1; }
grep -q '^foot$' "$PROFILE/packages.x86_64" || { echo 'packages.x86_64 missing foot'; fail=1; }
grep -q '^brave-bin$' "$PROFILE/packages.x86_64" || { echo 'packages.x86_64 missing brave-bin'; fail=1; }
grep -q '^omarchy-screensaver$' "$PROFILE/packages.x86_64" || { echo 'packages.x86_64 missing omarchy-screensaver'; fail=1; }
count=$(find "$PROFILE/airootfs/usr/share/silicaos/theme-registry/themes" -name '*.json' | wc -l)
(( count > 100 )) || { echo "theme registry too small: $count"; fail=1; }
if (( fail )); then
  exit 1
fi
echo "profile ok ($count registry themes)"
