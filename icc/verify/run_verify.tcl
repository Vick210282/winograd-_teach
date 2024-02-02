calibre -drc -hier G-DF-Mixed_Mode_RFCMOS18-1.8v_3.3v-1P6M-MMC-Calibre-DRC-2.14_P1
calibre -rve BaseRule.db

v2lvs -v CHIP_pr.v -l umc18_core_lvs.v -s umc18_core_lvs.spi -l umc18_io_lvs.v -sumc18_io_lvs.spi -lumc18_pad_lvs.v -s umc18_pad_lvs.spi -o source.spi -s1 VCC -s0 GND

calibre -lvs -spice layout.spi -hier -auto G-DF-MIXED_MODE_RFCMOS18-1.8V_3.3V-1P6M-MMC_CALIBRE-LVS-2.1-P8_m.txt

calibre -lvs -spice source.spi -hier -auto G-DF-MIXED_MODE_RFCMOS18-1.8V_3.3V-1P6M-MMC_CALIBRE-LVS-2.1-P8_m.txt -turbo 8
calibre -rve svdb
