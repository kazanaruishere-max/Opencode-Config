#Requires -Version 5.1
# kali-bash core: forward everything to Kali bash -c as ONE string.
# Called via kali-bash.cmd trampoline. Handles both:
#   kali-bash.cmd <command...>  and  kali-bash.cmd -c "<command>"
$rest = @($args)
if ($rest.Count -gt 0 -and $rest[0] -eq '-c') {
  if ($rest.Count -gt 1) { $rest = @($rest[1..($rest.Count - 1)]) } else { $rest = @() }
}
if ($rest.Count -eq 0) { exit 0 }
$cmd = ($rest -join ' ')
& wsl.exe -d kali-linux --cd ~ bash -c $cmd
exit $LASTEXITCODE
