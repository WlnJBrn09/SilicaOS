# ISO builder

See the [top-level README](../README.md) for the documented build command:

```bash
sudo ./iso/build.sh
```

- `profile/` — archiso profile (releng + SilicaOS overlay)
- `pkgbuilds/` — Omarchy-derived PKGBUILDs (screensaver, titlebars, folio, omasnap)
- `vendor/` — pinned configs, licenses, theme-registry catalog
- `packages.local.x86_64` — packages assembled into the local repo before mkarchiso
