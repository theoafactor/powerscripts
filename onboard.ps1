function NewUser {
    [CmdletBinding(SupportsShouldProcess)]
    
    ## pass the path of the csv file here
    param([Parameter(Mandatory)][string]$path)

    Start-Sleep -Seconds 5

    Write-Output "You just loaded $path ..."

    

    $log = foreach($row in Import-CSV $path){
        $upn = ("{0}@{1}.{2}" -f $row.Firstname, "cyclobold01", "onmicrosoft.com").tolower()

        ## check to see if the user exists 
        if(Get-MgUser -Filter "userPrincipalName eq '$upn'"){
            ## the user exists already 
            Write-Output "User exists already, moving on ..."
            continue
        }

        if($PSCmdlet.ShouldProcess($upn, "create user")){
            Write-Output "Should the user be created ..."

            $newUser = @{
                "Surname" = $row.Firstname
                "MailNickname" = ("{0}" -f $row.Firstname)
                "DisplayName" = $row.Firstname
                "AccountEnabled" = $false
                "UserPrincipalName" = ("{0}@{1}.{2}" -f $row.Firstname, "cyclobold01", "onmicrosoft.com").tolower()
                "PasswordProfile" = @{Password = 'testPassword123'}
            }

            ## create the new user  
            New-MgUser @newUser 


        }
    }

    $log





}


NewUser -path .\test.csv

