# Analisis Komparasi Compact: Mengatasi Double-Bluff & Overengineering CTF

Dokumen ini membedah komparasi objektif antara pendekatan **Compact 1 (Sebelumnya)** vs **Compact 2 (Terbaru)** saat menghadapi tantangan Forensics `browto (1)/History`.

---

## 1. Kronologi Soal & Anatomi Jebakan (Double-Bluff)

Pada SQLite History browser Chromium, author sengaja menanam perangkap psikologis bertingkat:
1. **Lapis 1 (Plain Text URL & Title):**
   - URL: `https://paste.invalid/raw/ITECHNO%7Breadable_history_is_a_decoy%7D`
   - Title: `draft flag ITECHNO26{NARO HELM HATI HATI KALO DI PARKIRAN, DISUATU MASA ADA SUATU KAMPUS DI VENEZUELA KETIKA MAHASISWANYA INGIN MENDEMO PEMERINTAHNYA DEMONSTRAN ITU SENDIRI MALAH MALING HELM DI PARKIRAN KAMPUSNYA DENGAN ALASAN NGELINDUNGIN PALA SAMPE SEKARANG BLOM BALIK TUH HELM, UNTUNG AJA BUKAN DI NEGERI INI}`
2. **Lapis 2 (Decoy Teknis & Matematis):**
   - File download `flag.txt` berukuran persis **41 byte** dengan hash SHA-256 `0a6534106cc421d2c9b60b69fec02ab71bb83825e50f791fc66d210c6c023c92`.
   - Blob biner terenkripsi 98.273 byte dengan `payload_png_sha256` di tabel metadata (key 31337).
   - 179 timestamp sisa mikrodetik modulo 1000 dan 9 bucket cache freshness Base32.

Tujuan author: Membuat AI atau peserta mengira bahwa flag di URL/Title hanyalah *decoy* palsu, lalu memaksa peserta masuk *rabbit-hole* kriptografi yang membutuhkan brute-force SHA-256 tanpa wordlist (mustahil selesai dalam waktu 5 jam).

---

## 2. Perbandingan Head-to-Head

| Parameter | Compact 1 (Sebelumnya) | Compact 2 (Terbaru) | Keunggulan Compact 2 |
|---|---|---|---|
| **Waktu Menemukan Kandidat** | 10 detik via `strings` | **1.9 ms** via regex engine | Deteksi instan tanpa delay |
| **Respon Terhadap Label 'Decoy'** | Terjebak overengineering, menduga palsu | **Abaikan label troll**, tetapkan sebagai Candidate #1 | Kebal terhadap trik psikologis author |
| **Aksi Terhadap Lapis 2** | Menghabiskan 13-17 menit membedah PNG, hash SHA-256, & timestamp | **DILARANG** membedah biner sekunder sebelum kandidat #1 di-reject | Menghemat 95% waktu dan token |
| **Alur Eksekusi Flag** | Otomatis langsung menulis writeup sebelum submit | **SUBMIT DULU KE USER** -> tunggu `valid` atau `reject` | Menghindari pembuatan writeup untuk flag palsu |
| **Pembuatan Writeup** | Otomatis dan prematur | **Post-Validation** (hanya dibuat setelah user mengonfirmasi `valid`) | Dokumentasi rapi dan terarah |
| **Durasi Total** | **00:13:42 s/d 17:00 menit** | **< 30 detik total turn-around** | Efisiensi melonjak drastis |

---

## 3. Matriks Keputusan Final (Taktik Anti-Double-Bluff)

```text
[Input Target Soal]
        │
        ▼
[Recon Strings & DB Pattern]
        │
        ├─► Ditemukan regex `ITECHNO26{...}`?
        │        │
        │        ├─► [YA] ──► Masukkan ke CANDIDATE QUEUE (Rank #1)
        │        │             │
        │        │             ├─► Tampilkan ke User: "SUBMIT CANDIDATE #1 DULU"
        │        │             ├─► STOP! Jangan sentuh blob biner / SHA-256.
        │        │             │
        │        │             ├─► User balas "valid" ──► TULIS WRITEUP RESMI ──► SELESAI
        │        │             └─► User balas "reject" ──► PIVOT KE CANDIDATE #2 / DECODE
        │        │
        │        └─► [TIDAK] ──► Lanjutkan Pipeline Recon Standar (ctf-recon.sh -> Auto Skill)
```

---

## 4. Kesimpulan Evaluasi

Pendekatan **Compact 2 dengan prinsip Flag-First & Writeup Tunda** mengeliminasi kelemahan overengineering tanpa menghilangkan kemampuan agen untuk melakukan pivot teknis jika kandidat pertama memang benar-benar ditolak platform CTF.
