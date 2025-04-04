5 REM COPYRIGHT 2024 EIRIK STOPLE
10 PRINT "DUMP SMC BOOTLOADER TO $7E00-$7FFF"
20 OFFSET=$1E00
21 RAM=$7E00
24 REM SET SMC PAGE TO BOOTLOADER (120)
25 I2CPOKE $42,$90,120
30 REM START A NEW LINE
40 IF OFFSET < 256 THEN PRINT "00";
50 PRINT HEX$(OFFSET) " ";
60 FOR I=0 TO 15
65 BYTE=I2CPEEK($42,$91)
68 POKE RAM,BYTE
70 PRINT " " HEX$(BYTE);
80 RAM=RAM+1
90 NEXT
100 PRINT " "
110 OFFSET = OFFSET + 16
120 IF OFFSET < 8192 GOTO 40
125 GOSUB 1000
130 PRINT "DUMPED TO $7E00-$7FFF"
140 PRINT "DUMP TO SD CARD WITH THE COMMAND"
150 PRINT "BSAVE " CHR$($22) "DUMPSMC.BIN" CHR$($22) ",8,1,$7E00,$8000"
151 GOSUB 2000
160 END
1000 REM COMPUTE AND EVALUATE CHECKSUM FROM 7E00 TO 7FFF
1010 POKE 2,0
1020 POKE 3,$7E
1030 POKE 4,0
1040 POKE 5,2
1050 SYS $FEEA
1060 CRC16 = PEEK(7) * 256 + PEEK(6)
1070 PRINT "CRC-16: $" HEX$(CRC16) " ";
1080 IF CRC16 = $19B5 THEN PRINT "BOOTLOADER V1":RETURN
1090 IF CRC16 = $15C7 THEN PRINT "BOOTLOADER V2":RETURN
1100 IF CRC16 = $7594 THEN PRINT "BOOTLOADER V2 (BAD)":RETURN
1101 IF CRC16 = $4DA7 THEN PRINT "BOOTLOADER V3P0 (222654)":RETURN
1102 IF CRC16 = $0CD0 THEN PRINT "BOOTLOADER V3P1 (8B70F5)":RETURN
1103 IF CRC16 = $34C7 THEN PRINT "BOOTLOADER V3P2 (A9A75F)":RETURN
1104 IF CRC16 = $B135 THEN PRINT "BOOTLOADER V3P3 (06E330)":RETURN
1105 IF CRC16 = $6222 THEN PRINT "BOOTLOADER V3P4 (08A724)":RETURN
1106 IF CRC16 = $C340 THEN PRINT "BOOTLOADER V3P5 (952878)":RETURN
1107 IF CRC16 = $BC21 THEN PRINT "BOOTLOADER V3P6 (BCF522)":RETURN
1108 IF CRC16 = $BF63 THEN PRINT "BOOTLOADER V3":RETURN
1110 IF CRC16 = $6995 THEN PRINT "BOOTLOADER MISSING":RETURN
1120 PRINT "CRC-16 NOT RECOGNIZED":RETURN
2000 PRINT "BOOT V3 FAILSAFE: ";
2010 REM DUMP RESET VECTOR
2020 REM SET SMC PAGE TO START (0)
2030 I2CPOKE $42,$90,0
2040 LO=I2CPEEK($42,$91)
2050 HI=I2CPEEK($42,$91)
2060 IF LO <> $FF GOTO 2200
2070 IF HI <> $CE GOTO 2200
2080 PRINT "INSTALLED"
2090 PRINT "NB: DO NOT INSTALL OLDER BOOTLOADER THAN V3"
2100 RETURN
2200 PRINT "NOT INSTALLED"
2210 RETURN
