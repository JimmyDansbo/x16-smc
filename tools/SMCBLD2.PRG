#  COPYRIGHT 2024 EIRIK STOPLE I
  "DUMP SMC FLASH TO $7E00-$7FFF" Z OFFSET²$1E00 h RAM²$7E00   SET SMC PAGE TO BOOTLOADER (120) ¢ Î® $42,$90,120 ¹  START A NEW LINE Ö(  OFFSET ³ 256 §  "00"; ì2  ÎÕ(OFFSET) " "; û<  I²0 ¤ 15 	A BYTE²Î×($42,$91) 	D  RAM,BYTE 3	F  " " ÎÕ(BYTE); A	P RAM²RAMª1 G	Z  Q	d  " " j	n OFFSET ² OFFSET ª 16 	x  OFFSET ³ 8192  40 	}  1000 ¬	  "DUMPED TO $7E00-$7FFF" Õ	  "DUMP TO SD CARD WITH THE COMMAND" 
  "BSAVE " Ç($22) "DUMPSMC.BIN" Ç($22) ",8,1,$7E00,$7FFF" 
   O
è COMPUTE AND EVALUATE CHECKSUM FROM 7E00 TO 7FFF Y
ò 2,0 e
ü 3,$7E o
 4,0 y
 5,2 
 $FEEA £
$CRC16 ² Â(7) ¬ 256 ª Â(6) Ä
. "CRC-16: $" ÎÕ(CRC16) " "; î
8 CRC16 ² $19B5 §  "BOOTLOADER V1": B CRC16 ² $15C7 §  "BOOTLOADER V2": HL CRC16 ² $7594 §  "BOOTLOADER V2 (BAD)": wV CRC16 ² $6995 §  "BOOTLOADER MISSING": ` "CRC-16 NOT RECOGNIZED":   