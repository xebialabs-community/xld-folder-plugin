<#--

    Copyright 2017 XEBIALABS

    Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

    The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

-->

#!/bin/bash
set -e

echo "Target path is shared? ${previousDeployed.targetPathShared?c}"

FILE_TYPE=`file -i ${previousDeployed.file.path} | sed -n 's/.*: \(.*\);.*/\1/p'`

echo "The file type is: $FILE_TYPE"

if [[ $FILE_TYPE == "application/zip" ]]; then
    EXTRACT_COMMAND=`/usr/bin/unzip -lqq "${previousDeployed.file.path}" | awk '{print $4}'`
elif [[ $FILE_TYPE == "application/x-gzip" || $FILE_TYPE == "application/gzip" ]]; then
    EXTRACT_COMMAND=`/bin/tar -tvzf "${previousDeployed.file.path}" <#if previousDeployed.stripComponents gt 0>--strip-components=${previousDeployed.stripComponents}</#if> ${previousDeployed.members?join(" ")} | awk '{print $6}'`
elif [[ $FILE_TYPE == "application/x-bzip2" || $FILE_TYPE == "application/bzip2" ]]; then
    EXTRACT_COMMAND=`/bin/tar -tvjf "${previousDeployed.file.path}" <#if previousDeployed.stripComponents gt 0>--strip-components=${previousDeployed.stripComponents}</#if> ${previousDeployed.members?join(" ")} | awk '{print $6}'`
elif [[ $FILE_TYPE == "application/x-tar" || $FILE_TYPE == "application/tar" ]]; then
    EXTRACT_COMMAND=`/bin/tar -tvf "${previousDeployed.file.path}" <#if previousDeployed.stripComponents gt 0>--strip-components=${previousDeployed.stripComponents}</#if> ${previousDeployed.members?join(" ")} | awk '{print $6}'`
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
