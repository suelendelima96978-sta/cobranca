$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent $PSScriptRoot
$localFolder = Join-Path $root 'local-only'
New-Item -ItemType Directory -Force -Path $localFolder | Out-Null
$tokenPath = Join-Path $localFolder 'share-token.txt'

if (Test-Path -LiteralPath $tokenPath) {
  $token = (Get-Content -Raw -LiteralPath $tokenPath).Trim()
  Write-Host 'Usando o código já criado. Isso mantém o link anterior ativo.'
} else {
  $bytes = New-Object byte[] 32
  $rng = [Security.Cryptography.RandomNumberGenerator]::Create()
  $rng.GetBytes($bytes)
  $rng.Dispose()
  $token = [Convert]::ToBase64String($bytes).TrimEnd('=').Replace('+','-').Replace('/','_')
  [System.IO.File]::WriteAllText($tokenPath, $token)
  Write-Host 'Código novo gerado e guardado na pasta local-only.'
}
try {
  Set-Clipboard -Value $token
  Write-Host 'O código foi copiado. Cole-o quando o Wrangler pedir SHARE_TOKEN.'
} catch {
  Write-Host 'Abra local-only/share-token.txt e copie o código quando o Wrangler pedir SHARE_TOKEN.'
}