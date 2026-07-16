# setup.ps1 - fetch third-party dependencies after a fresh clone (PowerShell).
# Analogous to `npm install`. Pins Dear ImGui to a known-good commit.
$ErrorActionPreference = 'Stop'

$root     = Split-Path -Parent $MyInvocation.MyCommand.Path
$imguiDir = Join-Path $root 'third_party\imgui'
$imguiUrl = 'https://github.com/ocornut/imgui.git'
# Pinned Dear ImGui release tag. Bump deliberately.
$imguiTag = 'v1.92.8'

if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    Write-Error 'git not found on PATH. Install Git and retry.'
}

if (Test-Path (Join-Path $imguiDir 'imgui.cpp')) {
    Write-Host 'Dear ImGui already installed at third_party\imgui'
    Write-Host '  (delete that folder and re-run setup.ps1 to reinstall)'
} else {
    Write-Host "Installing Dear ImGui $imguiTag ..."
    git clone -q --depth 1 --branch $imguiTag $imguiUrl $imguiDir
    if (-not (Test-Path (Join-Path $imguiDir 'imgui.cpp'))) {
        Write-Error 'Failed to fetch Dear ImGui.'
    }
    Write-Host 'Done.'
}

Write-Host ''
Write-Host 'Dependencies ready. Build with:  .\build.bat'
