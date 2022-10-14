#!/bin/bash

option_argument=$1
 case $option_argument in
    i) echo "####### CYCLE COUNT #######"
       ioreg -c IOACPIPlatformDevice -rln "SMB0" | grep "Cycle Count"
       echo "####### MAX CYCLE COUNT #######"
       ioreg -c AppleSmartBattery | grep "DesignCycleCount"
       echo "####### BATTERY HEALTH #######"
       ioreg -c IOACPIPlatformDevice -rln "SMB0" | awk '{{if ($1 ~ /MaxCapacity/) maxcap=$3; else if ($1 ~ /DesignCapacity/) descap=$3} {if (maxcap != 0) {if (descap != 0) print (maxcap*100)/descap}}}' | grep -m 1 .
       echo "####### GPU #######"
       ioreg -c IOPCIDevice -w0 -rn "GFX0" | grep -E "model|totalMB"
       echo "####### CPU #######"
       sysctl -n machdep.cpu.brand_string
       echo "####### RAM #######"
       sysctl hw.memsize | awk '{print $2/1024/1024/1024, "GB" }'
       echo "####### HDD #######"
       diskutil list disk0
       echo "####### SERIAL NUMBER #######"
       ioreg -c IOPlatformExpertDevice -r | grep "IOPlatformSerialNumber"
       echo;;
    r) diskutil resetfusion;;
    a) diskutil erasedisk APFS "Macintosh HD" /dev/disk0
    j) diskutil erasedisk JFHS+ "Macintosh HD" /dev/disk0
    m) /Install\ macOS\ Monterey.app/Contents/Resources/startosinstall --agreetolicense --volume /Volumes/Macintosh\ HD
       echo;;
    b) /Install\ macOS\ Big\ Sur.app/Contents/Resources/startosinstall --agreetolicense --volume /Volumes/Macintosh\ HD
       echo;;
    c) /Install\ macOS\ Catalina.app/Contents/Resources/startosinstall --aggretolicense --volume /Volumes/Macintosh\ HD
       echo;;
    e) /Install\ macOS\ El\ Captiain.app/Contents/Resources/startosinstall --volume /Volumes/Macintosh\ HD --applicationpath /Install\ macOS\ El\ Captain.app
       echo;;
  esac
done
