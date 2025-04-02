# Verifica se está rodando como administrador
if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Warning "Este script requer privilégios de administrador!"
    Write-Host "`nPressione qualquer tecla para fechar esta janela..."
    $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')
    exit
}

# Função para selecionar arquivo DLL
function Select-DllFile {
    Add-Type -AssemblyName System.Windows.Forms
    $fileBrowser = New-Object System.Windows.Forms.OpenFileDialog
    $fileBrowser.Filter = "Arquivos DLL (*.dll)|*.dll"
    $fileBrowser.Title = "Selecione o arquivo DLL para adicionar como exceção"
    $fileBrowser.CheckFileExists = $true
    
    if ($fileBrowser.ShowDialog() -eq 'OK') {
        return $fileBrowser.FileName
    }
    return $null
}

# Função para adicionar exceção
function Add-DefenderException {
    param (
        [string]$filePath
    )
    
    try {
        Add-MpPreference -ExclusionPath $filePath -Force
        Write-Host "Exceção adicionada com sucesso!" -ForegroundColor Green
        
        # Verifica se a exceção foi realmente adicionada
        $exclusions = Get-MpPreference | Select-Object -ExpandProperty ExclusionPath
        if ($exclusions -contains $filePath) {
            Write-Host "Exceção confirmada na lista do Windows Defender!" -ForegroundColor Green
            return $true
        } else {
            Write-Warning "Exceção não encontrada na lista do Windows Defender!"
            return $false
        }
    } catch {
        Write-Host "Erro ao adicionar exceção: " $_.Exception.Message -ForegroundColor Red
        return $false
    }
}

# Função para listar exceções
function Show-DefenderExceptions {
    Clear-Host
    Write-Host "=== Lista de Exceções do Windows Defender ===" -ForegroundColor Cyan
    Write-Host "Carregando lista de exceções...`n" -ForegroundColor Yellow
    
    try {
        $exclusions = Get-MpPreference | Select-Object -ExpandProperty ExclusionPath
        if ($exclusions) {
            Write-Host "Exceções encontradas:" -ForegroundColor Green
            foreach ($exclusion in $exclusions) {
                Write-Host " - $exclusion"
            }
            Write-Host "`nTotal de exceções: $($exclusions.Count)" -ForegroundColor Cyan
        } else {
            Write-Host "Nenhuma exceção encontrada." -ForegroundColor Yellow
        }
    } catch {
        Write-Host "Erro ao listar exceções: " $_.Exception.Message -ForegroundColor Red
    }
}

# Menu principal
function Show-Menu {
    Clear-Host
    Write-Host "=== Gerenciador de Exceções do Windows Defender ===" -ForegroundColor Cyan
    Write-Host "1. Adicionar nova exceção"
    Write-Host "2. Listar exceções existentes"
    Write-Host "3. Sair"
    Write-Host "`nEscolha uma opção (1-3): " -NoNewline
    $option = Read-Host
    return $option
}

# Loop principal
do {
    $option = Show-Menu
    switch ($option) {
        "1" {
            Clear-Host
            Write-Host "=== Adicionando Exceção no Windows Defender ===" -ForegroundColor Cyan
            Write-Host "Selecione o arquivo DLL para adicionar como exceção.`n" -ForegroundColor Yellow
            
            $selectedFile = Select-DllFile
            if ($selectedFile) {
                Write-Host "`nProcessando arquivo: $selectedFile" -ForegroundColor Yellow
                Add-DefenderException -filePath $selectedFile
            } else {
                Write-Host "`nNenhum arquivo foi selecionado." -ForegroundColor Yellow
            }
            
            Write-Host "`nPressione qualquer tecla para continuar..."
            $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')
        }
        "2" {
            Show-DefenderExceptions
            Write-Host "`nPressione qualquer tecla para continuar..."
            $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')
        }
        "3" {
            Write-Host "`nEncerrando o programa..." -ForegroundColor Yellow
            exit
        }
        default {
            Write-Host "`nOpção inválida!" -ForegroundColor Red
            Start-Sleep -Seconds 2
        }
    }
} while ($true) 