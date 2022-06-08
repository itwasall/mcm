#!/bin/bash
batteryinfo=0
fusiondrive=0
gpuinfo=0
while getops b:f:g:h: flag
do
  case "${flag}" in:
    b) batteryinfo=1
    f) fusiondrive=1
    g) gpuinfo=1
    h) Help
  esac
done
Help()
{
  echo "Welcome to Niall's all-in-one MacOS install script"
  echo "PARAMS:"
  echo "    -b  Gets battery info. Only for devices with a battery"
  echo "    -f  Formats a fusion drive. This argument must be given otherwise" 
  echo "        MacOS will not install on fusion drive systems"
  echo "    -g  Gets GPU information. Only for devices with a GPU"
  echo "    -h  Prints this message"
  echo "Any bugs or issues please let me know"
  exit
}
if [batteryinfo -eq 1]
then
  echo "####### CYCLE COUNT #######"
  ioreg -c IOACPIPlatformDevice -rln "SMB0" | grep "Cycle Count"
  echo "####### MAX CYCLE COUNT #######"
  ioreg -c AppleSmartBattery | grep "DesignCycleCount"
  echo "####### BATTERY HEALTH #######"
  ioreg -c IOACPIPlatformDevice -rln "SMB0" | awk '{{if ($1 ~ /MaxCapacity/) maxcap=$3; else if ($1 ~ /DesignCapacity/) descap=$3} {if (maxcap != 0) {if (descap != 0) print (maxcap*100)/descap}}}' | grep -m 1 .
fi
if [gpuinfo -eq 1]
then
  echo "####### GPU #######"
fi
ioreg -c IOPCIDevice -rn "GFX0" | grep -E "model|totalMB"
echo "####### CPU #######"
sysctl -n machdep.cpu.brand_string
echo "####### RAM #######"
sysctl hw.memsize | awk '{print $2/1024/1024/1024, "GB" }'
echo "####### HDD #######"
diskutil list disk0
if [fusiondrive -eq 1]
then
  diskutil quiet resetfusion
else
  diskutil quiet erasedisk APFS "Macintosh HD" /dev/disk0
fi
diskutil quiet erasedisk APFS "Macintosh HD" /dev/disk0
echo "####### HDD FORMATTED #######"
echo "####### SERIAL NUMBER #######"
ioreg -c IOPlatformExpertDevice -r | grep "IOPlatformSerialNumber"
