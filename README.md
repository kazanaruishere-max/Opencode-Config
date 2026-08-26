# Opencode-Config

Backup & restore kit untuk setup [opencode](https://opencode.ai) saya — charter (AGENTS.md), instructions, skills, commands, prompts, docs, dan struktur config. **Tanpa MCP & provider** — keduanya didokumentasikan di README ini saja, jadi kamu bebas pakai provider/MCP versimu sendiri.

## Struktur

```
├── opencode.json        # config inti TANPA mcp & provider
├── AGENTS.md            # Expert Operating Charter + Blok Accountability (WAJIB)
├── instructions/        # aturan always-on (INSTRUCTIONS, BROWSER-TOOLS, PUTERJS, NO-SLOP)
├── commands/            # slash commands (/plan, /tdd, /verify, ...)
├── prompts/             # prompt template subagent (planner, reviewer, dll)
├── agents/              # ~232 subagent definition project-level (.md, community pack)
├── skills/              # skill kurasi (tdd-workflow, security-review, graphify, no-ai-slop, ...)
├── skills-custom/ctf/   # 8 skill CTF Miscellaneous custom (MIT) — taruh ke folder cybersecurity pack
└── docs/cybersecurity-catalog.md  # katalog 188 skill cybersecurity + workflow per kategori
```

## Restore

1. Clone repo ini, copy seluruh isi ke `~/.config/opencode/` (Windows: `C:\Users\<kamu>\.config\opencode\`).
2. Pasang provider sendiri (lihat section **Providers** di bawah) — config mereferensikan model di bawah provider ID `9router`.
3. (Opsional) Install 180 skill cybersecurity:
   ```bash
   git clone https://github.com/mukul975/Anthropic-Cybersecurity-Skills ~/.agents/skills/cybersecurity
   ```
   lalu copy isi `skills-custom/ctf/` ke dalamnya.
4. Restart opencode → cek `opencode mcp list` (kalau pasang MCP dari README) dan `/models`.

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
| `graphify` | Knowledge graph codebase berbasis AST (`graphify-out/graph.json`) |
| `playwright` | E2E testing & browser automation |
| `github` | GitHub API (PR, issue, repo) |
| `memory` | Knowledge graph memori jangka panjang |
| `filesystem` | Akses file terbatas direktori proyek |
| `chrome-devtools` | Debug browser via CDP |
| `framer` | Integrasi desain Framer |
| `tradingview` | Hook TradingView via Chrome debug port |

> Catatan Windows: command local MCP pakai `npx.cmd` (bukan `npx`) — spawn `.cmd` langsung sering menyebabkan `Operation timed out after 30000ms`.

## Lisensi

Config & tulisan pribadi — bebas dipakai sebagai referensi. Skill pihak ketiga mengikuti lisensi masing-masing (cybersecurity pack: Apache 2.0; ctf-* custom: MIT). Folder `agents/` adalah community pack — restore dengan menyalinnya ke `.opencode/agents/` di project kamu.
