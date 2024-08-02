# Install Python and required packages for MCRA. 
# Features:
# -silent install
# -No internet connection required, uses local install files 
#


$PythonInstaller = "python-3.12.4-amd64.exe"
$PythonVersionCompact = 312
$PythonVersion = "3.12"
$LibRoadRunner = "$PsScriptRoot\libroadrunner\libroadrunner-2.7.0-cp312-cp312-win_amd64.whl"
$numpy = "$PsScriptRoot\numpy\numpy-1.26.4-cp312-cp312-win_amd64.whl"

Write-Host "Installing Python $PythonVersion ..." -ForegroundColor green
Start-Process -FilePath "$PsScriptRoot\$PythonInstaller" `
    -ArgumentList "/quiet", "InstallAllUsers=1", "PrependPath=1", "TargetDir=`"C:\Python$PythonVersionCompact`"" `
    -NoNewWindow `
    -Wait `
    -PassThru `

Write-Host "Installing packges ..." -ForegroundColor green
&"pip" install $numpy --no-deps --disable-pip-version-check
&"pip" install $LibRoadRunner --no-deps --disable-pip-version-check

