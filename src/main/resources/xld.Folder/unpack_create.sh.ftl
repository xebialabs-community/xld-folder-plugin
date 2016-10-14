<#--

    THIS CODE AND INFORMATION ARE PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESSED OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS
    FOR A PARTICULAR PURPOSE. THIS CODE AND INFORMATION ARE NOT SUPPORTED BY XEBIALABS.

-->
#!/bin/bash
set -e

FILE_TYPE=`file --mime-type -b ${deployed.file.path}`

echo "The file type is $FILE_TYPE"

if [[ $FILE_TYPE == "application/zip" ]]; then
    /usr/bin/unzip -o "${deployed.file.path}" -d "${deployed.targetPath}"
elif [[ $FILE_TYPE == "application/x-gzip" || $FILE_TYPE == "application/gzip" ]]; then
    /bin/tar -xvz -C "${deployed.targetPath}" -f "${deployed.file.path}"
elif [[ $FILE_TYPE == "application/x-bzip2" || $FILE_TYPE == "application/bzip2" ]]; then
    /bin/tar -xvj -C "${deployed.targetPath}" -f "${deployed.file.path}"
elif [[ $FILE_TYPE == "application/x-tar" || $FILE_TYPE == "application/tar" ]]; then
    /bin/tar -xv -C "${deployed.targetPath}" -f "${deployed.file.path}"
fi
