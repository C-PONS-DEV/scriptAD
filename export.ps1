$dossier = "C:\temp"

if(Test-Path $dossier){
}else{
    New-Item "C:\temp" -itemType Directory
}

Import-Module ActiveDirectory


#Script qui exporte tout
Get-ADUser -Filter * -Properties * | Select-Object * | Export-Csv -Path c:\temp\ExportOfAll.csv

#Script qui exporte uniquement name, AccountExpirationDate et ObjectCategory
Get-ADUser -Filter * -Properties * | Select-Object  name, AccountExpirationDate, ObjectCategory | Export-Csv -Path c:\temp\EssentialExport.csv

#Write-Host "Les deux fichiers on était exporté, vous pouvez les retourvez sur C:\temp\" -ForegroundColor Green

Invoke-Item "C:\temp"