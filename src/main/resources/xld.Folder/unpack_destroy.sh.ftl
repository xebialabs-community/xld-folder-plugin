<#--

    THIS CODE AND INFORMATION ARE PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESSED OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS
    FOR A PARTICULAR PURPOSE. THIS CODE AND INFORMATION ARE NOT SUPPORTED BY XEBIALABS.

-->
#!/bin/bash
set -e

echo "Target path is shared? ${previousDeployed.targetPathShared?c}"

FILE_TYPE=`file --mime-type -b ${previousDeployed.file.path}`

echo "The file type is: $FILE_TYPE"

if [[ $FILE_TYPE == "application/zip" ]]; then
    EXTRACT_COMMAND=`/usr/bin/unzip -lqq "${previousDeployed.file.path}" | awk '{print $4}'`
elif [[ $FILE_TYPE == "application/x-gzip" || $FILE_TYPE == "application/gzip" ]]; then
    EXTRACT_COMMAND=`/bin/tar -tvzf "${previousDeployed.file.path}" | awk '{print $6}'`
elif [[ $FILE_TYPE == "application/x-bzip2" || $FILE_TYPE == "application/bzip2" ]]; then
    EXTRACT_COMMAND=`/bin/tar -tvjf "${previousDeployed.file.path}" | awk '{print $6}'`
elif [[ $FILE_TYPE == "application/x-tar" || $FILE_TYPE == "application/tar" ]]; then
    EXTRACT_COMMAND=`/bin/tar -tvf "${previousDeployed.file.path}" | awk '{print $6}'`
fi

<#if (previousDeployed.targetPathShared)>
echo "Only deleting the files that are in the deployed folder, keeping other contents intact."
for i in $EXTRACT_COMMAND; do
    if [[ -f "${previousDeployed.targetPath}/$i" ]]; then
        echo "Deleting ${previousDeployed.targetPath}/$i"
        rm "${previousDeployed.targetPath}/$i"
    fi
done
<#else>
    echo "Delete entire targetPath as it is not shared"
    rm -rf "${previousDeployed.targetPath}"
</#if>
