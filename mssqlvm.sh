#!/usr/bin/env bash

set -o nounset
set -o errtrace
set -o errexit
set -o pipefail

log()  { printf "$*\n" ; return $? ;  }

mssqlvm_home="${HOME}/.mssqlvm"

log "Install WinXP and enable guest control"
curl -s https://raw.github.com/xdissent/ievms/master/ievms.sh | REUSE_XP="yes" IEVMS_VERSIONS="7" INSTALL_PATH="${mssqlvm_home}" bash

# folder has been created by ievms
cd "${mssqlvm_home}"

vm="IE7 - WinXP"

log "Configure network adapter"
VBoxManage modifyvm "${vm}" --nic2 hostonly
VBoxManage modifyvm "${vm}" --hostonlyadapter2 vboxnet0

log "Enable bidirectional clipboard"
VBoxManage modifyvm "${vm}" --clipboard bidirectional

log "Downloading 7-zip"
curl -L http://sourceforge.net/projects/sevenzip/files/7-Zip/9.22/7z922.exe/download -o 7z922.exe

log "Downloading curl"
curl -L -O http://curl.haxx.se/gknw.net/7.29.0/dist-w32/curl-7.29.0-rtmp-ssh2-ssl-sspi-zlib-idn-static-bin-w32.zip

log "Downloading mssql-setup.bat"
curl -L -O https://raw.github.com/twr/mssqlvm/master/mssql-setup.bat

log "Starting ${vm}"
VBoxManage startvm "${vm}"

sleep_wait="10"
guest_loc="/Documents and Settings/IEUser/Desktop"

log "Waiting for ${vm} to be available for guestcontrol..."
x="1" ; until [ "${x}" == "0" ]; do
  sleep "${sleep_wait}"
  VBoxManage guestcontrol "${vm}" cp `pwd`"/7z922.exe" "${guest_loc}/7z922.exe" --username IEUser --dryrun && x=$? || x=$?
done

sleep "${sleep_wait}"

log "Copying files to the VM"
VBoxManage guestcontrol "${vm}" cp `pwd`"/7z922.exe" "${guest_loc}/7z922.exe" --username IEUser
VBoxManage guestcontrol "${vm}" cp `pwd`"/curl-7.29.0-rtmp-ssh2-ssl-sspi-zlib-idn-static-bin-w32.zip" "${guest_loc}/curl-7.29.0-rtmp-ssh2-ssl-sspi-zlib-idn-static-bin-w32.zip" --username IEUser
VBoxManage guestcontrol "${vm}" cp `pwd`"/mssql-setup.bat" "${guest_loc}/mssql-setup.bat" --username IEUser

log "Setting up database on the VM"
VBoxManage guestcontrol "${vm}" exec --image "${guest_loc}/mssql-setup.bat" --username IEUser --wait-exit
