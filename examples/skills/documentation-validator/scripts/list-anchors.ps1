<#
.SYNOPSIS
    Minimal helper for the documentation-validator skill: lists Markdown headings in a file
    together with their GitHub-correct anchor slug (emoji stripped, leading space/hyphen preserved).

.DESCRIPTION
    Teaching example only — handles the common case (ATX headings, `## Text`) and intentionally
    does not attempt to handle every Unicode edge case. ⚠️ Needs runtime verification against a
    large real-world file before being trusted for an automated CI gate.

.PARAMETER FilePath
    Path to a single Markdown file.

.EXAMPLE
    .\list-anchors.ps1 -FilePath .\README.md
#>
param(
    [Parameter(Mandatory = $true)]
    [string]$FilePath
)

if (-not (Test-Path $FilePath)) {
    Write-Error "File not found: $FilePath"
    exit 1
}

Get-Content -Path $FilePath -Encoding utf8 | Where-Object { $_ -match '^(#{1,6})\s+(.*)$' } | ForEach-Object {
    $null = $_ -match '^(#{1,6})\s+(.*)$'
    $headingText = $Matches[2]

    # Step 1: lowercase. Step 2: strip everything except letters/digits/underscore/hyphen/space.
    # Step 3: spaces -> hyphens. Deliberately NOT trimmed afterward (GitHub does not trim).
    $slug = $headingText.ToLowerInvariant()
    $slug = [regex]::Replace($slug, '[^\p{L}\p{N}_\- ]', '')
    $slug = $slug -replace ' ', '-'

    "{0} => #{1}" -f $headingText, $slug
}
