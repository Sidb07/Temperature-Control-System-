ORG 0000H   
MOV P0, #0FFH 
SJMP HERE

COMMAND: MOV P2, R3
         CLR P1.0
         CLR P1.1
         SETB P1.2
         ACALL DELAY 
         CLR P1.2
         ACALL DELAY
         RET
DISPLAY: 
         MOV P2, R3
         SETB P1.0
         CLR P1.1
         SETB P1.2
         LCALL DELAY
         CLR P1.2
         RET

DELAY:   MOV R0,#100
   L1:   MOV R1,#100
   HE:   DJNZ R1,HE
         DJNZ R0,L1
         RET    

HERE:   MOV R3, #38H
        ACALL COMMAND
        MOV R3,#0EH
        ACALL COMMAND
        MOV R3,#01H
        ACALL COMMAND
        MOV R3,#06H
        ACALL COMMAND
        MOV R3,#80H
        ACALL COMMAND
        MOV A, P0
        MOV B, #2
        MUL AB
        CJNE A, #27, NOTEQ
NOTEQ:  JNC A_GREATER

A_LESS: CLR P1.7
        SJMP ENDCMP

A_GREATER: SETB P1.7
        SJMP ENDCMP

ENDCMP: MOV R3, #'T'
        ACALL DISPLAY
        MOV R3, #'E'
        ACALL DISPLAY
        MOV R3, #'M'
        ACALL DISPLAY
        MOV R3, #'P'
        ACALL DISPLAY
        MOV R3, #':'
        ACALL DISPLAY
        MOV A, P0
        MOV B, #2
        MUL AB
        MOV B, #10
        DIV AB
        ADD A, #48
        MOV R3, A
        ACALL DISPLAY
        MOV A, B
        ADD A, #48
        MOV R3, A
        ACALL DISPLAY
        MOV R3, #'°'
        ACALL DISPLAY
        MOV R3, #'C'
        ACALL DISPLAY
        ACALL DELAY
        SJMP HERE
        RET
END