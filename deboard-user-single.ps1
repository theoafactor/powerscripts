# Disable one account

## the key thing is to use AccountEnabled set to false
$user = @{
    "UserPrincipalName" = "jericho@cyclobold01.onmicrosoft.com"
    "AccountEnabled" = $true ## the key thing is to set the account to disabled here
}


Set-MgUser @user