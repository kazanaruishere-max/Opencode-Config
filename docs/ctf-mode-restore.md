# Restore Mode CTF (arsip)

Mode `ctf` dicabut dari config aktif setelah event selesai (hemat token: 1 agent + 218 baris workflow tidak lagi dimuat). Semua aset tetap tersimpan.

- Snapshot penuh: tag **`ctf-mode-v1`** (`918f959`)
- Prompt elite: `prompts/agents/ctf.txt` (122 baris — 8 kategori deterministik)
- Skill: `skills-custom/ctf/` (8 skill Misc, MIT)
- Recon: `examples/ctf-project/ctf-recon.sh`
- Writeup: `examples/ctf-project/writeups/` (TEMPLATE + COMPACT_COMPARISON)
- Shell override: `examples/ctf-project/opencode.json`

## Restore (1 menit)

1. Salin prompt kembali:

```powershell
Copy-Item prompts/agents/ctf.txt "$HOME\.config\opencode\prompts\agents\ctf.txt"
```

2. Tambah blok ini ke `agent` di `~/.config/opencode/opencode.json`:

```json
"ctf": {
  "description": "CTF all-rounder — classify, pick one skill from ~/.agents/skills/cybersecurity/, generate Kali-ready command (flag hunter)",
  "color": "#FF3B30",
  "mode": "primary",
  "model": "9router/deepreasoning",
  "prompt": "{file:prompts/agents/ctf.txt}"
},
```

3. Salin 8 skill ke pak cybersecurity:

```powershell
Copy-Item skills-custom/ctf/* "$HOME\.agents\skills\cybersecurity\" -Recurse -Force
```

4. Validasi JSON lalu restart opencode:

```powershell
Get-Content "$HOME\.config\opencode\opencode.json" -Raw | ConvertFrom-Json | Out-Null
```

## Restore penuh dari snapshot

```powershell
git checkout ctf-mode-v1
```

Salin `prompts/agents/ctf.txt`, `examples/ctf-project/`, `skills-custom/ctf/` ke config lokal, lalu kembali ke `main`.
