# Create an install image for Python and MCRA pip packages
# 

param (
    [string]$PythonVersion = '3.12.4'
)

$PythonInstaller = "python-$PythonVersion-amd64.exe"
$PythonFolderVersion = $PythonVersion -replace '^(\d+)\.(\d+)\.(\d+)','$1$2'
$PythonTargetDir = "C:\Python$PythonFolderVersion"
$PipPackages = "$PsScriptRoot\mcra-pip-packages.txt"

# Install Python
Write-Host "Installing Python $PythonVersion in folder $PythonTargetDir ..." -ForegroundColor green
Start-Process -FilePath "$PsScriptRoot\$PythonInstaller" `
    -ArgumentList "/quiet", "InstallAllUsers=1", "PrependPath=1", "TargetDir=$PythonTargetDir" `
    -NoNewWindow `
    -Wait `
    -PassThru ` > $null

# Add Python to the local path environment variable, so the next pip commands can be used in this script
$addPath = $PythonTargetDir
$addPathScript = "$PythonTargetDir\Scripts"
$arrPath = $env:Path -split ';'
$env:Path = ($arrPath + $addPath + $addPathScript) -join ';'

# Add MCRA pip packages
Write-Host "Installing pip packges ..." -ForegroundColor green
$PipPackages = Get-Content -Path $PipPackages
ForEach ($package in $PipPackages) {
    $package = $package.Trim()
    $package = "$PsScriptRoot\pip\$package" 
    &"pip" install $package --no-deps --disable-pip-version-check
}
