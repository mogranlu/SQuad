#=======================================================================================
# Traverses an Outlook sub-folder and saves all the attachments to a directory on the 
# local file system.
# 
# @Author: Morten Granlund
# @Date : 22.august 2011
# @Comment: Remember to set execution rights on your host before PowerShell scripts
# 			can be run on your machine: "Set-ExecutionPolicy RemoteSigned"
#			(see: http://technet.microsoft.com/en-us/library/ee176949.aspx for details)
#=======================================================================================

Set-Variable OUTLOOK_FOLDER -option Constant -value 'Timerlister'
Set-Variable EXPORT_FOLDER -option Constant -value 'C:\temp\outlook_export'

# Get an object reference to the Outlook application, and get the inbox (contant 6).
$outlook = new-object -com Outlook.Application 
$inbox = $outlook.Session.GetDefaultFolder(6) 

# Get the list of sub-folders
$subfolderList = $inbox.Folders

# Traverse the subfolders of "Inbox", until we find the one we're after.
foreach ($nextsub in $subfolderList) {
	$folderName = $nextsub.Name
	if ($folderName -eq $OUTLOOK_FOLDER) {
		Write-Output "Found folder: $folderName !"
		Write-Output "Will try to export all attachments within this Outlook folder..."
		
		# Start the actual exports of the attachments
		foreach ($group in $nextsub.items |% {$_.attachments} | group filename) { 
			trap { 
				Write-Host "COULD NOT SAVE FILE $filename !"
				continue 
			} 
			$filename = "$EXPORT_FOLDER\$($group.Name)" 
			$group.Group[0].saveasfile($filename) 
			if ($?) {
				Write-Host Successfully saved file $filename ...
			} 
		}
	}
}

