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

# --- BINARY / ELF / PE / PWN / REVERSE (deep deterministic) ---
if [[ "$FILE_TYPE" =~ (elf|executable|pe32|shared\ object) ]]; then
    echo -e "\n[+] Binary Detected -> Pwn / Reverse Analysis"
    if command -v checksec &>/dev/null; then
        echo "--- checksec ---"
        checksec --file="$TARGET" || true
    fi
    echo "--- Go / Rust / UPX / .NET Fingerprint ---"
    strings -a "$TARGET" 2>/dev/null | grep -E "go1\.|runtime\.pclntab|start_gopanic|\.gopclntab|rust_panic|\.rustc|UPX!|CLR Metadata|mscorlib" | head -n 10 || echo "[-] No Go/Rust/UPX/.NET marker"
    readelf -S "$TARGET" 2>/dev/null | grep -E "gopclntab|rustc|upx" | head -n 5 || true
    upx -t "$TARGET" 2>&1 | head -n 2 || true
    echo "--- Dynamic Libraries ---"
    ldd "$TARGET" 2>/dev/null || true
    echo "--- Anti-Debug / VM Strings ---"
    strings -n 6 "$TARGET" 2>/dev/null | grep -Ei "(ptrace|isDebugger|rdtsc|cpuid|anti.?debug|vmware|vbox)" | head -n 10 || echo "[-] No anti-debug marker"
    echo "--- Suspicious Strings / Symbols (top 15) ---"
    strings -n 8 "$TARGET" | grep -Ei "(system|sh|bin|flag|pass|admin|secret|debug|ptrace|fork|canary|tcache)" | head -n 15 || true
    echo "--- Entry Point / Architecture ---"
    readelf -h "$TARGET" 2>/dev/null | grep -Ei "(class|machine|entry)" || true
    echo "--- Seccomp / RELRO / Heap Hints ---"
    strings -n 6 "$TARGET" 2>/dev/null | grep -Ei "(seccomp|prctl|__libc_start|malloc|free|tcache|fastbin)" | head -n 10 || echo "[-] No seccomp/heap marker"
    if command -v seccomp-tools &>/dev/null; then seccomp-tools dump "$TARGET" 2>&1 | head -n 20 || true; fi
    echo "--- ROP / Libc Hint ---"
    if command -v ROPgadget &>/dev/null; then ROPgadget --binary "$TARGET" 2>&1 | head -n 5 || true; fi
    ldd "$TARGET" 2>/dev/null | grep -Ei "libc" | head -n 1 || true
    echo "--- PWN Chain Suggestion ---"
    echo "[*] Use: checksec → leak canary/PIE/libc via fmt %p if needed → cyclic offset → ROP/one_gadget → flag"
fi
# --- APK / DEX / iOS / RANSOMWARE HINTS (outside ELF block) ---
if [[ "$TARGET" == *.apk ]] || file "$TARGET" 2>/dev/null | grep -qi "zip"; then
    unzip -l "$TARGET" 2>/dev/null | grep -E "classes\.dex|AndroidManifest" | head -n 5 || true
fi
if file "$TARGET" 2>/dev/null | grep -qi "Mach-O\|iOS"; then
    echo "--- iOS/Mach-O hint ---"
    strings -n 6 "$TARGET" 2>/dev/null | grep -E "objc_msgSend|Frida" | head -n 5 || true
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

# --- TEXT / CRYPTO / ENCODINGS (deterministic fingerprint → no generic brute) ---
if [[ "$FILE_TYPE" =~ (text|ascii|data|openssl) ]]; then
    echo -e "\n[+] Text / Data Detected -> Crypto / Encoding Chains (no brute before fingerprint)"
    echo "--- Sample (first 5 lines) ---"
    head -n 5 "$TARGET" 2>/dev/null || true
    echo "--- Entropy / Charset ---"
    head -c 512 "$TARGET" | tr -dc 'a-zA-Z0-9+/=' | wc -c | awk '{print "[*] Base64-like bytes in first 512b: " $1}'
    if command -v python3 &>/dev/null; then
        python3 - "$TARGET" << 'PY' 2>/dev/null | head -n 20 || true
import re, sys, math
p=sys.argv[1]
t=open(p,'rb').read(4096).decode(errors='ignore')
# RSA/ECDSA/AES hint
hints=[]
if re.search(r'\bn\s*=\s*0x|\be\s*=\s*\d|BEGIN (RSA|PUBLIC) KEY', t): hints.append("RSA params → Coppersmith/Wiener/GCD")
if re.search(r'ecdsa|nonce.*reuse|r\s*=\s*0x', t, re.I): hints.append("ECDSA nonce reuse → priv recover")
if re.search(r'AES|ECB|CBC|padding oracle|iv\s*=', t, re.I): hints.append("Block cipher → padding oracle/nonce reuse")
if re.search(r'LCG|MT19937|seed|prng', t, re.I): hints.append("PRNG predict → mtp/lcg")
if hints:
    print("[*] Crypto hints:"); [print("  -", h) for h in hints]
else: print("[-] No strong crypto family marker in 4KB sample")
PY
    fi
    echo "--- Quick Base64/hex/zlib probe (30s only if hint) ---"
    python3 -c "import base64,sys; d=open(sys.argv[1],'rb').read(600); 
try: print(base64.b64decode(d[:200]).hex()[:80])
except: print('[-] not raw base64')" "$TARGET" 2>/dev/null | head -n 5 || true
fi
echo "--- MISC Chain Entropy Probe ---"
if file "$TARGET" 2>/dev/null | grep -Eq "text|ASCII|data"; then
    ent=$(python3 -c "import collections,math; d=open('$TARGET','rb').read(2048); c=collections.Counter(d); print(sum(-v/len(d)*math.log2(v/len(d)) for v in c.values()) if d else 0)" 2>/dev/null || echo "0")
    echo "[*] Entropy (2048b): $ent — >7.5 likely encoded/encrypted → try ctf-encoding-decoding-chains"
fi
echo "--- Forensics Deep Hint (if .raw/.E01/.evtx/.hive/.sqlite) ---"
case "$TARGET" in
    *.raw|*.mem|*.dmp) echo "[*] Memory dump → vol windows.{pslist→pstree→malfind→cmdline}" ;;
    *.E01|*.dd|*.img) echo "[*] Disk image → autopsy + MFTECmd + fls/icat" ;;
    *.evtx) echo "[*] EVTX → Hayabusa/Chainsaw + log2timeline" ;;
    *.hive|*NTUSER*|*SAM|*SYSTEM) echo "[*] Registry hive → RECmd/RegRipper → autostart/USB MRU" ;;
    *History*|*Cookies*|*Login*) echo "[*] Browser artifact → Hindsight/sqlite WAL + strings latin1" ;;
esac
echo "--- OSINT Hint (if domain/email/username artifact) ---"
if echo "$TARGET" | grep -Eq "@|[a-z0-9.-]+\.[a-z]{2,}$"; then echo "[*] OSINT artefact → dnstwist/subfinder/theHarvester + Shodan (4m time-box)"; fi
echo "--- AI Prompt/Model Hint (if prompt/system file) ---"
if grep -Eqi "system prompt|ignore previous|jailbreak|llm|vector store|FAISS|Chroma" "$TARGET" 2>/dev/null; then echo "[*] AI prompt/model file → prompt-injection/garak/PyRIT (4m time-box)"; fi

echo "================================================================="
