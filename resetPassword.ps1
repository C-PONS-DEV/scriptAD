Import-Module ActiveDirectory

$CSVFile = "C:\temp\liste.csv"
$CSVData = Import-CSV -Path $CSVFile -Delimiter ";" -Encoding UTF8

Foreach($Utilisateur in $CSVData){
    $UtilisateurLogin = $Utilisateur.SamAccountName
    $UtilisateurMotDePasse = $Utilisateur.Password

    # Vérifier la présence de l'utilisateur dans l'AD, et change le mot de passe.
    if (Get-ADUser -Filter {SamAccountName -eq $UtilisateurLogin})
    {
        
        Set-ADAccountPassword -Identity $UtilisateurLogin -Reset -NewPassword (ConvertTo-SecureString -AsPlainText "$UtilisateurMotDePasse" -Force)
    }
    else
    {
        $dossier = "C:\temp"

        if(Test-Path $dossier){
        }else{
            New-Item "C:\temp" -itemType Directory
        }

        Write-Warning "L'identifiant $UtilisateurLogin existe pas dans l'AD" | Export-Csv -Path c:\temp\ErreurUtilisateur.csv
        
        Invoke-Item "C:\temp"
    }
}
