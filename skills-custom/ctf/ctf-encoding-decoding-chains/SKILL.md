---
name: ctf-encoding-decoding-chains
description: Decode chained encodings (base64/hex/rot13/url/zlib) and encoding puzzles common in CTF Miscellaneous challenges using Python one-liners and CyberChef-style pipelines. Use for authorized CTF/lab Miscellaneous challenges when the task matches this sub-domain.
domain: cybersecurity
subdomain: ctf-misc
tags:
- misc
- encoding
- decoding
- base64
- hex
- rot13
- ctf

version: '1.0'
author: custom
license: MIT
---

# ctf-encoding-decoding-chains

## When to Use
- Authorized CTF Miscellaneous challenges matching this skill
- Kali Linux execution: copy generated command and run in Kali

## Workflow
CTF Soal → opencode (this skill → generate command) → Kali Linux (execute)

## Tools (Kali)
See description for primary tools; fallback to Python/bash one-liners.

## Example
Generate a solver/command for the challenge and run in Kali; validate flag format before submit.
