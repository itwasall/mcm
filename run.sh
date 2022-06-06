#!/bin/bash
echo "####### CYCLE COUNT #######"
ioreg -c IOACPIPlatformDevice -rln "SMB0" | grep "Cycle Count" | awk '{i=0;while($i !~ /Cycle Count/) i++; print $i}'
echo "####### GPU #######"
ioreg -c IOPCIDevice -rn "GFX0" | grep "model"
echo "####### CPU #######"
sysctl -n machdep.cpu.brand_string
echo "####### RAM #######"
sysctl hw.memsize | awk '{ mem_bytes=0; print mem_bytes/1024/1024/1024, "GB" }'
echo "####### HDD #######"
diskutil list disk0
diskutil quiet erasedisk APFS "Macintosh HD" /dev/disk0
echo "####### HDD FORMATTED #######"
echo "####### SERIAL NUMBER #######"
ioreg -c IOPlatformExpertDevice -r | grep "IOPlatformSerialNumber"
