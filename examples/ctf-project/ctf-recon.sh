#!/usr/bin/env bash
# ==============================================================================
# ctf-recon.sh: Automated 30-Second Fingerprint Engine for CTF Artifacts
# Output is structured to map directly into 188 Anthropic Cybersecurity Skills.
# ==============================================================================

set -uo pipefail

TARGET="${1:-}"

if [[ -z "$TARGET" ]]; then
    echo "[!] Usage: $0 <file-or-url>"
    exit 1
fi

echo "==================== [CTF RECON FINGERPRINT] ===================="
echo "[*] Target: $TARGET"
echo "[*] Timestamp: $(date -u '+%Y-%m-%d %H:%M:%S UTC')"

# --- WEB TARGET (--web flag for deep credential-harvest WAF-aware) ---
if [[ "$TARGET" =~ ^https?:// ]]; then
    echo -e "\n[+] Type: WEB SERVICE (html/css source-first + WAF-aware)"
    echo "--- HTTP Headers ---"
    curl -sIL "$TARGET" --max-time 5 | head -n 30 || true
    echo "--- View-Source & Hidden Credentials ---"
    page=$(curl -sL "$TARGET" --max-time 5 || true)
    echo "$page" | grep -Eio "(hidden|password|pw|value=|ITECHNO26|flag|localStorage|token|api_key)" | head -n 20 || true
    echo "--- Technology / Server Fingerprint ---"
    echo "$page" | grep -Ei "(powered by|server|framework|csrf|cookie|api)" | head -n 10 || true
    echo "--- Endpoint Discovery (robots/.git/backup) ---"
    base=$(echo "$TARGET" | sed -E 's#(https?://[^/]+).*#\1#')
    for p in "/robots.txt" "/.git/HEAD" "/backup.zip" "/.env" "/.bak"; do
        code=$(curl -s -o /dev/null -w "%{http_code}" "$base$p" --max-time 3 || true)
        echo "  $base$p -> $code"
    done
    echo "--- Gmail / ITECHNO26 / Password Scan ---"
    echo "$page" | grep -Eio "[a-z0-9._%+-]+@gmail\.com|ITECHNO26\{[^}]{10,400\}}" | head -n 20 || true
    echo "================================================================="
    exit 0
fi

# --- LOCAL FILE TARGET ---
if [[ ! -e "$TARGET" ]]; then
    echo "[-] File does not exist: $TARGET"
    exit 1
fi

echo "--- Basic Identification ---"
file "$TARGET" || true
ls -lh "$TARGET"

echo -e "\n--- Flag Pre-Check (Low-Hanging Fruit) ---"
grep -Erai "ITECHNO26\{|flag\{|FLAG\{" "$TARGET" 2>/dev/null | head -n 5 || echo "[-] No cleartext flag match found in file."

FILE_TYPE=$(file "$TARGET" | tr '[:upper:]' '[:lower:]')

# --- BINARY / ELF / PE / PWN / REVERSE ---
if [[ "$FILE_TYPE" =~ (elf|executable|pe32|shared\ object) ]]; then
    echo -e "\n[+] Binary Detected -> Pwn / Reverse Analysis"
    if command -v checksec &>/dev/null; then
        echo "--- checksec ---"
        checksec --file="$TARGET" || true
    fi
    echo "--- Dynamic Libraries ---"
    ldd "$TARGET" 2>/dev/null || true
    echo "--- Suspicious Strings / Symbols (top 15) ---"
    strings -n 8 "$TARGET" | grep -Ei "(system|sh|bin|flag|pass|admin|secret|debug|ptrace|fork|canary|tcache)" | head -n 15 || true
    echo "--- Entry Point / Architecture ---"
    readelf -h "$TARGET" 2>/dev/null | grep -Ei "(class|machine|entry)" || true
fi

# --- ARCHIVES / COMPRESSED FILES ---
if [[ "$FILE_TYPE" =~ (zip|tar|gzip|bzip2|7-zip|rar) ]]; then
    echo -e "\n[+] Archive Detected -> CTF-Archive-Cracking / Forensics"
    binwalk "$TARGET" 2>/dev/null | head -n 20 || true
fi

# --- IMAGES / AUDIO / MEDIA ---
if [[ "$FILE_TYPE" =~ (jpeg|png|gif|bitmap|wav|mp3|riff|audio) ]]; then
    echo -e "\n[+] Media Detected -> Steganography / Metadata Analysis"
    if command -v exiftool &>/dev/null; then
        echo "--- Metadata ---"
        exiftool "$TARGET" | grep -Ei "(comment|description|author|software|create|warning)" | head -n 15 || true
    fi
    if command -v zsteg &>/dev/null && [[ "$FILE_TYPE" =~ (png|bmp) ]]; then
        echo "--- zsteg Quick Scan ---"
        zsteg -a "$TARGET" 2>/dev/null | grep -Ei "(ITECHNO26|flag|text)" | head -n 5 || true
    fi
fi

# --- DOCUMENTS / PDF / OFFICE ---
if [[ "$FILE_TYPE" =~ (pdf|microsoft|composite) ]]; then
    echo -e "\n[+] Document Detected -> Forensics / Macro Analysis"
    if command -v pdfid &>/dev/null; then
        pdfid "$TARGET" 2>/dev/null || true
    fi
fi

# --- TEXT / CRYPTO / ENCODINGS ---
if [[ "$FILE_TYPE" =~ (text|ascii|data) ]]; then
    echo -e "\n[+] Text / Data Detected -> Crypto / Encoding Chains"
    echo "--- Sample (first 5 lines) ---"
    head -n 5 "$TARGET" 2>/dev/null || true
    echo "--- Entropy / Character Set Check ---"
    head -c 512 "$TARGET" | tr -dc 'a-zA-Z0-9+/=' | wc -c | awk '{print "[*] Base64-like bytes in first 512b: " $1}'
fi

echo "================================================================="
