# Cybersecurity Skills Catalog

Source: https://github.com/mukul975/Anthropic-Cybersecurity-Skills — 180 base + 8 CTF Misc custom = 188 skills, auto-discovered via `skills.paths`.
Invoke: `skill://<n>` | Base: Apache 2.0 | Custom CTF: MIT.

Total: 188 skills — Cryptography 13, Web Exploitation 42, Reverse Engineering 17, Digital Forensics 33, PWN / Binary Exploitation 7, OSINT / Recon 22, Network / Misc 12, Miscellaneous (CTF) 8, AI Jailbreak / AI Security 14, Bonus: AD / PrivEsc 10, Bonus: Exploit Frameworks 3, Other / Unclassified 7.

> Workflow CTF: Soal (Web/PDF) -> opencode (baca skill -> generate command) -> Kali Linux (eksekusi). Batasan: authorized CTF/lab only.

## Workflow per Kategori (Operasional)

| # | Kategori Kompetisi | Skill Utama | Tools Kali | Langkah |
|---|---|---|---|---|
| 1 | Cryptography | hash-cracking, aes-encryption, rsa-key, jwt-* | hashcat, openssl, jwt_tool | Klasifikasi cipher → pilih skill → generate decrypt/command → run Kali → validasi flag |
| 2 | Web Exploitation | sql-injection, xss, ssrf, idor, graphql-* | burpsuite, sqlmap, curl | Recon endpoint → load skill → craft payload → run Kali → capture flag |
| 3 | Reverse Engineering | ghidra, jadx, dnspy, frida, apktool | ghidra, jadx, frida | Load binary → skill → decompile/trace → extract flag |
| 4 | Digital Forensics | volatility3, autopsy, binwalk, volatility, plaso | volatility, autopsy, binwalk | Acquire image → skill → parse artifacts → reconstruct timeline → flag |
| 5 | PWN | binary-exploitation, fuzzing-afl, rootkit-* | pwntools, gdb, ROPgadget | Analyze binary → skill → craft exploit → run Kali → flag |
| 6 | OSINT | spiderfoot, subfinder, shodan, theHarvester | spiderfoot, subfinder, maltego | Recon target → skill → correlate OSINT → flag |
| 7 | Miscellaneous | ctf-encoding-*, ctf-scripting-*, ctf-qr-*, ctf-esolang-*, ctf-audio-*, ctf-traffic-*, ctf-archive-*, ctf-metadata-* | python, zbarimg, sox, 7z, exiftool | Klasifikasi puzzle → ctf-* skill → generate solver → run Kali → flag |
| 8 | AI Jailbreak | garak, pyrit, promptfoo, guardrails | garak, promptfoo | Load LLM target → skill → red-team → extract flag |

## Quick lookup
```
ls ~/.agents/skills/cybersecurity/
```

## Cryptography (13)

| Skill | Description |
|---|---|
| configuring-tls-1-3-for-secure-communications | Configures TLS 1.3 (RFC 8446) on servers, covering cipher suite and |
| exploiting-jwt-algorithm-confusion-attack | >- |
| implementing-aes-encryption-for-data-at-rest | Guides implementing AES-256 encryption in GCM mode (FIPS 197) for files and data stores at rest, covering key derivation, IV/nonce management, and authenticated encryption. Use when deploying or configuring encryption for data at rest, e... |
| implementing-digital-signatures-with-ed25519 | Implements digital signatures using the Ed25519 algorithm (Curve25519), covering key-pair generation, signing, signature verification, and security tradeoffs versus RSA and ECDSA. Use when adding message or artifact signing and authentic... |
| implementing-envelope-encryption-with-aws-kms | Implements envelope encryption with AWS KMS, encrypting data locally with a data encryption key (DEK) and protecting that DEK with a KMS-managed key (KEK), covering the encrypt/decrypt flow, KMS key types, and security validation criteri... |
| implementing-jwt-signing-and-verification | >- |
| implementing-rsa-key-pair-management | Generates, stores, rotates, and manages RSA key pairs following NIST |
| performing-cryptographic-audit-of-application | A cryptographic audit systematically reviews an application's use of |
| performing-hash-cracking-with-hashcat | Cracks password hashes with Hashcat, covering hash-type identification, |
| performing-jwt-none-algorithm-attack | Execute and test the JWT none algorithm attack, crafting tokens with |
| performing-ssl-stripping-attack | >- |
| performing-ssl-tls-security-assessment | >- |
| testing-jwt-token-security | Assessing JSON Web Token implementations for cryptographic weaknesses, |

