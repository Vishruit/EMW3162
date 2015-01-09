#!/bin/bash

echo "Disconnect Power cable"
sudo /usr/local/bin/openocd -f ./tools/OpenOCD/BCM9WCD1EVAL1.cfg -f ./tools/OpenOCD/stm32f2x.cfg -f ./tools/OpenOCD/stm32f2x-flash-app.cfg -c "init" -c "halt" -c "flash write_image erase build/waf_bootloader-NoOS-NoNS-EMW3162-SDIO/binary/waf_bootloader-NoOS-NoNS-EMW3162-SDIO.stripped.elf" -c shutdown >&- 2>&-
echo "Connect Power cable"
sleep 5

echo "=====================Flashing main rom==================="
echo "========================================================="
sudo /usr/local/bin/openocd -f ./tools/OpenOCD/BCM9WCD1EVAL1.cfg -f ./tools/OpenOCD/stm32f2x.cfg -f ./tools/OpenOCD/stm32f2x-flash-app.cfg -c "init" -c "halt" -c "flash write_image erase build/snip_apsta-EMW3162/binary/snip_apsta-EMW3162.stripped.elf" -c shutdown || error_exit "Cannot change directory! Aborting"

set -e
echo "=====================Flashing variable rom==================="
echo "========================================================="
sleep 5
sudo /usr/local/bin/openocd -f ./tools/OpenOCD/BCM9WCD1EVAL1.cfg -f ./tools/OpenOCD/stm32f2x.cfg -f ./tools/OpenOCD/stm32f2x-flash-app.cfg -c "init" -c "halt" -c "flash write_image erase build/snip_apsta-EMW3162/DCT.stripped.elf" -c shutdown || error_exit "Cannot change directory! Aborting"
echo "=====================Flashing bootloader rom==================="
echo "========================================================="
sleep 5
sudo /usr/local/bin/openocd -f ./tools/OpenOCD/BCM9WCD1EVAL1.cfg -f ./tools/OpenOCD/stm32f2x.cfg -f ./tools/OpenOCD/stm32f2x-flash-app.cfg -c "init" -c "halt" -c "flash write_image erase build/waf_bootloader-NoOS-NoNS-EMW3162-SDIO/binary/waf_bootloader-NoOS-NoNS-EMW3162-SDIO.stripped.elf" -c shutdown || error_exit "Cannot change directory! Aborting"

