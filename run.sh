#!/bin/bash
ioreg -c IOACPIPlatformDevice -rln "SMB0" | grep "Cycle Count"
ioreg -c IOPCIDevice -rn "GFX0" | grep "model"
sysctl -n machdep.cpu.brand_string
sysctl hw.memsize

echo "Press key to format disk"
while [true] ; do
read -t 3 -n 1
if [$? = 0 ] ; then
diskutil erasedisk APFS "Macintosh HD" /dev/disk0
exit ;
else
echo "waiting for keypresss"
fi 
done