# Convertto-UnixLF

Convert text files from DOS line endings (CR LF) to Unix (LF).

PowerShell clone of the Unix dos2unix utility.

## EXAMPLEs

```powershell
      Convertto-UnixLF test.txt         # convert a single file
      Convertto-UnixLF *.txt            # convert multiple files
      $text-string | Convertto-UnixLF   # pipe text
      tasklist | Convertto-UnixLF       # pipe output from commands
```

## Notes

* [Pscx - PowerShell Community Extensions](https://github.com/Pscx/Pscx) contains **ConvertTo-UnixLineEnding**.  The current version didn't allow piping out from commands which I needed.