## Web Exploitation (42)

| Skill | Description |
|---|---|
| bypassing-authentication-with-forced-browsing | Discovering and accessing unprotected pages, APIs, and administrative |
| exploiting-api-injection-vulnerabilities | >- |
| exploiting-broken-function-level-authorization | >- |
| exploiting-broken-link-hijacking | >- |
| exploiting-deeplink-vulnerabilities | Tests and exploits deep link (URL scheme and App Link) vulnerabilities |
| exploiting-excessive-data-exposure-in-api | >- |
| exploiting-http-request-smuggling | >- |
| exploiting-idor-vulnerabilities | >- |
| exploiting-insecure-deserialization | Identifying and exploiting insecure deserialization vulnerabilities in |
| exploiting-mass-assignment-in-rest-apis | >- |
| exploiting-nosql-injection-vulnerabilities | Detects and exploits NoSQL injection vulnerabilities in MongoDB, CouchDB, |
| exploiting-oauth-misconfiguration | Identifying and exploiting OAuth 2.0 and OpenID Connect misconfigurations |
| exploiting-prototype-pollution-in-javascript | Detects and exploits JavaScript prototype pollution vulnerabilities |
| exploiting-race-condition-vulnerabilities | Detects and exploits race condition (TOCTOU) vulnerabilities in web |
| exploiting-sql-injection-vulnerabilities | Identifies and exploits SQL injection vulnerabilities in web applications |
| exploiting-sql-injection-with-sqlmap | Detecting and exploiting SQL injection vulnerabilities using sqlmap to |
| exploiting-template-injection-vulnerabilities | Detects and exploits Server-Side Template Injection (SSTI) vulnerabilities |
| exploiting-type-juggling-vulnerabilities | Exploits PHP type juggling vulnerabilities caused by loose (==) comparison |
| exploiting-websocket-vulnerabilities | Testing WebSocket implementations for authentication bypass, cross-site |
| performing-blind-ssrf-exploitation | Detect and exploit blind Server-Side Request Forgery (SSRF) using out-of-band |
| performing-clickjacking-attack-test | Testing web applications for clickjacking vulnerabilities by assessing |
| performing-content-security-policy-bypass | Analyze Content-Security-Policy headers and bypass them to achieve cross-site |
| performing-csrf-attack-simulation | Testing web applications for Cross-Site Request Forgery vulnerabilities |
| performing-directory-traversal-testing | Test web applications for path traversal and Local/Remote File Inclusion |
| performing-graphql-depth-limit-attack | Execute and test GraphQL depth limit attacks using deeply nested recursive |
| performing-graphql-introspection-attack | Performs GraphQL introspection attacks that extract the full API schema |
| performing-graphql-security-assessment | Assessing GraphQL API endpoints for introspection leaks, injection attacks, |
| performing-http-parameter-pollution-attack | Executes HTTP Parameter Pollution attacks that inject duplicate request |
| performing-second-order-sql-injection | Detect and exploit second-order SQL injection vulnerabilities where malicious |
| performing-ssrf-vulnerability-exploitation | >- |
| performing-web-cache-deception-attack | Executes web cache deception attacks by exploiting path normalization |
| performing-web-cache-poisoning-attack | Exploiting web cache mechanisms to serve malicious content to other users |
| testing-api-for-mass-assignment-vulnerability | Tests APIs for mass assignment (auto-binding), OWASP API3:2023, by identifying |
| testing-cors-misconfiguration | Identifying and exploiting Cross-Origin Resource Sharing misconfigurations |
| testing-for-broken-access-control | Systematically tests web applications and APIs for broken access control |
| testing-for-open-redirect-vulnerabilities | Identifies and exploits open redirect vulnerabilities by analyzing URL |
| testing-for-sensitive-data-exposure | Identifying sensitive data exposure vulnerabilities including API key |
| testing-for-xss-vulnerabilities | Tests web applications for reflected, stored, and DOM-based Cross-Site |
| testing-for-xss-vulnerabilities-with-burpsuite | Identifying and validating cross-site scripting vulnerabilities using |
| testing-for-xxe-injection-vulnerabilities | Discovering and exploiting XML External Entity injection vulnerabilities |
| testing-oauth2-implementation-flaws | Tests OAuth 2.0 and OpenID Connect implementations for authorization code |
| testing-websocket-api-security | Tests WebSocket API implementations for missing upgrade-handshake authentication, |

