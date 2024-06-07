#Import-Module PSReadline
param (
    #[string]$UserName,
    #[string]$Password,
    $name,
    [switch]$uvnc
    #[switch]$printers
    #[switch]$MFA,
    #[int]$Action, 
)
#requires -version 2
<#
.SYNOPSIS
 Controlar Totems y monitores 
.DESCRIPTION
 Codigo solo valido para clinicadelasamericas
.PARAMETER <Parameter_Name>
.INPUTS
.OUTPUTS
.NOTES
  Version:        1.0
  Author:         mrioas
  Creation Date:  14/06/2023
  Purpose/Change: Initial script development
  
.EXAMPLE
#>

#Variables
$pathuvnc = 'C:\Program Files\uvnc bvba\UltraVNC\vncviewer.exe'

## TASY MAIN FUNCTION
## CLAVE GENERICA JULIO 2023 USUARIOS TASY: CDl4/23#
function tasyfunction($name)
{& 'C:\Program Files\uvnc bvba\UltraVNC\vncviewer.exe' -autoreconnect 30 -quickoption 5 -password HD*Cdl4 -nostatus -notoolbar -8greycolors -autoscaling -compresslevel 5 -dotcursor -encoding zlib -connect $name}

$printers = get-printer *
function printers($p){
foreach ($printer in $printers)
{
    get-printerproperty -printerName $printer.name| Out-File -FilePath .\filename.txt -Append
}
}

function CreateDirectory([string]$fullPath)
{
    $existEvaluation = Test-Path $fullPath -PathType Any
    if($existEvaluation -eq $false)
    {
        new-item $fullPath -itemtype directory
    }
    return 1
}
function ListaTotems (){
	Log-Write "Listado"
}
#Script Version
$sScriptVersion = "1.0"

#Log File Info
$sLogPath = "C:\Windows\Temp"
$sLogName = "tasy.log"
$sLogFile = Join-Path -Path $sLogPath -ChildPath $sLogName
$VNC = 'C:\Program Files\uvnc bvba\UltraVNC\vncviewer.exe'

if ($uvnc.IsPresent){
	Write-Host "in: $name"
	tasyfunction($name)
}
if ($printers.IsPresent){
	#Write-Host "in: $printers"
	printers($p)
}
write-host "$($args.count) argumento(s) Tipea -?, --help, -h para ver ayuda"
write-host "ok"
for ( $i = 0; $i -lt $args.count; $i++ ) {
    write-host "Argument  $i is $($args[$i])"
}
