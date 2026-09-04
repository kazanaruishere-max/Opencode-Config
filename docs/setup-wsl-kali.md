# Setup WSL Kali Native — Agent-Harness Readable

> Tujuan: `opencode` jalan **native Linux di Kali** (path bersih, alat Kali langsung kepakai), `9router` tetap di host Windows. Tanpa tabrakan Windows↔Kali.

## Prasyarat (host Windows)

- [ ] 9router berjalan di `127.0.0.1:20128` (`Get-NetTCPConnection -LocalPort 20128` ada).
- [ ] WSL distro `kali-linux` + user `keelnam` tersedia.
- [ ] `~/.wslconfig` = `[wsl2]\nnetworkingMode=mirrored` dan `/etc/wsl.conf` di Kali = `[interop]\nappendWindowsPath=false` (sudah ada di wrapper `wsl/` repo ini; cukup `wsl --shutdown` 1x setelah ubah).

## Langkah Install (jalankan sekali, di Kali sebagai root)

```bash
# Node 22 LTS
curl -fsSL https://deb.nodesource.com/setup_22.x -o /tmp/nodesource_setup.sh && bash /tmp/nodesource_setup.sh && apt-get install -y nodejs && node --version

# opencode (pin samakan host Windows)
npm install -g opencode-ai@1.18.27 && opencode --version

# CTF tools yang belum ada (hasil verifikasi: 3 yang missing)
apt-get install -y zbar-tools fcrackzip sox
ln -sf /home/keelnam/volatility3/venv/bin/vol /usr/local/bin/vol
```

## Konfigurasi Kali (≈30 detik)

```bash
mkdir -p ~/.config/opencode/prompts/agents ~/.config/opencode/instructions ~/.config/opencode/docs ~/.config/opencode/skills-custom/ctf ~/ctf
# Copy dari repo ini (ganti REPO_PATH):
# - AGENTS.md → ~/.config/opencode/AGENTS.md
# - prompts/agents/{ctf,pentest,researcher}.txt → sama di Kali
# - instructions/NO-SLOP.md → ...
# - docs/cybersecurity-catalog.md → ...
# - 8 skill ctf-* (skills-custom/ctf/) → ...
cp /mnt/c/Users/Lenovo/.agents/skills/cybersecurity /home/keelnam/.agents/skills/cybersecurity -r  # 7.7MB, 180+8
```

Kunci `opencode.json` di Kali (template sudah di `examples/ctf-project/` repo, adaptasi untuk global Kali):

```json
{
  "model": "9router/deepreasoning",
  "provider": { "9router": { "options": { "baseURL": "http://127.0.0.1:20128/v1", "apiKey": "{env:NINEROUTER_API_KEY}" } } },
  "skills": { "paths": ["/home/keelnam/.config/opencode/skills-custom/ctf", "/home/keelnam/.agents/skills/cybersecurity"] },
  "mcp": { "filesystem": { "command": ["npx","-y","@modelcontextprotocol/server-filesystem","/home/keelnam/ctf"] } }
}
```

### API key (env)

```bash
echo 'export NINEROUTER_API_KEY=...' >> ~/.bashrc
echo 'export CONTEXT7_API_KEY=...' >> ~/.bashrc
# non-interaktif butuh export juga: opencode run non-interaktif tidak load .bashrc
```

## Variasi "Otak di Windows, Tangan di Kali" (tanpa install di Kali)

Kalau mau HANYA `bash` tool yang di Kali (opencode tetap di Windows):

1. Copy `wsl/kali-bash.cmd` + `wsl/kali-bash.ps1` → `C:\Users\<kamu>\bin\`
2. Di folder CTF Windows, buat `opencode.json`: `{ "shell": "C:\\Users\\<kamu>\\bin\\kali-bash.cmd" }`
3. `read/edit` (Windows) vs `bash` (Kali `/mnt/c/...`) — path diterjemahkan otomatis via prompt `ctf.txt`.

## Verifikasi (Kali)

```bash
opencode --version            # 1.18.27
opencode mcp list             # 3/3 connected (pre-warm: npx -y @modelcontextprotocol/server-memory --help)
opencode models 9router       # deepreasoning / fastcode
# 188 skills: ls ~/.agents/skills/cybersecurity | wc -l
opencode run 'echo E2E-KALI-OK'   # → E2E-KALI-OK
```

## Troubleshooting

| Gejala | Penyebab | Fix |
|---|---|---|
| `Missing API key` di `opencode run` non-interaktif | `.bashrc` tidak ter-load | `export VAR=...` sebelum run, atau `opencode --env` |
| MCP `Operation timed out 30000ms` | first-run `npx` download | `npx -y <pkg> --help` 1x (pre-warm) |
| `Unknown key 'networkingMode' in /etc/wsl.conf` | opsi di file salah | `networkingMode` hanya di `~/.wslconfig` ([wsl2]), bukan `/etc/wsl.conf` |
| `systemd user session failed` di shell | race setelah `wsl --shutdown` | `systemctl --user reset-failed user@1000 && systemctl --user start user@1000` |
| Path `/mnt/c/Users/...` di Kali | belum `appendWindowsPath=false` | `/etc/wsl.conf` `[interop] appendWindowsPath=false` + `wsl --shutdown` |
