#!/bin/bash
echo "####### CYCLE COUNT #######"
ioreg -c IOACPIPlatformDevice -rln "SMB0" | grep "Cycle Count"
echo "####### GPU #######"
ioreg -c IOPCIDevice -rn "GFX0" | grep "model"
echo "####### CPU #######"
sysctl -n machdep.cpu.brand_string
echo "####### RAM #######"
sysctl hw.memsize
echo "####### HDD #######"
diskutil list disk0
diskutil erasedisk APFS "Macintosh HD" /dev/disk0
echo "####### HDD FORMATTED #######"
echo "####### SERIAL NUMBER #######"
ioreg -c IOPlatformExpertDevice -r | grep "IOPlatformSerialNumber"
