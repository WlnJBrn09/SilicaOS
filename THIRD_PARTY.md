# Third-party sources

SilicaOS is Arch Linux with a Hyprland/Wayland live desktop. The following
upstream projects are included as packages, git sources, or vendored configs.
Their licenses are copied next to the files and, on the live image, under
`/usr/share/licenses/`.

## Arch Linux / archiso

- Releng profile from [archiso](https://gitlab.archlinux.org/archlinux/archiso)
- GPL-3.0 (archiso); the live system is a standard Arch Linux installation image

## Omarchy (DHH)

- Project: https://github.com/omacom/omarchy
- Tag used for Waybar/Foot/Hyprland look: **v3.8.4**
- License: MIT, Copyright (c) David Heinemeier Hansson
- Vendored: Waybar `config.jsonc` + `style.css`, Foot `foot.ini`, Tokyo Night
  palette, `omarchy.ttf`, Hyprland look-and-feel and tiling bindings
- Omarchy 4.x replaced Waybar with a Quickshell bar. SilicaOS keeps DHH's
  Waybar from the last Waybar-era release, as required for this image.

## Omarchy ISO builder (reference)

- https://github.com/omacom/omarchy-iso (MIT) — consulted for archiso layout
  and the `pkgs.omarchy.org` repository, not copied as a whole

## omarchy-screensaver

- https://github.com/omacom/omarchy-screensaver
- MIT, written by Tobi Lütke
- Pulled from the v1.3.1 source tarball via `iso/pkgbuilds/omarchy-screensaver`

## omarchy-hyprland-titlebars

- https://github.com/omacom/omarchy-hyprland-titlebars
- BSD-3-Clause (upstream hyprbars) + MIT (Omarchy changes)
- Fork of Hypr Development [hyprbars](https://github.com/hyprwm/hyprland-plugins)
- Built against the ISO's `hyprland` during `iso/build.sh`

## folio

- https://github.com/omacom/folio
- MIT, David Heinemeier Hansson
- Omarchy's file manager

## omasnap

- https://github.com/omacom/omasnap
- MIT + OFL-1.1 (bundled fonts)
- Wayland screenshot/annotation overlay; Tobi Lütke

## omarchy-theme-registry

- https://github.com/omacom/omarchy-theme-registry
- MIT, Copyright (c) 2026 Taha Hossein Nejad
- The live image ships the catalog JSON (`themes/*.json`) and `silica-theme`,
  which clones a listed GitHub theme on demand. Theme repos keep their own
  licenses.

## PKGBUILDs

- Copied from https://github.com/omacom/omarchy-pkgs (MIT, DHH)
- `omarchy-hyprland-titlebars` no longer pins an exact `hyprland=` version so
  it compiles against the ISO's Arch `extra/hyprland`

## Brave

- https://aur.archlinux.org/packages/brave-bin
- Official Brave binaries, packaged by the AUR `brave-bin` maintainers
- Brave Software license applies to the browser itself
