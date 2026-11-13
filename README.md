# SilicaOS

Arch Linux live/install ISO with **Hyprland on Wayland**, Foot, Brave, and
DHH’s Omarchy Waybar.

The image is a stock [archiso](https://wiki.archlinux.org/title/Archiso)
releng profile plus a Hyprland desktop. Install it with `archinstall` from
the live session (or from TTY2 as root).

## Desktop

| Piece | Source |
| --- | --- |
| Hyprland + Wayland portals | Arch `extra` |
| Foot | Arch `extra`, Omarchy v3.8.4 `foot.ini` |
| Brave | AUR `brave-bin` (official binaries) |
| Waybar | Arch `extra`, **Omarchy v3.8.4** config and CSS (DHH) |
| omarchy-screensaver | [omacom/omarchy-screensaver](https://github.com/omacom/omarchy-screensaver) |
| omarchy-hyprland-titlebars | [omacom/omarchy-hyprland-titlebars](https://github.com/omacom/omarchy-hyprland-titlebars) |
| Folio | [omacom/folio](https://github.com/omacom/folio) |
| Omasnap | [omacom/omasnap](https://github.com/omacom/omasnap) |
| Theme registry | [omacom/omarchy-theme-registry](https://github.com/omacom/omarchy-theme-registry) catalog + `silica-theme` |

Licenses and pins: [THIRD_PARTY.md](THIRD_PARTY.md).

## Build the ISO

On **Arch Linux**, as root:

```bash
sudo pacman -S --needed archiso base-devel git
sudo ./iso/build.sh
```

The ISO is written to `iso/out/silicaos-YYYY.MM.DD-x86_64.iso`.

GitHub Free/Pro Git LFS rejects a single file over 2 GiB. The built image is
2.10 GiB, so it is **not** stored in this repository (no split parts).

Default wallpaper is Hokusai’s Great Wave (white ground, red sun, black wave).
Hyprland 0.57.2 is launched with `Hyprland -c ~/.config/hypr/hyprland.conf`.

`iso/build.sh` will:

1. Build `omarchy-screensaver`, `omarchy-hyprland-titlebars`, `folio`, and
   `omasnap` from the PKGBUILDs in `iso/pkgbuilds/` (upstream git tags).
2. Build AUR [`brave-bin`](https://aur.archlinux.org/packages/brave-bin).
3. Publish those packages to a local pacman repo.
4. Run `mkarchiso` on `iso/profile/`.

You can also invoke archiso yourself after the local repo exists:

```bash
sudo mkarchiso -v -w iso/work -o iso/out iso/profile
```

The live user is `silica` / `silica`. TTY2 autologins as `root` (empty
password, same as archiso releng) for rescue/`archinstall`.

### Keys (live session)

- `Super+Return` — Foot
- `Super+Shift+B` — Brave
- `Super+Shift+F` — Folio
- `Super+Space` — fuzzel
- `Print` — Omasnap
- `Super+Alt+Space` — menu
