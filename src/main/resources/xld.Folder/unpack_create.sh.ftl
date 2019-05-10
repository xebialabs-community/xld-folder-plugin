<#--

    Copyright 2019 XEBIALABS

    Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

    The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

-->
#!/bin/bash
set -e

# "file -i -b" output example is "text/plain; charset=us-ascii", so piping into sed to extract only the mime type portion of the output (text/plain)
FILE_TYPE=`file -i -b ${deployed.file.path} | sed -n 's/\(.*\);.*/\1/p'`

echo "The file type is $FILE_TYPE"
mkdir -p ${deployed.targetPath}

if [[ $FILE_TYPE == "application/zip" ]]; then
    /usr/bin/unzip -o "${deployed.file.path}" -d "${deployed.targetPath}"
elif [[ $FILE_TYPE == "application/x-gzip" || $FILE_TYPE == "application/gzip" ]]; then
    /bin/tar -xvz -C "${deployed.targetPath}" -f "${deployed.file.path}" <#if deployed.stripComponents gt 0>--strip-components=${deployed.stripComponents}</#if> ${deployed.members?join(" ")}
elif [[ $FILE_TYPE == "application/x-bzip2" || $FILE_TYPE == "application/bzip2" ]]; then
    /bin/tar -xvj -C "${deployed.targetPath}" -f "${deployed.file.path}" <#if deployed.stripComponents gt 0>--strip-components=${deployed.stripComponents}</#if> ${deployed.members?join(" ")}
elif [[ $FILE_TYPE == "application/x-tar" || $FILE_TYPE == "application/tar" ]]; then
    /bin/tar -xv -C "${deployed.targetPath}" -f "${deployed.file.path}" <#if deployed.stripComponents gt 0>--strip-components=${deployed.stripComponents}</#if> ${deployed.members?join(" ")}
fi