## Reverse Engineering (17)

| Skill | Description |
|---|---|
| analyzing-android-malware-with-apktool | Perform static analysis of Android APK malware using apktool for resource decompilation, jadx for Java source recovery, and androguard for manifest inspection, dangerous permission-combination detection, and identification of obfuscated ... |
| analyzing-golang-malware-with-ghidra | Reverse engineer Go-compiled malware in Ghidra by parsing Go buildinfo |
| analyzing-linux-elf-malware | Analyze malicious Linux ELF binaries — botnets, cryptominers, ransomware, |
| analyzing-macro-malware-in-office-documents | Analyzes malicious VBA macros embedded in Microsoft Office documents |
| analyzing-malicious-pdf-with-peepdf | Perform static analysis of malicious PDF documents using peepdf, pdfid, |
| analyzing-packed-malware-with-upx-unpacker | Identifies and unpacks UPX-packed malware samples, including binaries with modified UPX magic bytes or headers that block automated decompression, to recover the original executable for static analysis. Use when a sample shows high entro... |
| performing-android-app-static-analysis-with-mobsf | Performs automated static analysis of Android applications using Mobile |
| performing-binary-exploitation-analysis | Analyze ELF binaries for memory-corruption vulnerabilities and build proof-of-concept |
| performing-dynamic-analysis-of-android-app | Performs runtime dynamic analysis of Android applications using Frida, |
| performing-dynamic-analysis-with-any-run | Perform interactive dynamic malware analysis using the ANY.RUN cloud sandbox |
| performing-static-malware-analysis-with-pe-studio | >- |
| reverse-engineering-android-malware-with-jadx | Reverse engineers malicious Android APK files using the JADX decompiler |
| reverse-engineering-dotnet-malware-with-dnspy | Reverse engineers .NET malware samples using the dnSpy decompiler and |
| reverse-engineering-ios-app-with-frida | Reverse engineers iOS applications using Frida dynamic instrumentation |
| reverse-engineering-malware-with-ghidra | Reverse engineers malware binaries using NSA''s Ghidra disassembler and |
| reverse-engineering-ransomware-encryption-routine | Reverse engineer ransomware encryption routines to identify cryptographic |
| reverse-engineering-rust-malware | Reverse engineers Rust-compiled malware using IDA Pro and Ghidra, covering |

## Digital Forensics (33)

