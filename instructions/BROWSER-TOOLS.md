# Pemilihan Tool Browser (per situasi)

opencode punya TIGA tool browser MCP yang saling melengkapi. Pilih sesuai konteks tugas — jangan asal.

| Situasi | Tool | Cara pakai |
|---|---|---|
| **Scraping / browsing** publik, situs anti-bot (Cloudflare/Google), login-gated, ambil data cepat, snapshot token-efficient | **`camofox_*`** | `camofox_create_tab` → `camofox_snapshot` → `camofox_click`/`camofox_type` → `camofox_evaluate` |
| **E2E testing** (assert, wait, trace, CI) | **playwright** `browser_*` | `browser_navigate` + assertions + trace viewer |
| **Debug dalam / CDP** (inspect element, network, profiling) | **`chrome-devtools_*`** | snapshot/evaluate/network devtools |

## Aturan prioritas
1. Scraping / browsing web → **`camofox_*`** (anti-detection + token-efficient).
2. E2E test otomatis → **playwright** `browser_*`.
3. Debug browser dalam / devtools / profiling → **`chrome-devtools_*`**.
4. Kalau ragu antara camofox vs playwright untuk browsing: pilih **camofox_**.

## Catatan
- camofox berbasis Camoufox (Firefox anti-detection), server di port 9377. Snapshot pakai element ref (`e1`, `e2`).
- playwright untuk testing — bukan buat scraping anti-bot.
- chrome-devtools untuk inspeksi manual / devtools.
