$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent $PSScriptRoot
$tokenPath = Join-Path $root 'local-only/share-token.txt'
if (-not (Test-Path -LiteralPath $tokenPath)) { throw 'Gere primeiro o código com scripts/Generate-Share-Token.ps1.' }
$token = (Get-Content -Raw -LiteralPath $tokenPath).Trim()
$baseUrl = (Read-Host 'Cole a URL workers.dev exibida depois da publicação').Trim().TrimEnd('/')
if (-not $baseUrl.StartsWith('https://')) { throw 'Informe a URL https:// completa da publicação.' }
$link = $baseUrl + '/#' + $token
[System.IO.File]::WriteAllText((Join-Path $root 'local-only/link-compartilhado.txt'), $link)
try { Set-Clipboard -Value $link } catch {}
Write-Host ''
Write-Host 'Link completo copiado e guardado em local-only/link-compartilhado.txt.'
Write-Host 'Envie esse link completo apenas às pessoas autorizadas.'