| Skill | Description |
|---|---|
| acquiring-disk-image-with-dd-and-dcfldd | Create forensically sound bit-for-bit disk images with dd or dcfldd on a Linux forensic workstation, preserving evidence integrity through hash verification (MD5/SHA) during acquisition. Use when imaging a suspect drive, USB device, or m... |
| analyzing-browser-forensics-with-hindsight | Parse Chromium-based browser databases with Hindsight to extract and correlate browsing history, downloads, cookies, cached content, autofill data, saved passwords, and extensions from Chrome, Edge, Brave, Opera, and Vivaldi into a unifi... |
| analyzing-disk-image-with-autopsy | Perform comprehensive forensic analysis of raw (dd), E01, or AFF disk images with Autopsy and The Sleuth Kit, recovering deleted files, examining metadata and embedded artifacts, keyword searching, and building investigation timelines wi... |
| analyzing-lnk-file-and-jump-list-artifacts | Analyze Windows LNK shortcut files and Jump List artifacts with LECmd, |
| analyzing-memory-dumps-with-volatility | Analyzes RAM memory dumps from compromised systems using the Volatility framework to identify malicious processes, |
| analyzing-memory-forensics-with-lime-and-volatility | Performs Linux memory acquisition using LiME (Linux Memory Extractor) |
| analyzing-mft-for-deleted-file-recovery | Analyze the NTFS Master File Table ($MFT) with MFTECmd, analyzeMFT, |
| analyzing-network-packets-with-scapy | Use Scapy to craft, send, sniff, and dissect TCP/UDP/ICMP/DNS packets, analyze pcap files, implement SYN scans, and detect anomalous traffic such as fragmented or malformed packets. Use when performing authorized network reconnaissance, ... |
| analyzing-outlook-pst-for-email-forensics | Parse Microsoft Outlook PST and OST files using libpff and pst-utils to extract message content, headers, attachments, deleted items, and MAPI metadata, including recovery of items from the Recoverable Items folder. Use when conducting e... |
| analyzing-prefetch-files-for-execution-history | Parse Windows Prefetch files (versions 17, 23, 26, 30) with tools like PECmd, WinPrefetchView, or python-prefetch to determine program execution history, including run counts, execution timestamps, and referenced files/DLLs. Use when bui... |
| analyzing-slack-space-and-file-system-artifacts | Examine NTFS slack space, MFT entries, the USN Change Journal, and Alternate Data Streams (ADS) to recover hidden or residual data, reconstruct deleted-file metadata, and reconstruct available file-system change activity from USN records... |
| analyzing-usb-device-connection-history | Correlate Windows registry keys (USBSTOR, MountedDevices), Event Logs, |
| analyzing-windows-amcache-artifacts | Parses the Windows Amcache.hve registry hive with Eric Zimmerman''s |
| analyzing-windows-lnk-files-for-artifacts | Parse Windows LNK shortcut files to extract target paths, MAC timestamps, |
| analyzing-windows-prefetch-with-python | Parse Windows Prefetch (.pf) files with the windowsprefetch Python |
| analyzing-windows-registry-for-artifacts | Extract and analyze Windows Registry hives with tools like RegRipper |
| analyzing-windows-shellbag-artifacts | Analyze Windows Shellbag (BagMRU) registry artifacts with SBECmd and |
| building-super-timelines-with-plaso | Generate forensic super-timelines with Plaso's log2timeline.py, pinfo.py, |
| conducting-memory-forensics-with-volatility | Performs memory forensics analysis using Volatility 3 to extract evidence |
| extracting-browser-history-artifacts | Extracts and analyzes browser history, cookies, cache, downloads, and |
| extracting-credentials-from-memory-dump | Extracts cached credentials, password hashes, Kerberos tickets, and |
| extracting-memory-artifacts-with-rekall | Uses Rekall memory forensics framework to analyze memory dumps for process |
| extracting-windows-event-logs-artifacts | Extract, parse, and analyze Windows Event Logs (EVTX) using Chainsaw, |
| generating-forensic-timelines-with-hayabusa | Run Hayabusa against collected Windows EVTX files to apply Sigma detection rules and produce a prioritized, chronological CSV/JSON timeline with severity levels, MITRE ATT&CK mappings, and per-host/per-Event-ID metrics. Use during DFIR t... |
| parsing-artifacts-with-eric-zimmerman-tools | Parse Windows forensic artifacts—$MFT/$J (MFTECmd), Prefetch (PECmd), registry hives (RECmd), shellbags, and Amcache—into normalized CSV/JSON with Eric Zimmerman's EZ Tools, then load results into Timeline Explorer for analysis. Use duri... |
| performing-disk-forensics-investigation | Conduct disk forensics investigations using forensic imaging, file system |
| performing-file-carving-with-foremost | Recovers files from disk images and unallocated space using Foremost's |
| performing-firmware-extraction-with-binwalk | Performs firmware image extraction and analysis using binwalk to identify |
| performing-log-analysis-for-forensic-investigation | Collect, parse, and correlate system, application, and security logs |
| performing-steganography-detection | >- |
| performing-timeline-reconstruction-with-plaso | >- |
| recovering-deleted-files-with-photorec | Recovers deleted files from disk images and storage media using PhotoRec's |
| triaging-windows-with-kape | Runs KAPE (Kroll Artifact Parser and Extractor) to collect targeted |

## PWN / Binary Exploitation (7)

| Skill | Description |
|---|---|
| analyzing-bootkit-and-rootkit-samples | Analyzes bootkit and advanced rootkit malware infecting the Master |
| analyzing-linux-kernel-rootkits | Detect kernel-level rootkits in Linux memory dumps using Volatility3 |
| detecting-rootkit-activity | Detects rootkit presence on compromised systems by identifying hidden |
| detecting-secure-boot-bypass | Detect UEFI Secure Boot bypasses and bootkits such as BlackLotus and |
| hunting-for-living-off-the-land-binaries | Proactively hunts for adversary abuse of legitimate, signed system binaries |
| hunting-for-lolbins-execution-in-endpoint-logs | Hunts for LOLBins (Living Off the Land Binaries) abuse, mapped to MITRE |
| performing-fuzzing-with-aflplusplus | Performs coverage-guided fuzzing of compiled binaries with AFL++, instrumenting |

