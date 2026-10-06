<#
.SYNOPSIS
    Trivial helper for the dotnet-test-debugger skill: extracts failing test names and their
    first error line from a saved `dotnet test` console log.

.DESCRIPTION
    This is intentionally minimal — a teaching example, not a production log parser. It looks for
    the common xUnit/NUnit/MSTest console patterns:
      "  Failed TestNamespace.TestClass.TestMethod [12 ms]"
      "    Error Message:"
      "     <message text on the following indented line>"
    ⚠️ Needs runtime verification: patterns were written against documented/typical dotnet test
    output shapes, not executed against a live failing project in this session. Test framework
    output format can vary by .NET SDK version and test adapter — verify against your own log
    before trusting it in a real workflow.

.PARAMETER LogPath
    Path to a text file containing `dotnet test` console output.

.EXAMPLE
    .\parse-failures.ps1 -LogPath .\test-output.txt
#>
param(
    [Parameter(Mandatory = $true)]
    [string]$LogPath
)

if (-not (Test-Path $LogPath)) {
    Write-Error "Log file not found: $LogPath"
    exit 1
}

$lines = Get-Content -Path $LogPath
$currentTest = $null

for ($i = 0; $i -lt $lines.Count; $i++) {
    $line = $lines[$i]

    # Matches lines like: "  Failed MyProject.Tests.CalculatorTests.Add_TwoNumbers_ReturnsSum [15 ms]"
    if ($line -match '^\s*Failed\s+(?<test>\S+)') {
        $currentTest = $Matches['test']
        $errorMessage = ''

        # Look ahead a few lines for an "Error Message:" block
        for ($j = $i + 1; $j -lt [Math]::Min($i + 6, $lines.Count); $j++) {
            if ($lines[$j] -match 'Error Message:') {
                if ($j + 1 -lt $lines.Count) {
                    $errorMessage = $lines[$j + 1].Trim()
                }
                break
            }
        }

        if ([string]::IsNullOrWhiteSpace($errorMessage)) {
            $errorMessage = '(no error message captured near this line — inspect the log manually)'
        }

        "{0} | {1}" -f $currentTest, $errorMessage
    }
}
