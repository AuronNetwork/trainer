param(
    [Parameter(Mandatory=$true)][ValidatePattern('^\d+\.\d+(?:\.\d+)?$')][string]$Version,
    [Parameter(Mandatory=$true)][string]$ZipPath,
    [Parameter(Mandatory=$true)][ValidatePattern('^[a-fA-F0-9]{64}$')][string]$ExpectedSha256
)
$ErrorActionPreference='Stop'
Add-Type -AssemblyName System.IO.Compression.FileSystem
$expectedName='AuronNetworkMultiGameTrainer_v'+$Version+'.zip'
if ((Split-Path $ZipPath -Leaf) -cne $expectedName) { throw 'Unexpected package filename/version.' }
if ((Get-FileHash -LiteralPath $ZipPath).Hash -ne $ExpectedSha256) { throw 'Package SHA-256 mismatch.' }
$zip=[IO.Compression.ZipFile]::OpenRead((Resolve-Path -LiteralPath $ZipPath))
try {
    $names=[Collections.Generic.HashSet[string]]::new([StringComparer]::OrdinalIgnoreCase)
    foreach ($entry in $zip.Entries) {
        $name=$entry.FullName.Replace('\','/')
        if ($name.StartsWith('/') -or $name.Contains(':') -or ($name.Split('/') -contains '..') -or !$names.Add($name)) {
            throw 'Unsafe or duplicate archive entry.'
        }
    }
    foreach ($name in 'AuronNetworkMultiGameTrainer.exe','README_DE.txt','README_EN.txt','CHANGELOG_EN.txt','SECURITY_NOTICE.txt','SHA256SUMS.txt') {
        if (!$zip.GetEntry($name)) { throw ('Required archive entry missing: '+$name) }
    }
    function Read-EntryText([string]$name) {
        $entry=$zip.GetEntry($name)
        if (!$entry -or $entry.Length -gt 2MB) {throw 'Missing or oversized metadata.'}
        $reader=[IO.StreamReader]::new($entry.Open())
        try {return $reader.ReadToEnd()} finally {$reader.Dispose()}
    }
    foreach ($name in 'README_DE.txt','README_EN.txt') {
        if (((Read-EntryText $name) -split '\r?\n')[0].Trim() -ne ('AuronNetwork Multi-Game Trainer '+$Version)) {throw 'README version mismatch.'}
    }
    $firstVersion=[regex]::Match((Read-EntryText 'CHANGELOG_EN.txt'),'(?m)^Version\s+(\d+\.\d+(?:\.\d+)?)\s*$')
    if (!$firstVersion.Success -or $firstVersion.Groups[1].Value -ne $Version) {throw 'Changelog version mismatch.'}
    if ([string]::IsNullOrWhiteSpace((Read-EntryText 'SECURITY_NOTICE.txt'))) {throw 'Empty security notice.'}
    $listed=[Collections.Generic.HashSet[string]]::new([StringComparer]::OrdinalIgnoreCase)
    foreach ($line in ((Read-EntryText 'SHA256SUMS.txt') -split '\r?\n')) {
        if (!$line) {continue}
        if ($line -notmatch '^([a-fA-F0-9]{64})  (.+)$') {throw 'Invalid checksum line.'}
        $expected=$Matches[1]; $name=$Matches[2]
        if (!$listed.Add($name)) {throw 'Duplicate checksum.'}
        $entry=$zip.GetEntry($name)
        if (!$entry) {throw 'Checksum entry missing.'}
        $stream=$entry.Open(); $sha=[Security.Cryptography.SHA256]::Create()
        try {$actual=[BitConverter]::ToString($sha.ComputeHash($stream)).Replace('-','')}
        finally {$stream.Dispose(); $sha.Dispose()}
        if ($actual -ne $expected) {throw ('Archive content checksum mismatch: '+$name)}
    }
    foreach ($entry in $zip.Entries) {
        if ($entry.Name -and $entry.FullName -ne 'SHA256SUMS.txt' -and !$listed.Contains($entry.FullName)) {throw 'Unlisted archive file.'}
    }
    Write-Output "NEXUS_PACKAGE_OK: v$Version, exact ZIP hash, required documents and $($listed.Count) content hashes. No extraction, execution or upload."
} finally {$zip.Dispose()}