## OSINT / Recon (22)

| Skill | Description |
|---|---|
| analyzing-apt-group-with-mitre-navigator | Query ATT&CK data with attackcti, mitreattack-python, and stix2, then build MITRE ATT&CK Navigator layers and multi-layer heatmap overlays mapping one or more APT groups' TTPs for detection-gap analysis. Use to compare threat-actor techn... |
| analyzing-certificate-transparency-for-phishing | Monitor Certificate Transparency logs using crt.sh and Certstream to |
| analyzing-tls-certificate-transparency-logs | Queries Certificate Transparency logs via crt.sh and pycrtsh to detect |
| analyzing-typosquatting-domains-with-dnstwist | Generate domain permutations with dnstwist and check DNS resolution |
| auditing-tls-certificate-transparency-logs | Monitors Certificate Transparency (CT) logs to detect unauthorized certificate |
| building-threat-actor-profile-from-osint | Build threat actor profiles by collecting OSINT from vendor reports, paste sites, dark web forums, social media, and code repos, correlating indicators, mapping adversary infrastructure with tools like Maltego and SpiderFoot, and produci... |
| building-threat-feed-aggregation-with-misp | Deploy MISP via Docker and configure feeds from sources like abuse.ch, AlienVault OTX, and CIRCL to aggregate, correlate, and distribute threat intelligence, including automated feed synchronization and STIX/TAXII-based integration with ... |
| collecting-open-source-intelligence | Collects and synthesizes open-source intelligence (OSINT) about threat |
| conducting-external-reconnaissance-with-osint | Conduct external recon using OSINT techniques to map an organization's external attack surface without touching target systems, gathering DNS records, certificate transparency logs, search results, social media, code repositories, and br... |
| monitoring-darkweb-sources | Monitors dark web forums, marketplaces, paste sites, and ransomware |
| performing-ai-driven-osint-correlation | Use AI/LLM-based reasoning with Sherlock, theHarvester, and SpiderFoot |
| performing-aws-account-enumeration-with-scout-suite | Run the agentless, open-source ScoutSuite tool (via pip install and the `scout` CLI) |
| performing-brand-monitoring-for-impersonation | Monitor for brand impersonation attacks across domains, social media, |
| performing-dark-web-monitoring-for-threats | Dark web monitoring involves systematically scanning Tor hidden services, |
| performing-dns-enumeration-and-zone-transfer | Enumerates DNS records, attempts zone transfers, brute-forces subdomains, |
| performing-ip-reputation-analysis-with-shodan | Analyze IP address reputation using the Shodan API to identify open ports, |
| performing-open-source-intelligence-gathering | Open Source Intelligence (OSINT) gathering is the first active phase |
| performing-osint-with-spiderfoot | Automate OSINT collection with the SpiderFoot REST API and CLI (sf.py/spiderfoot-cli) across 200+ modules, selecting scan modes (footprint, investigate, passive) and parsing results for domains, IPs, emails, leaked credentials, and DNS r... |
| performing-paste-site-monitoring-for-credentials | Monitor paste sites like Pastebin and GitHub Gists for leaked credentials, |
| performing-subdomain-enumeration-with-subfinder | Enumerate subdomains of target domains using ProjectDiscovery's Subfinder |
| profiling-threat-actor-groups | Develops comprehensive threat actor profiles for APT groups, criminal |
| tracking-threat-actor-infrastructure | Discovers and maps adversary-controlled infrastructure (C2 servers, |

## Network / Misc (12)

| Skill | Description |
|---|---|
| analyzing-network-flow-data-with-netflow | Parse NetFlow v9 and IPFIX records to detect volumetric anomalies, port |
| conducting-wireless-network-penetration-test | Conducts authorized wireless network penetration tests to assess the |
| performing-arp-spoofing-attack-simulation | Simulates ARP spoofing/cache-poisoning attacks in authorized lab or |
| performing-bandwidth-throttling-attack-simulation | Simulate bandwidth throttling and network degradation attacks using tc, |
| performing-bluetooth-security-assessment | Assess Bluetooth Low Energy (BLE) device security using Python's bleak asyncio |
| performing-dns-tunneling-detection | Detects DNS tunneling by computing Shannon entropy of DNS query names, |
| performing-packet-injection-attack | Crafts and injects custom network packets using Scapy, hping3, and Nemesis |
| performing-vlan-hopping-attack | >- |
| performing-wifi-password-cracking-with-aircrack | Captures WPA/WPA2 handshakes and performs offline password cracking |
| performing-wireless-network-penetration-test | Execute a wireless network penetration test to assess WiFi security by |
| performing-wireless-security-assessment-with-kismet | Conduct wireless network security assessments using Kismet to detect |
| scanning-network-with-nmap-advanced | Performs advanced network recon using Nmap''s Scripting Engine (NSE), |

## Miscellaneous (CTF) (8)

| Skill | Description |
|---|---|
| ctf-archive-cracking | Crack archives, nested zips, and password-protected files via fcrackzip, 7z, john, and Python (zipfile) brute-force for CTF Miscellaneous archive challenges. Use for authorized CTF/lab Miscellaneous challenges when the task matches this ... |
| ctf-audio-stego-analysis | Analyze audio-based steganography (spectrogram, LSB, DTMF, morse via audio) using sox, audacity, sonic-visualiser, and Python (librosa/scipy) for CTF Miscellaneous. Use for authorized CTF/lab Miscellaneous challenges when the task matche... |
| ctf-encoding-decoding-chains | Decode chained encodings (base64/hex/rot13/url/zlib) and encoding puzzles common in CTF Miscellaneous challenges using Python one-liners and CyberChef-style pipelines. Use for authorized CTF/lab Miscellaneous challenges when the task mat... |
| ctf-esolang-puzzle-solving | Solve esolang and puzzle challenges (brainfuck, whitespace, piet, logic grids) with interpreters and Python solvers for CTF Miscellaneous puzzles. Use for authorized CTF/lab Miscellaneous challenges when the task matches this sub-domain. |
| ctf-metadata-extraction | Extract hidden metadata and embedded files from documents/images (exiftool, binwalk, strings, foremost) for CTF Miscellaneous OSINT-adjacent puzzles. Use for authorized CTF/lab Miscellaneous challenges when the task matches this sub-domain. |
| ctf-qr-barcode-decoding | Decode QR codes, barcodes, and visual encodings from images using zbarimg, qr-tools, and Python (pyzbar/Pillow) for CTF Miscellaneous visual puzzles. Use for authorized CTF/lab Miscellaneous challenges when the task matches this sub-domain. |
| ctf-scripting-automation | Automate CTF Miscellaneous scripting challenges with Python (pwntools/requests/regex) one-liners, bash loops, and rapid solver generation for repetitive or brute-force tasks. Use for authorized CTF/lab Miscellaneous challenges when the t... |
| ctf-traffic-scripting | Script network traffic analysis beyond basic forensics — scapy tshark automation, PCAP carving, and custom protocol parsing for CTF Miscellaneous networking puzzles. Use for authorized CTF/lab Miscellaneous challenges when the task match... |

## AI Jailbreak / AI Security (14)

| Skill | Description |
|---|---|
| assessing-vector-and-embedding-weaknesses | Test RAG vector stores (Pinecone, Qdrant, Weaviate, Chroma, pgvector, |
| auditing-mcp-servers-for-tool-poisoning | Audit MCP servers for tool poisoning, tool shadowing, rug pulls, SSRF, and unauthenticated exposure using Invariant Labs' mcp-scan for static/runtime scanning plus manual SSRF/auth checks and description pinning. Use before adding a new ... |
| continuous-llm-red-teaming-with-promptfoo | Wires Promptfoo and DeepTeam into CI/CD for automated, repeatable red-teaming of LLM apps against OWASP LLM Top 10, OWASP Agentic, and MITRE ATLAS presets, failing the build when jailbreak or injection vulnerabilities regress. Use for co... |
| defending-llms-with-guardrails | Deploys Llama Guard 3 safety classification, NeMo Guardrails programmable dialogue rails, and LLM Guard input/output scanner pipelines as complementary runtime defenses that inspect and constrain LLM prompts and responses. Use when addin... |
| detecting-ai-model-prompt-injection-attacks | Detects prompt injection using regex signature matching, heuristic scoring for structural anomalies, and DeBERTa-based transformer classification, flagging direct injections (system-prompt overrides, role-play escapes) and indirect injec... |
| detecting-data-and-model-poisoning | Identify poisoned training data and backdoored ML models across the pipeline using IBM's Adversarial Robustness Toolbox (activation clustering, spectral signatures, trigger reconstruction), Cleanlab for label-quality issues, and supply-c... |
| detecting-indirect-prompt-injection | Detect and defend against indirect prompt injection hidden in web pages, documents, |
| detecting-model-extraction-attacks | Detect MITRE ATLAS AML.T0024 attacks (model stealing, inversion, membership inference) performed via inference-API abuse, by monitoring per-principal query volume/distribution, rate-limiting and perturbing outputs, and red-teaming your m... |
| implementing-llm-guardrails-for-security | Implements input/output validation guardrails for LLM applications using |
| orchestrating-llm-attacks-with-pyrit | Build automated multi-turn adversarial attacks against conversational LLM targets using Microsoft PyRIT's RedTeamingOrchestrator, CrescendoOrchestrator (gradual escalation), and TreeOfAttacksWithPruningOrchestrator (adaptive branching), ... |
| red-teaming-llms-with-garak | Runs NVIDIA garak probe suites (jailbreak, prompt injection, data |
| securing-agentic-ai-tool-invocation | Implements defense-in-depth controls at an AI agent's tool-invocation |
| testing-for-system-prompt-leakage | Extracts LLM system prompts using direct requests, jailbreak/instruction-override |
| testing-prompt-injection-in-rag-pipelines | Probes Retrieval-Augmented Generation pipelines for indirect prompt injection |

## Bonus: AD / PrivEsc (10)

| Skill | Description |
|---|---|
| abusing-dpapi-for-credential-access | Extract and decrypt Windows DPAPI-protected secrets (Credential Manager, browser logins/cookies, Wi-Fi credentials, KeePass keys) online or offline using SharpDPAPI, SharpChrome, Mimikatz, or Impacket's dpapi.py, including domain-wide de... |
| abusing-shadow-credentials-for-privesc | Take over Active Directory accounts by writing attacker-controlled public keys to msDS-KeyCredentialLink (Shadow Credentials) with pyWhisker, Whisker, or Certipy, then authenticate via PKINIT to recover the target's NT hash without a pas... |
| exploiting-active-directory-with-bloodhound | BloodHound is a graph-based Active Directory reconnaissance tool that |
| exploiting-adcs-with-certipy | Use Certipy to enumerate AD CS certificate authorities and templates over LDAP/RPC, then exploit ESC1-ESC16 misconfigurations - SAN abuse, NTLM relay to web enrollment (ESC8), Shadow Credentials, golden certificate forgery, and PKINIT/Sc... |
| exploiting-kerberoasting-with-impacket | >- |
| exploiting-ms17-010-eternalblue-vulnerability | >- |
| exploiting-nopac-cve-2021-42278-42287 | Exploits the noPac Active Directory privilege-escalation chain (CVE-2021-42278 |
| exploiting-zerologon-vulnerability-cve-2020-1472 | Exploits the Zerologon vulnerability (CVE-2020-1472) in the Netlogon |
| performing-kerberoasting-attack | Perform Kerberoasting, a post-exploitation technique that enumerates |
| performing-privilege-escalation-on-linux | Guides manual enumeration and automated tooling to escalate from a low-privilege |

## Bonus: Exploit Frameworks (3)

| Skill | Description |
|---|---|
| exploiting-aws-with-pacu | >- |
| exploiting-smb-vulnerabilities-with-metasploit | Identifies and exploits SMB protocol vulnerabilities using Metasploit |
| exploiting-vulnerabilities-with-metasploit-framework | Uses the Metasploit Framework (msfconsole and its exploit, auxiliary, |

## Other / Unclassified (7)

| Skill | Description |
|---|---|
| analyzing-email-headers-for-phishing-investigation | Parse and analyze email headers (Received chain, Return-Path, Message-ID) |
| exploiting-server-side-request-forgery | Identifying and exploiting SSRF vulnerabilities to access internal services, |
| performing-memory-forensics-with-volatility3 | Analyze volatile memory (RAM) dumps using the Volatility 3 framework |
| performing-memory-forensics-with-volatility3-plugins | Analyze memory dumps using Volatility3 plugins to detect injected code, |
| performing-web-application-firewall-bypass | Bypasses Web Application Firewall protections using encoding tricks, |
| testing-for-json-web-token-vulnerabilities | Tests JWT implementations for algorithm confusion, "none" algorithm bypass, |
| testing-for-xml-injection-vulnerabilities | Test web applications for XML injection vulnerabilities including XXE, |
