<#
#### requires ps-version 5.1 ####

.DESCRIPTION
A simple script to use in Active Roles One Identity to change Sharepoint Online 
properties

.NOTES
   Version:        0.1
   Author:         Maarten Schmeitz
   Creation Date:  Monday, January 6th 2020, 4:23:46 pm
   File: USER_ModifySPO.ps1
   Copyright (c) 2020 Advantive

HISTORY:
Date      	          By	Comments
----------	          ---	----------------------------------------------------------
2020-01-08-12-04	 MSCH	Initial Version

.LINK
   www.advantive.nl

.LICENSE
Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the Software), to deal
in the Software without restriction, including without limitation the rights
to use copy, modify, merge, publish, distribute sublicense and /or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED AS IS, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
 
#>

function onPostModify($Request)
{
    ## Variables to change 
    $SPOadminURL = SharepointAdminURL #CHANGE Here
    $SECPWDFile = LOCATIONOFSECPWDFILE #CHANGE Here
    $SPOAdminUser = USERNAME@DOMAIN.TLD
    ## Variables END

    $LocalPass = Get-Content $($SECPWDFile) | ConvertTo-SecureString 
    $localCred = New-Object -typename System.Management.Automation.PSCredential -argumentlist $($SPOAdminUser),$LocalPass  
    Connect-PnPOnline -Url $($SPOadminURL) -AuthenticationMode default -Credentials ($localCred)

    
    $userUPN = $(Get-QADUser -Enabled -SearchRoot $Request.DN).UserPrincipalName
    $userMobile = $(Get-QADUser -Enabled -SearchRoot $Request.DN).MobilePhone
    
      
    ## SharePoint ##
   
Set-PnPUserProfileProperty -Account $($userUPN) -PropertyName 'SPS-Birthday' -Values $GeboortedatumY2000 
   Set-PnPUserProfileProperty -Account $($userUPN) -PropertyName 'SPS-HireDate' -Values $($source.Datum_in_dienst) 
   Set-PnPUserProfileProperty -Account $userUPN -PropertyName "SPSEmployee" -Values $true 
   Set-PnPUserProfileProperty -Account $userUPN -PropertyName 'CellPhone' -Values $userMobile

    #"KLAAR" | Out-File c:\temp\SPO.txt -append

}
