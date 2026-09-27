# Challenge Writeup: [Challenge Name]

- **Category:** [Crypto | Pwn | Reverse | Web | Forensics | Misc | OSINT | AI]
- **Points / Difficulty:** [Points] / [Easy | Medium | Hard]
- **Time Spent:** [X] minutes (Time-box: [4m | 10m | 20m])
- **Primary Skill:** `[skill-name-from-harness]`
- **Date & Time Solved:** [YYYY-MM-DD HH:MM UTC]

---

## 1. Triage & Strategy
- Objective: [1-2 sentences]
- Initial Priority Score: [Points / Est. Min]
- Hypothesized Attack Vector: [Direct flaw suspected]

## 2. Automated Recon Output (`ctf-recon.sh`)
Key fingerprint discovered during automated recon:
```bash
# Recon fingerprint output (e.g. checksec flags, HTTP headers, file magic, strings hit)
```

## 3. Pivot Log (Failures & Alternate Vectors)
- **Attempt 1:** [Vector tried, e.g. Basic buffer overflow with cyclic pattern] -> *Result:* [Failed, e.g. SIGSEGV on invalid canary]
- **Attempt 2 (Pivot):** [New skill/vector, e.g. Leaked canary via format string %11$p then ROP] -> *Result:* [Success, shell acquired]

## 4. Exploitation & Solver Script
Full reproducible solver script executed on Kali:

```python
#!/usr/bin/env python3
# Solver script for [Challenge Name]
from pwn import *

# Exploit code here
```

## 5. Flag
```text
ITECHNO26{...}
```

## 6. Key Takeaways & Reusable Tricks
- Core trick: [e.g. libc offset gadget, JWT none algorithm header flaw, tcache poison]
- Fast mitigation / detection note: [What prevented this flaw]
