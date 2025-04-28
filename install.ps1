#region Installation

Write-Host "🚀 Downloading and installing apps using winget..." -ForegroundColor Cyan
Write-Host "==================================="

winget install neovim --id Neovim.Neovim -s winget
winget install JanDeDobbeleer.OhMyPosh -s winget
winget install ntop --id gsass1.NTop -s winget
winget install wget --id JernejSimoncic.Wget
winget install wget --id JernejSimoncic.Wget

if (-Not (Get-Command scoop -ErrorAction SilentlyContinue)) {
    Write-Host "🔍 Scoop is NOT installed. Installing now..." -ForegroundColor Yellow
    Write-Host "🚀 Starting Scoop installation..." -ForegroundColor Cyan
    Write-Host "==================================="

    Write-Host "[✔] Verifying Execution Policy..." -ForegroundColor Green
    Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
    
    Write-Host "[✔] Downloading Scoop Installer..." -ForegroundColor Green
    Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression

    Write-Host "✅ Scoop has been installed successfully!" -ForegroundColor Green
}
else {
    Write-Host "🚀 Scoop is already installed!" -ForegroundColor Cyan
    Write-Host "🚀 Updating..." -ForegroundColor Cyan
    scoop update
}

Write-Host "`n🚀 Installing apps via scoop!" -ForegroundColor Green
scoop install sudo 
scoop install curl

#endregion

#region Modules

Write-Host "`n🚀 Starting Modules installation..." -ForegroundColor Cyan

Install-Module -Name Terminal-Icons -Repository PSGallery
Install-Module posh-git -Scope CurrentUser

Write-Host "`n[✔] Done..." -ForegroundColor Green

#endregion

#region Vim Configuration

Write-Host "`n🚀 Starting Config Vim..." -ForegroundColor Cyan

New-Item -Path "~\AppData\Local\nvim\" -ItemType Directory -ErrorAction SilentlyContinue
New-Item -Path "~\AppData\Local\nvim\colors\" -ItemType Directory -ErrorAction SilentlyContinue

Copy-Item -Path ".\vim_config.vim" -Destination "~\AppData\Local\nvim\init.vim" -Force -ErrorAction SilentlyContinue

curl -o $HOME\AppData\Local\nvim\colors\molokai.vim https://raw.githubusercontent.com/tomasr/molokai/master/colors/molokai.vim

curl -fLo $HOME\AppData\Local\nvim\autoload\plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

Write-Host "`n[✔] Done..." -ForegroundColor Green
#endregion

#region Oh-My-Posh Configuration

# Reloading Animation 
$frames = @('|', '/', '-', '\')
for ($i = 0; $i -lt 20; $i++) {
    Write-Host "`rConfiguring Oh-My-Posh... $($frames[$i % $frames.Length])" -NoNewline
    Start-Sleep -Milliseconds 300
}

New-Item -Path $PROFILE -Type File -Force -ErrorAction SilentlyContinue

$lines = @(
    "Set-Alias ll ls",
    "Set-Alias g git",
    "Set-Alias vim nvim",
    "Import-Module -Name posh-git",
    "Import-Module -Name Terminal-Icons",
    "oh-my-posh init pwsh --config `"$HOME\.config\powershell\theme.omp.json`" | Invoke-Expression"
)

$lines | Set-Content -Path $PROFILE -ErrorAction SilentlyContinue

New-Item -Path "~\.config\" -ItemType Directory -ErrorAction SilentlyContinue
New-Item -Path "~\.config\powershell\" -ItemType Directory -ErrorAction SilentlyContinue

Copy-Item -Path ".\oh_my_posh_theme.json" -Destination "~\.config\powershell\theme.omp.json" -Force -ErrorAction SilentlyContinue

Write-Host "`nmake sure you run vim and install the plugins..." -ForegroundColor Yellow
Write-Host "`n[✔] Done..." -ForegroundColor Green

#endregion