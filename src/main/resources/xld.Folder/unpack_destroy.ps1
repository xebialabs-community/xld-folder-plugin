if ($previousDeployed.targetPathShared) {
	Write-Host "Only deleting the files that are in the deployed folder, keeping other contents intact."
	$shell = new-object -com shell.application
	$zip = $shell.NameSpace($previousDeployed.file)
	foreach($item in $zip.items()) {
	  $toBeRemoved = $($previousDeployed.targetPath) + $($item.path.substring($previousDeployed.file.length))
	  Write-Host "Deleting $toBeRemoved"
	  if (Test-Path $toBeRemoved) {
      	Remove-Item $toBeRemoved -Recurse
      }
   	}
}
else {
    Write-Host "Delete entire targetPath as it is not shared"
    Remove-Item $previousDeployed.targetPath
}