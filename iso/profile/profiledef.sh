#!/usr/bin/env bash
# shellcheck disable=SC2034

iso_name="silicaos"
iso_label="SILICAOS_$(date --date="@${SOURCE_DATE_EPOCH:-$(date +%s)}" +%Y%m)"
iso_publisher="SilicaOS <https://github.com/WlnJBrn09/SilicaOS>"
iso_application="SilicaOS Live/Install (Arch Linux + Hyprland)"
iso_version="$(date --date="@${SOURCE_DATE_EPOCH:-$(date +%s)}" +%Y.%m.%d)"
install_dir="arch"
buildmodes=('iso')
bootmodes=('bios.syslinux'
           'uefi.systemd-boot')
pacman_conf="pacman.conf"
airootfs_image_type="squashfs"
airootfs_image_tool_options=('-comp' 'xz' '-Xbcj' 'x86,arm64' '-b' '1M' '-Xdict-size' '1M')
bootstrap_tarball_compression=('zstd' '-c' '-T0' '--auto-threads=logical' '--long' '-19')
kernel_params_aarch64="clk_ignore_unused pd_ignore_unused arm64.nopauth"
file_permissions=(
  ["/etc/shadow"]="0:0:400"
  ["/root"]="0:0:750"
  ["/root/.automated_script.sh"]="0:0:755"
  ["/root/.gnupg"]="0:0:700"
  ["/usr/local/bin/choose-mirror"]="0:0:755"
  ["/usr/local/bin/Installation_guide"]="0:0:755"
  ["/usr/local/bin/livecd-sound"]="0:0:755"
  ["/usr/local/bin/silica-menu"]="0:0:755"
  ["/usr/local/bin/silica-session"]="0:0:755"
  ["/usr/local/bin/silica-theme"]="0:0:755"
  ["/usr/local/bin/silica-power"]="0:0:755"
  ["/usr/local/bin/omarchy-menu"]="0:0:755"
  ["/usr/local/bin/omarchy-launch-browser"]="0:0:755"
  ["/usr/local/bin/omarchy-launch-screensaver"]="0:0:755"
  ["/usr/local/sbin/silica-live-setup"]="0:0:755"
  ["/usr/local/sbin/silica-load-titlebars"]="0:0:755"
  ["/etc/sudoers.d/silicaos"]="0:0:440"
  ["/usr/share/silicaos/waybar/weather.sh"]="0:0:755"
)
