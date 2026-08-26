---
name: ctf-metadata-extraction
description: Extract hidden metadata and embedded files from documents/images (exiftool, binwalk, strings, foremost) for CTF Miscellaneous OSINT-adjacent puzzles. Use for authorized CTF/lab Miscellaneous challenges when the task matches this sub-domain.
domain: cybersecurity
subdomain: ctf-misc
tags:
- misc
- metadata
- exiftool
- binwalk
- ctf

version: '1.0'
author: custom
license: MIT
---

# ctf-metadata-extraction

## When to Use
- Authorized CTF Miscellaneous challenges matching this skill
- Kali Linux execution: copy generated command and run in Kali

## Workflow
CTF Soal → opencode (this skill → generate command) → Kali Linux (execute)

## Tools (Kali)
See description for primary tools; fallback to Python/bash one-liners.

## Example
Generate a solver/command for the challenge and run in Kali; validate flag format before submit.
