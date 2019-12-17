<#
#### requires ps-version 5.1 ####

.DESCRIPTION
Simple script to modify the manager in an ActiveRoles Workflow. (The first and 
last name of the manager is written in an attribute) (Extensionattribute12)

.REQUIREMENTS
OneIdentity Active Roles

.NOTES
   Version:        0.1
   Author:         Maarten Schmeitz
   Creation Date:  Tuesday, December 17th 2019, 3:17:43 pm
   File: ModifyManager.ps1
   Copyright (c) 2019 Advantive

HISTORY:
Date      	          By	Comments
----------	          ---	----------------------------------------------------------
17/12/2019            MSCH  Inital Version

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
                $ManagerFirstLast = $(Get-QADUser -Identity $Request.DN -Properties * | Select-Object extensionAttribute12)
                $NewManager = $managerFirstLast.extensionAttribute12
                $NewManagerDN =  $(Get-QADUser -identity $NewManager).dn
                Set-qaduser -identity $Request.DN -Manager $NewManagerDN        
        }
        
