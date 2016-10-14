function Expand-ZIPFile($file, $destination) {
   Write-Host 'unzip $deployed.file to $deployed.targetPath'
   $shell = new-object -com shell.application
   $zip = $shell.NameSpace($file)
   foreach($item in $zip.items()) {
      $shell.Namespace($destination).copyhere($item)
   }
}


$targetFolder = $deployed.targetPath
$filePath = $deployed.file

#Create parent folder
if(!(Test-Path $targetFolder)) {
	write-output "Creating location $targetFolder ..."
	New-Item -Path $targetFolder -ItemType "directory" -force
}

if (Test-Path($($deployed.file))) {
  #Go to the target location
  Set-Location $targetFolder

  #Extract from zipfile.
  Write-Host "Extracting zip from [$($deployed.file)]."
  Expand-ZIPFile $deployed.file $targetFolder
}