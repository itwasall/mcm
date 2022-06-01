#! /bin/bash
ioreg -c IOACPIPlatformDevice -rln "SMB0" | grep "Capacity"
ioreg -c IOPCIDevice -rn "GFX0" | grep "model"
sysctl -n machdep.cpu.brand_string
sysctl hw.memsize
