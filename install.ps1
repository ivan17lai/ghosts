# Install the published Windows preview for the current user.
& {
    $ErrorActionPreference = 'Stop'
    $url = 'https://github.com/ivan17lai/ghosts/releases/download/windows-preview-1/install.ps1'
    $client = [Net.WebClient]::new()
    $sha = [Security.Cryptography.SHA256]::Create()
    try {
        $bytes = $client.DownloadData($url)
        $hash = [BitConverter]::ToString($sha.ComputeHash($bytes)).Replace('-', '')
        if ($hash -ne 'E74DCF7F1BD31152702160B42AA7A67C72539E5B94E5FDDFE7B38EF607F5211E') {
            throw 'The preview installer failed SHA-256 verification.'
        }
        & ([ScriptBlock]::Create([Text.Encoding]::UTF8.GetString($bytes)))
    } finally {
        $sha.Dispose()
        $client.Dispose()
    }
}
