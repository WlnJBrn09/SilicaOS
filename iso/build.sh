#!/usr/bin/env bash
# Build the SilicaOS live/install ISO with archiso.
#
#   sudo ./iso/build.sh
#
# Must run on Arch Linux (or an Arch chroot) as root. Installs archiso if
# needed, builds AUR/git packages into a local repo, then runs mkarchiso.
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PROFILE="$ROOT/iso/profile"
PKGBUILDS="$ROOT/iso/pkgbuilds"
OUT="${SILICA_OUT:-$ROOT/iso/out}"
WORK="${SILICA_WORK:-$ROOT/iso/work}"
REPO_DIR="${SILICA_REPO:-/tmp/silicaos-repo}"
BUILD_USER="${SILICA_BUILD_USER:-silicabuild}"

log() { printf '==> %s\n' "$*"; }
die() { printf 'error: %s\n' "$*" >&2; exit 1; }

need_arch() {
  [[ -f /etc/os-release ]] || die "cannot detect OS"
  # shellcheck disable=SC1091
  . /etc/os-release
  [[ ${ID:-} == arch ]] || die "mkarchiso must run on Arch Linux (this host is ${ID:-unknown}). See README.md."
}

need_root() {
  [[ ${EUID} -eq 0 ]] || die "run as root: sudo $0"
}

ensure_archiso() {
  command -v mkarchiso >/dev/null || pacman -Sy --noconfirm --needed archiso base-devel git sudo
  pacman -Sy --noconfirm --needed archiso base-devel git sudo pacman-contrib
}

ensure_build_user() {
  if ! id "$BUILD_USER" >/dev/null 2>&1; then
    useradd -m -G wheel -s /bin/bash "$BUILD_USER"
  fi
  echo "$BUILD_USER ALL=(ALL) NOPASSWD: ALL" >/etc/sudoers.d/silica-build
  chmod 440 /etc/sudoers.d/silica-build
}

makepkg_as_user() {
  local dir=$1
  log "building $(basename "$dir")"
  install -d -o "$BUILD_USER" -g "$BUILD_USER" "$dir"
  chown -R "$BUILD_USER:$BUILD_USER" "$dir"
  # --nocheck: omasnap's smoke tests need a compositor; skip on the ISO host.
  su -s /bin/bash "$BUILD_USER" -c "cd $(printf '%q' "$dir") && makepkg -sf --noconfirm --needed --nocheck"
}

build_local_repo() {
  local staging
  staging=$(mktemp -d /tmp/silicaos-pkgbuild.XXXXXX)
  chown "$BUILD_USER:$BUILD_USER" "$staging"
  mkdir -p "$REPO_DIR"
  rm -f "$REPO_DIR"/silicaos.db* "$REPO_DIR"/*.pkg.tar.* || true

  # Omarchy desktop tools from vendored PKGBUILDs (git sources).
  for pkg in omarchy-screensaver omarchy-hyprland-titlebars folio omasnap; do
    cp -a "$PKGBUILDS/$pkg" "$staging/$pkg"
    makepkg_as_user "$staging/$pkg"
    cp "$staging/$pkg"/*.pkg.tar.zst "$REPO_DIR/"
  done

  # Brave official binaries via AUR brave-bin.
  log "cloning AUR brave-bin"
  su -s /bin/bash "$BUILD_USER" -c "git clone --depth 1 https://aur.archlinux.org/brave-bin.git $(printf '%q' "$staging/brave-bin")"
  makepkg_as_user "$staging/brave-bin"
  cp "$staging/brave-bin"/*.pkg.tar.zst "$REPO_DIR/"

  repo-add "$REPO_DIR/silicaos.db.tar.gz" "$REPO_DIR"/*.pkg.tar.zst
  log "local repo at $REPO_DIR"
}

rewrite_pacman_conf() {
  # Point the profile at this build's repo directory.
  sed -i "s|^Server = file://.*|Server = file://${REPO_DIR}|" "$PROFILE/pacman.conf"
}

run_mkarchiso() {
  mkdir -p "$OUT"
  rm -rf "$WORK"
  mkarchiso -v -w "$WORK" -o "$OUT" "$PROFILE"
  log "ISO written under $OUT"
  ls -lh "$OUT"/*.iso
}

main() {
  need_arch
  need_root
  ensure_archiso
  ensure_build_user
  build_local_repo
  rewrite_pacman_conf
  run_mkarchiso
}

main "$@"
