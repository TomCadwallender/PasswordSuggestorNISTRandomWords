function Get-WordList {
    $wordListPath = "C:\path\to\your\wordlist.txt"

    if (-not (Test-Path $wordListPath)) {
        Write-Error "Word list file not found at $wordListPath"
        return $null
    }

    return Get-Content $wordListPath
}

$wordList = Get-WordList

if ($null -eq $wordList) {
    Write-Host "Failed to load word list. Exiting."
    exit
}

$adjectives = $wordList | Where-Object { $_ -match '^adj:' } | ForEach-Object { $_ -replace '^adj:', '' }
$nouns = $wordList | Where-Object { $_ -match '^noun:' } | ForEach-Object { $_ -replace '^noun:', '' }

$numbers = 0..9
$specialChars = @("!", "@", "#", "$", "%", "&", "*")

function Get-Passphrase {
    $adj = Get-Random -InputObject $adjectives
    $noun = Get-Random -InputObject $nouns
    $num = Get-Random -InputObject $numbers
    $special = Get-Random -InputObject $specialChars
    
    return "$adj$noun$num$special"
}

1..5 | ForEach-Object {
    Write-Host ("Suggested Passphrase {0}: {1}" -f $_, (Get-Passphrase))
}
