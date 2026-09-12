# Opencode-Config

Backup & restore kit untuk setup [opencode](https://opencode.ai) saya — charter (AGENTS.md), instructions, skills, commands, prompts, docs, dan struktur config. **Tanpa MCP & provider** — keduanya didokumentasikan di README ini saja, jadi kamu bebas pakai provider/MCP versimu sendiri.

## Struktur

```
├── opencode.json                 # config inti (tanpa mcp/provider) — 5 mode warna, 33 agents
├── AGENTS.md                     # Expert Operating Charter + Blok Accountability (WAJIB, 188 lines)
├── instructions/                 # always-on (INSTRUCTIONS, BROWSER-TOOLS, PUTERJS, NO-SLOP — anti-detection + code-quality)
├── commands/                     # slash commands (/plan, /tdd, /verify, /code-review, /security, ...)
├── prompts/agents/               # prompt template per-agent (planner, code-reviewer, ctf, pentest, researcher, ...)
├── agents/                       # ~232 subagent definition project-level (.md, community pack)
├── skills/                       # skill kurasi (tdd-workflow, security-review, graphify, no-ai-slop, ...)
├── skills-custom/ctf/            # 8 skill CTF Miscellaneous custom (MIT) — taruh ke folder cybersecurity pack
├── wsl/                          # wrapper WSL Kali: kali-bash.cmd + kali-bash.ps1
├── examples/ctf-project/         # opencode.json shell override (otak Windows → tangan Kali)
└── docs/
    ├── cybersecurity-catalog.md  # katalog 188 skill + workflow 8 kategori (on-demand)
    └── setup-wsl-kali.md         # installer WSL Kali native (manusia & agent)
```

## Restore

1. Clone repo ini, copy seluruh isi ke `~/.config/opencode/` (Windows: `C:\Users\<kamu>\.config\opencode\`).
2. Pasang provider sendiri (lihat section **Providers** di bawah) — config mereferensikan model di bawah provider ID `9router`.
3. (Opsional) Install 180 skill cybersecurity:
   ```bash
   git clone https://github.com/mukul975/Anthropic-Cybersecurity-Skills ~/.agents/skills/cybersecurity
   ```
   lalu copy isi `skills-custom/ctf/` ke dalamnya.
4. Restart opencode → tekan `@` untuk ganti mode (build/plan/**ctf**/**pentest**/**researcher**) — warna Tab membedakan; atau langsung `opencode --agent ctf`. Cek `opencode mcp list` dan `/models`.

### Mode 5-Way (warna Tab)

| Mode | Warna | Model | Use |
|---|---|---|---|
| `plan` | #AF52DE ungu | `9router/fastcode` | Arsitektur & planning |
| `build` | #34C759 hijau | `9router/deepreasoning` | Dev harian (default) |
| `ctf` | #FF3B30 merah | `9router/deepreasoning` | Flag hunter 8 kategori |
| `pentest` | #FF9500 oranye | `9router/deepreasoning` | Recon→Report (scoped) |
| `researcher` | #5AC8FA biru | `9router/deepreasoning` | Analisis read-only |

### WSL Kali Native (otak Windows → tangan Kali)

Lihat **[docs/setup-wsl-kali.md](docs/setup-wsl-kali.md)** — panduan 1-copy untuk instal opencode native di Kali Linux (isolasi PATH, tanpa tabrakan). Contoh project config ada di `examples/ctf-project/opencode.json` + wrapper `wsl/kali-bash.*`.

## Providers yang saya pakai

| Provider | Keterangan |
|---|---|
| `9router` | Proxy lokal OpenAI-compatible di `http://127.0.0.1:20128/v1` — router multi-model (pool alias: `deepreasoning`, `fastcode`, `slow`, `plan`, dll). Semua role agent mereferensikan alias ini. |
| `nvidia-nim` | NVIDIA NIM API (`integrate.api.nvidia.com`) — model GLM 5.2. |

> API key **tidak disertakan** dan tidak perlu sama dengan punyaku — daftarkan providermu sendiri via opencode (`/connect` atau blok `provider` di `opencode.json` dengan `options.apiKey` / `{env:VAR}`). Yang penting: config ini mengharapkan ada provider dengan ID `9router` yang menyediakan alias model di atas.

## MCP servers yang saya pakai

| MCP | Fungsi |
|---|---|
| `context7` | Dokumentasi library/framework up-to-date (remote, streamable HTTP `https://mcp.context7.com/mcp`) |
| `camofox-browser` | Browser anti-detect untuk scraping/web berbot-detection |
| `codegraph` | Code knowledge graph pre-index (Rust kernel, auto-sync watcher, `codegraph serve --mcp`) — pengganti graphify |
| `github` | GitHub API (PR, issue, repo) |
| `memory` | Knowledge graph memori jangka panjang |
| `filesystem` | Akses file terbatas direktori proyek |
| `headroom` | Kompresi/ringkas konteks (`headroom.EXE mcp serve`) |

> Dihapus: `graphify` + `serena` (diganti `codegraph`), `framer`, `tradingview` (niche, jarang dipakai), `playwright` + `chrome-devtools` (overlap browser — cukup `camofox-browser`).
>
> Reinstall `serena` bila butuh edit/navigasi live via LSP (1 blok JSON di `mcp`):
> ```json
> "serena": { "type": "local", "command": ["uvx", "--from", "serena-agent", "serena", "start-mcp-server", "--project-from-cwd", "--context", "agent", "--open-web-dashboard", "False"], "enabled": true }
> ```

> Catatan Windows: command local MCP pakai `npx.cmd` (bukan `npx`) — spawn `.cmd` langsung sering menyebabkan `Operation timed out after 30000ms`.

## Lisensi

**CC BY-NC-ND 4.0** — lihat [LICENSE](LICENSE). Intinya: bebas dilihat, dibagikan verbatim, dan dipelajari sebagai referensi non-komersial **dengan atribusi**; dilarang modifikasi/karya turunan. Komponen pihak ketiga (cybersecurity pack: Apache 2.0; folder `agents/`: community pack) tetap mengikuti lisensi aslinya.
