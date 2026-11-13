#!/usr/bin/env bash
# Reconstruct the bootable ISO from Git LFS parts (GitHub's per-file LFS
# limit is 2GiB; this image is 2.10GiB).
set -euo pipefail
cd "$(dirname "$0")"
out=silicaos-2026.11.13-x86_64.iso
shopt -s nullglob
parts=("$out".part*)
if (( ${#parts[@]} == 0 )); then
  echo "error: no $out.part* files (git lfs pull?)" >&2
  exit 1
fi
echo "concatenating ${#parts[@]} parts -> $out"
cat "${parts[@]}" >"$out"
sha256sum -c "$out.sha256"
ls -lh "$out"
