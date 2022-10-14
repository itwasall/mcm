#!/bin/bash

option_argument=$1
 case $option_argument in
    i) 
       echo "####### GPU #######"
       ioreg -c IOPCIDevice -w0 -rn "GFX0" | grep -E "model|totalMB"
       echo "####### CPU #######"
       sysctl -n machdep.cpu.brand_string
       echo "####### RAM #######"
       sysctl hw.memsize | awk '{print $2/1024/1024/1024, "GB" }'
       echo "####### HDD #######"
       diskutil list /dev/disk0 | awk '{print $2 " GB"}' | sed -n '3 p'
       echo "####### SERIAL NUMBER #######"
       ioreg -c IOPlatformExpertDevice -r | grep "IOPlatformSerialNumber"
       echo;;
    r) diskutil resetfusion;;
    a) diskutil erasedisk APFS "Macintosh HD" /dev/disk0;;
    j) diskutil erasedisk JFHS+ "Macintosh HD" /dev/disk0;;
    m) /Install\ macOS\ Monterey.app/Contents/Resources/startosinstall --agreetolicense --volume /Volumes/Macintosh\ HD
       echo;;
    b) /Install\ macOS\ Big\ Sur.app/Contents/Resources/startosinstall --agreetolicense --volume /Volumes/Macintosh\ HD
       echo;;
    c) /Install\ macOS\ Catalina.app/Contents/Resources/startosinstall --aggretolicense --volume /Volumes/Macintosh\ HD
       echo;;
    e) /Install\ macOS\ El\ Captiain.app/Contents/Resources/startosinstall --volume /Volumes/Macintosh\ HD --applicationpath /Install\ macOS\ El\ Captain.app
       echo;;
    t)
       sysctl -n machdep.cpu.brand_string
       sysctl hw.memsize | awk '{print $2/1024/1024/1024, "GB"}'
       ioreg -rc IOPCIDevice | grep -E "model|VRAM"
       system_profiler SPPowerDataType | grep -E "Count|Condition"
       echo;;
       
  esac
done
