# SilicaOS ISO artifact

Bootable image: `silicaos-2026.11.13-x86_64.iso` (2,257,616,896 bytes, 2.10 GiB).

GitHub Free/Pro **Git LFS rejects files over 2 GiB**, so the ISO is stored as LFS parts:

- `silicaos-2026.11.13-x86_64.iso.part00`
- `silicaos-2026.11.13-x86_64.iso.part01`

After `git lfs pull` (or a normal clone with LFS):

```bash
./iso/out/assemble.sh
```

That writes `iso/out/silicaos-2026.11.13-x86_64.iso` and checks SHA-256
`e6b7efe3f37ed2adfa2936954f85ed20c6d98ddd9913730e2f9478bfd6f5d124`.

The assembled `.iso` is gitignored so it is not re-committed.
