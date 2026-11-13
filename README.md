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

The ISO is written to `iso/out/silicaos-YYYY.MM.DD-x86_64.iso`. The profile
stays in git; the bootable image is meant to ship as a
[GitHub Release](https://github.com/WlnJBrn09/SilicaOS/releases/tag/2026.11.13)
asset, not as a git blob.

### Download (2026.11.13)

| | |
| --- | --- |
| File | `silicaos-2026.11.13-x86_64.iso` (2,259,714,048 bytes, 2.10 GiB) |
| SHA-256 | `89db1c1709ec3e44f3d8178ce6728db1a55c0af34b31f6cf98f58e59e94d354f` |
| Release | https://github.com/WlnJBrn09/SilicaOS/releases/tag/2026.11.13 |

**The ISO is not on that release.** GitHub rejected the asset upload:

```
HTTP 422: Validation Failed
(https://uploads.github.com/repos/WlnJBrn09/SilicaOS/releases/443822368/assets?name=silicaos-2026.11.13-x86_64.iso)
size must be less than 2147483648
```

GitHub’s per-file cap is 2 GiB (2,147,483,648 bytes). This image is 107 MiB over.
Build it locally with the command above (no split parts in git).

### Install

1. Flash the ISO to USB (`dd`, Ventoy, or similar) or boot it in a VM (QEMU/KVM, ≥3 GiB RAM for live; ≥8 GiB to run `archinstall`).
2. Live user: `silica` / `silica` (Hyprland on TTY1). TTY2 is `root` with an empty password.
3. Install with `archinstall` from the live session or TTY2.

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
