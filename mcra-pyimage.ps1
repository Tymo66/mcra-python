# Install Python and required MCRA packages from local layout, without internet connection
# Features:
# -silent install
# -No internet connection required, uses local install files 
#

param (
    [string]$ImageFolder = 'c:\temp',
    [string]$PythonVersion = '3.12.4'
)



$PythonInstaller = "python-$PythonVersion-amd64.exe"
$numpy = "https://files.pythonhosted.org/packages/16/2e/86f24451c2d530c88daf997cb8d6ac622c1d40d19f5a031ed68a4b73a374/numpy-1.26.4-cp312-cp312-win_amd64.whl"
$roadrunner = "https://files.pythonhosted.org/packages/30/3c/4b8e84c08e6784c8c7c2cc8badd51344af6205cb191bee3c573a9db2a5f4/libroadrunner-2.7.0-cp312-cp312-win_amd64.whl"

# Download Python
Write-Host "Downloading Python $PythonVersion installer ..." -ForegroundColor green
Invoke-WebRequest -Uri "https://www.python.org/ftp/python/$PythonVersion/python-$PythonVersion-amd64.exe" -OutFile "$ImageFolder\python-$PythonVersion-amd64.exe"

# Create local installer layout
Write-Host "Creating local installer layout ..." -ForegroundColor green
Start-Process -FilePath "$PsScriptRoot\$PythonInstaller" `
     -ArgumentList "/layout $ImageFolder", "/quiet" `
     -NoNewWindow `
     -Wait `
     -PassThru `

# Download pip packges
Write-Host "Downloading pip packages ..." -ForegroundColor green
New-Item -Name "pip" -Path "$ImageFolder" -ItemType Directory > $null
Invoke-WebRequest -Uri $numpy -OutFile "$ImageFolder\pip\numpy-1.26.4-cp312-cp312-win_amd64.whl"
Invoke-WebRequest -Uri $roadrunner -OutFile "$ImageFolder\pip\libroadrunner-2.7.0-cp312-cp312-win_amd64.whl"

# Copy install scripts
Write-Host "Copy install script ..." -ForegroundColor green
Copy-item -Path "$PsScriptRoot\mcra-pyinstall.ps1" -Destination "$ImageFolder" > $null
Copy-item -Path "$PsScriptRoot\mcra-pip-packages.txt" -Destination "$ImageFolder" > $null

Write-Host "Done!" -ForegroundColor green
