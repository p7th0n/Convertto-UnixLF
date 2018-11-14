function Convertto-UnixLF {
    <#
    .Synopsis
      Convert text files from DOS line endings (CR LF) to Unix (LF)
    .DESCRIPTION
      PowerShell clone of the Unix dos2unix utility.
    .EXAMPLE
      Convertto-UnixLF test.txt         # convert a single file
      Convertto-UnixLF *.txt            # convert multiple files
      $text-string | Convertto-UnixLF   # pipe text
      tasklist | Convertto-UnixLF       # pipe output from commands
  #>
    [CmdletBinding(DefaultParameterSetName = 'Parameter Set 1', 
        SupportsShouldProcess = $true, 
        PositionalBinding = $false,
        HelpUri = 'http://www.microsoft.com/',
        ConfirmImpact = 'Medium')]
    Param
    (
        [Parameter(
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true, 
            Position = 0)]
        [string[]]
        $glob
    )
    begin {
        $isClipboard = $true
        $output
        # check if there are comand line arguments
        if ($args.Length -gt 0) {
            Write-Host "args > 0..."
            $glob = $args -Join " "
            # check that command line is a valid path
            if (($glob.IndexOfAny([System.IO.Path]::GetInvalidPathChars()) -eq -1) -and (Test-Path $glob -PathType Leaf)) {
                Write-Host 'Converting: '$glob "`n"
                Get-ChildItem $glob |
                    ForEach-Object { $x = get-content -raw -path $_.fullname; $x -replace "`r`n", "`n" |
                        set-content -path $_.fullname -Encoding UTF8 -NoNewline
                    Write-Host "> "$_.Name
                }
            }
            $isClipboard = $false
        }
    }
    process {
        if ($glob) {
            $output += $glob -replace "`r`n", "`n"
            $isClipboard = $false
        }
    }
    end {
        if ($glob) {$isClipboard = $false}
        if ($isClipboard) {
            $clipboard = Get-Clipboard
            $clipboard -replace "`r`n", "`n"
        }
    }
}

Export-ModuleMember -Function Convertto-UnixLF
