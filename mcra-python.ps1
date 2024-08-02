# Install Python and required MCRA packages from local layout, without internet connection
# Features:
# -silent install
# -No internet connection required, uses local install files 
#

$PythonInstaller = "python-3.12.4-amd64.exe"
$PythonVersionCompact = 312
$PythonVersion = "3.12"
$PythonTargetDir = "C:\Python$PythonVersionCompact"
$LibRoadRunner = "$PsScriptRoot\libroadrunner\libroadrunner-2.7.0-cp312-cp312-win_amd64.whl"
$numpy = "$PsScriptRoot\numpy\numpy-1.26.4-cp312-cp312-win_amd64.whl"

# Install Python
Write-Host "Installing Python $PythonVersion ..." -ForegroundColor green
Start-Process -FilePath "$PsScriptRoot\$PythonInstaller" `
    -ArgumentList "/quiet", "InstallAllUsers=1", "PrependPath=1", "TargetDir=$PythonTargetDir" `
    -NoNewWindow `
    -Wait `
    -PassThru `

# Add Python to the local path environment variable used by this script
$addPath = $PythonTargetDir
$addPathScript = "$PythonTargetDir\Scripts"
$arrPath = $env:Path -split ';'
$env:Path = ($arrPath + $addPath + $addPathScript) -join ';'

# Add MCRA pip packages
Write-Host "Installing packges ..." -ForegroundColor green
&"pip" install $numpy --no-deps --disable-pip-version-check
&"pip" install $LibRoadRunner --no-deps --disable-pip-version-check

