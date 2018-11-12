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

    }
    process {
        if (($glob.IndexOfAny([System.IO.Path]::GetInvalidPathChars()) -eq -1) -and (Test-Path $glob -PathType Leaf)) {
            Write-Host 'Converting: '$glob "`n"
            Get-ChildItem $glob |
                ForEach-Object { $x = get-content -raw -path $_.fullname; $x -replace "`r`n", "`n" |
                    set-content -path $_.fullname -Encoding UTF8 -NoNewline
                    Write-Host "> "$_.Name
                }
        } else {
            $glob -replace "`n", "`n"
        }
    }
    end {

    }
}

Export-ModuleMember -Function Convertto-UnixLF
