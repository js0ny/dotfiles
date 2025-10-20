# PowerShell Profile

This is the cross-platform PowerShell profile for PowerShell Core

```text
.
├── Aliases.ps1
├── Keymap.ps1              # keymaps, optimize for Vi-Mode and Colemak
├── Modules.ps1
├── Navigation.ps1
├── Prompt.ps1
├── readme.md
└── Scripts.ps1

1 directory, 7 files
```

| Keymap | Action               | Mode   |
| ------ | -------------------- | ------ |
| `^a`   | To Beginning of Line | All    |
| `^e`   | To End of Line       | All    |
| `^[`   | To Normal Mode       | Insert |

## `Get-Command` vs `which.exe` under Windows

```powershell
PS >  hyperfine "pwsh.exe -NoProfile -Command 'Get-Command which'" "pwsh.exe -NoProfile -Command 'which which'" --warmup 10
Benchmark 1: pwsh.exe -NoProfile -Command 'Get-Command which'
  Time (mean ± σ):     152.1 ms ±   1.3 ms    [User: 112.2 ms, System: 89.3 ms]
  Range (min … max):   150.0 ms … 155.3 ms    18 runs

Benchmark 2: pwsh.exe -NoProfile -Command 'which which'
  Time (mean ± σ):     153.7 ms ±   6.4 ms    [User: 126.7 ms, System: 101.9 ms]
  Range (min … max):   147.8 ms … 169.5 ms    19 runs

Summary
  pwsh.exe -NoProfile -Command 'Get-Command which' ran
    1.01 ± 0.04 times faster than pwsh.exe -NoProfile -Command 'which which'
```
