LCDdatabus              equ     0A0H
LCDrs                   equ     0A2H
LCDen                   equ     0A3H
LCDreg                  equ     30h
delreg1                 equ     31h
delreg2                 equ     32h
delreg3                 equ     33h

LCDtempreg              equ     34H
Reg_LCD_swap1           EQU     35h
Reg_LCD_swap2           EQU     36h

Reg_Test                equ     37H
Reggsmdot               equ     38H

Reg_GPS11               equ     51H
Reg_GPS12               equ     52H
Reg_GPS13               equ     53H
Reg_GPS14               equ     54H
Reg_GPS15               equ     55H
Reg_GPS16               equ     56H
Reg_GPS17               equ     57H
Reg_GPS18               equ     58H
Reg_GPS19               equ     59H
Reg_GPS1A               equ     5AH
Reg_GPS1B               equ     5BH

Reg_GPS21               equ     61H
Reg_GPS22               equ     62H
Reg_GPS23               equ     63H
Reg_GPS24               equ     64H
Reg_GPS25               equ     65H
Reg_GPS26               equ     66H
Reg_GPS27               equ     67H
Reg_GPS28               equ     68H
Reg_GPS29               equ     69H
Reg_GPS2A               equ     6AH
Reg_GPS2B               equ     6BH
Reg_GPS2C               equ     6CH
                        org 0000h
                        call initialisation
start:                  call read_GPS
                        call display_GPS
                        call delay2sec

                        jb 01H,send_invalid_sms

                        call send_sms_all

                        jmp start

send_invalid_sms:
                        call send_sms_invalid
                        jmp start
;=========================================================
display_GPS_ret:        mov dptr,#msgGPSinvalid1
                        call LCDdisp
                        call delay1sec
                        ret

display_GPS:
                jb 01H,display_GPS_ret
                mov dptr,#msgGPSdisplay
                call LCDdisp
                mov LCDtempreg,#83H
                call LCDcmd
                mov LCDtempreg,Reg_GPS11
                call LCDdata
                mov LCDtempreg,Reg_GPS12
                call LCDdata
                mov LCDtempreg,Reg_GPS13
                call LCDdata
                mov LCDtempreg,Reg_GPS14
                call LCDdata
                mov LCDtempreg,Reg_GPS15
                call LCDdata
                mov LCDtempreg,Reg_GPS16
                call LCDdata
                mov LCDtempreg,Reg_GPS17
                call LCDdata
                mov LCDtempreg,Reg_GPS18
                call LCDdata
                mov LCDtempreg,Reg_GPS19
                call LCDdata
                mov LCDtempreg,Reg_GPS1A
                call LCDdata
                mov LCDtempreg,Reg_GPS1B
                call LCDdata

                mov LCDtempreg,#C3H
                call LCDcmd
                mov LCDtempreg,Reg_GPS21
                call LCDdata
                mov LCDtempreg,Reg_GPS22
                call LCDdata
                mov LCDtempreg,Reg_GPS23
                call LCDdata
                mov LCDtempreg,Reg_GPS24
                call LCDdata
                mov LCDtempreg,Reg_GPS25
                call LCDdata
                mov LCDtempreg,Reg_GPS26
                call LCDdata
                mov LCDtempreg,Reg_GPS27
                call LCDdata
                mov LCDtempreg,Reg_GPS28
                call LCDdata
                mov LCDtempreg,Reg_GPS29
                call LCDdata
                mov LCDtempreg,Reg_GPS2A
                call LCDdata
                mov LCDtempreg,Reg_GPS2B
                call LCDdata
                mov LCDtempreg,Reg_GPS2C
                call LCDdata

                ret
;=========================================================
; $GPRMC, 102128.000, A, 1838.6543, N, 07345.3324, E, 0.00, , 021012, , , A*7D
read_GPS_ret11:
read_GPS:
                jnb ri,$
                clr ri
                mov a,sbuf
                cjne a,#'$',read_GPS_ret11        ; $GPRMC, 102128.000, A, 1838.6543, N, 07345.3324, E, 0.00, , 021012, , , A*7D

                mov Reg_Test,#'1'

                jnb ri,$
                clr ri
                mov a,sbuf
                cjne a,#'G',read_GPS_ret11        ; $GPRMC, 102128.000, A, 1838.6543, N, 07345.3324, E, 0.00, , 021012, , , A*7D

                mov Reg_Test,#'2'

                jnb ri,$
                clr ri
                mov a,sbuf
                cjne a,#'P',read_GPS_ret11        ; $GPRMC, 102128.000, A, 1838.6543, N, 07345.3324, E, 0.00, , 021012, , , A*7D

                mov Reg_Test,#'3'

                jnb ri,$
                clr ri
                mov a,sbuf
                cjne a,#'R',read_GPS_ret11        ; $GPRMC, 102128.000, A, 1838.6543, N, 07345.3324, E, 0.00, , 021012, , , A*7D

                mov Reg_Test,#'4'

                jnb ri,$
                clr ri
                mov a,sbuf
                cjne a,#'M',read_GPS_ret11        ; $GPRMC, 102128.000, A, 1838.6543, N, 07345.3324, E, 0.00, , 021012, , , A*7D

                mov Reg_Test,#'5'

                jnb ri,$
                clr ri
                mov a,sbuf
                cjne a,#'C',read_GPS_ret11        ; $GPRMC, 102128.000, A, 1838.6543, N, 07345.3324, E, 0.00, , 021012, , , A*7D

                mov Reg_Test,#'6'

                jnb ri,$                        ; $GPRMC,102128.000, A, 1838.6543, N, 07345.3324, E, 0.00, , 021012, , , A*7D
                clr ri
                jnb ri,$
                clr ri
                jnb ri,$
                clr ri
                jnb ri,$
                clr ri
                jnb ri,$
                clr ri
                jnb ri,$
                clr ri
                jnb ri,$
                clr ri
                jnb ri,$
                clr ri
                jnb ri,$
                clr ri
                jnb ri,$
                clr ri
                jnb ri,$
                clr ri
                jnb ri,$                        ; $GPRMC,102128.000, A, 1838.6543, N, 07345.3324, E, 0.00, , 021012, , , A*7D
                clr ri

                jnb ri,$
                clr ri
                mov a,sbuf
                cjne a,#'A',read_GPS_invalid    ;$GPRMC,102128.000,A,1838.6543,N,07345.3324,E,0.00,,021012,,,A*7D

                mov Reg_Test,#'7'

                jmp read_GPS_Next
                
read_GPS_invalid:
                setb 01H
                mov dptr,#msgGPSinvalid
                call LCDdisp
                call delay2sec
                ret

read_GPS_Next:
                jnb ri,$
                clr ri

                jnb ri,$
                clr ri
                mov a,sbuf
                mov Reg_GPS11,a                 ;$GPRMC,102128.000,A,1838.6543,N,07345.3324,E,0.00,,021012,,,A*7D

                jnb ri,$
                clr ri
                mov a,sbuf
                mov Reg_GPS12,a

                jnb ri,$
                clr ri
                mov a,sbuf
                mov Reg_GPS13,a

                jnb ri,$
                clr ri
                mov a,sbuf
                mov Reg_GPS14,a

                jnb ri,$
                clr ri
                mov a,sbuf
                mov Reg_GPS15,a

                jnb ri,$
                clr ri
                mov a,sbuf
                mov Reg_GPS16,a

                jnb ri,$
                clr ri
                mov a,sbuf
                mov Reg_GPS17,a

                jnb ri,$
                clr ri
                mov a,sbuf
                mov Reg_GPS18,a

                jnb ri,$
                clr ri
                mov a,sbuf
                mov Reg_GPS19,a         ;$GPRMC,102128.000,A,1838.6543,N,07345.3324,E,0.00,,021012,,,A*7D

                jnb ri,$
                clr ri
                mov a,sbuf
                mov Reg_GPS1A,a         ;$GPRMC,102128.000,A,1838.6543,N,07345.3324,E,0.00,,021012,,,A*7D

                jnb ri,$
                clr ri
                mov a,sbuf
                mov Reg_GPS1B,a         ;$GPRMC,102128.000,A,1838.6543,N,07345.3324,E,0.00,,021012,,,A*7D

;1838.6543,N,07345.3324,E

                jnb ri,$
                clr ri


                jnb ri,$
                clr ri
                mov a,sbuf
                mov Reg_GPS21,a                 ;$GPRMC,102128.000,A,1838.6543,N,07345.3324,E,0.00,,021012,,,A*7D

                jnb ri,$
                clr ri
                mov a,sbuf
                mov Reg_GPS22,a

                jnb ri,$
                clr ri
                mov a,sbuf
                mov Reg_GPS23,a

                jnb ri,$
                clr ri
                mov a,sbuf
                mov Reg_GPS24,a

                jnb ri,$
                clr ri
                mov a,sbuf
                mov Reg_GPS25,a

                jnb ri,$
                clr ri
                mov a,sbuf
                mov Reg_GPS26,a

                jnb ri,$
                clr ri
                mov a,sbuf
                mov Reg_GPS27,a

                jnb ri,$
                clr ri
                mov a,sbuf
                mov Reg_GPS28,a

                jnb ri,$
                clr ri
                mov a,sbuf
                mov Reg_GPS29,a         ;$GPRMC,102128.000,A,1838.6543,N,07345.3324,E,0.00,,021012,,,A*7D

                jnb ri,$
                clr ri
                mov a,sbuf
                mov Reg_GPS2A,a         ;$GPRMC,102128.000,A,1838.6543,N,07345.3324,E,0.00,,021012,,,A*7D

                jnb ri,$
                clr ri
                mov a,sbuf
                mov Reg_GPS2B,a         ;$GPRMC,102128.000,A,1838.6543,N,07345.3324,E,0.00,,021012,,,A*7D

                jnb ri,$
                clr ri
                mov a,sbuf
                mov Reg_GPS2C,a         ;$GPRMC,102128.000,A,1838.6543,N,07345.3324,E,0.00,,021012,,,A*7D

                mov Reg_Test,#'8'

                clr 01H

;1838.6543,N,07345.3324,E,0.00,,021012,,,A*7D

read_GPS_ret:
                ret
;=========================================================
initialisation:
                call LCDinit

                mov Reg_Test,#'0'

                clr 01H

                mov Reg_GPS11,#'_'
                mov Reg_GPS12,#'_'
                mov Reg_GPS13,#'_'
                mov Reg_GPS14,#'_'
                mov Reg_GPS15,#'_'
                mov Reg_GPS16,#'_'
                mov Reg_GPS17,#'_'
                mov Reg_GPS18,#'_'
                mov Reg_GPS19,#'_'
                mov Reg_GPS1A,#'_'
                mov Reg_GPS1B,#'_'

                mov Reg_GPS21,#'_'
                mov Reg_GPS22,#'_'
                mov Reg_GPS23,#'_'
                mov Reg_GPS24,#'_'
                mov Reg_GPS25,#'_'
                mov Reg_GPS26,#'_'
                mov Reg_GPS27,#'_'
                mov Reg_GPS28,#'_'
                mov Reg_GPS29,#'_'
                mov Reg_GPS2A,#'_'
                mov Reg_GPS2B,#'_'
                mov Reg_GPS2C,#'_'

                mov scon,#50h
                mov tmod,#21h
                mov th1,#fah
                mov tl1,#fah
                setb tr1

                mov dptr,#msgwelcome
                call LCDdisp


                        call delay2sec

                        mov dptr,#msggsminit
                        call LCDdisp
        
                        mov LCDtempreg,#0C4H
                        call LCDcmd
        
                        mov Reggsmdot,#11
gsm_init_dot:           call display_dot
                        call delay1sec
                        djnz Reggsmdot,gsm_init_dot
        
                        mov dptr,#msgpoweron1
                        call LCDdisp
        
                        call Poweron_SMS2
                        call Poweron_SMS1
        
                        mov dptr,#msgpoweron2
                        call LCDdisp
                        call delay2sec

                        ret
;=========================================================

LCDinit:
                call delayhalf
                mov LCDtempreg,#02h
                call LCDcmd
                mov LCDtempreg,#28h
                call LCDcmd
                mov LCDtempreg,#0Ch
                call LCDcmd
                mov LCDtempreg,#06h
                call LCDcmd
                mov LCDtempreg,#01h
                call LCDcmd
                ret
;========================================================================
LCDcmd:
                mov Reg_LCD_swap1,LCDtempreg

                mov Reg_LCD_swap2,Reg_LCD_swap1

                mov a,Reg_LCD_swap2
                anl a,#F0H
                mov LCDdatabus,a

                clr LCDrs
                setb LCDen
                
                
                clr LCDen
                call LCDdelay

                mov a,Reg_LCD_swap2
                swap a
                anl a,#F0H
                mov LCDdatabus,a

                clr LCDrs
                setb LCDen
                
                
                clr LCDen
                call LCDdelay

                ret               
;========================================================================
LCDdata:
                mov Reg_LCD_swap1,LCDtempreg

                mov Reg_LCD_swap2,Reg_LCD_swap1

                mov a,Reg_LCD_swap2
                anl a,#F0H
                mov LCDdatabus,a

                setb LCDrs
                setb LCDen
                
                
                clr LCDen
                call LCDdelay

                mov a,Reg_LCD_swap2
                swap a
                anl a,#F0H
                mov LCDdatabus,a


                setb LCDrs
                setb LCDen
                
                
                clr LCDen
                call LCDdelay

                ret
;========================================================================
;=========================================================
LCDdelay        mov delreg1,#10             ;LCD
LCDdelay1       mov delreg2,#250
                djnz delreg1,$
                djnz delreg2,LCDdelay1
                ret
;=========================================================
LCDdisp:        mov LCDtempreg,#01h
                call LCDcmd
                mov LCDreg,#00h
LCDdisp2        mov a,LCDreg
                movc a,@a+dptr
                cjne a,#'@',LCDdisp1
                mov LCDtempreg,#c0h
                call LCDcmd
                inc LCDreg
                jmp LCDdisp2
LCDdisp1        cjne a,#'$',LCDdisp3
                ret
LCDdisp3        mov LCDtempreg,a
                call LCDdata
                inc LCDreg
                jmp LCDdisp2
;=======================================================================
delayhalf       mov delreg1,#5
delhalf2        mov delreg2,#200
delhalf1        mov delreg3,#250
                djnz delreg3,$
                djnz delreg2,delhalf1
                djnz delreg1,delhalf2
                ret
;=========================================================
delay1sec       mov delreg1,#10
del1sec2        mov delreg2,#200
del1sec1        mov delreg3,#250
                djnz delreg3,$
                djnz delreg2,del1sec1
                djnz delreg1,del1sec2
                ret
;=========================================================
delay2sec:      call delay1sec
                call delay1sec
                ret
;=========================================================
;=======================================================================
Poweron_SMS1:           mov LCDtempreg,#0C4H
                        call LCDcmd
                        call display_dot
        
                        call Send_SMS_Part_1
                        mov dptr,#shriganesha   ;> SHRI GANESHAY NAMAH|
                        call Send_SMS_Part_2
                        ret
;=========================================================================
Poweron_SMS2:           mov LCDtempreg,#0C4H
                        call LCDcmd
                        call display_dot
        
                        call AT_at1310
                        call AT_atcmgf1         ;AT+CMGF=1
                        call AT_atcmgs_no_2       ;;AT+CMGS="9860119860"
                        mov dptr,#shriganesha   ;> SHRI GANESHAY NAMAH||
                        call Send_SMS_Part_2
                        ret
;=========================================================================
AT_at1310:              call delay1sec
                        call delay1sec
                        mov LCDtempreg,#0CBH
                        call LCDcmd
                        call display_dot
        
                        mov dptr,#SMS_AT_at1310
                        call SMS_GSM_int
        
;                       jnb ri,$
;                       clr ri
;                       jnb ri,$
;                       clr ri
                        ret
;=========================================================================
;SMS_AT_at1310:  DB "AT",'$'
;SMS_AT_atcmgf1: DB "AT+CMGF=1",'$'
;SMS_AT_atcmgs:  DB "AT+CMGS=",'"','$'
;=========================================================================
AT_atcmgf1:             call delay1sec
                        call delay1sec
                        call display_dot
        
                        mov dptr,#SMS_AT_atcmgf1
                        call SMS_GSM_int

;                       jnb ri,$
;                       clr ri
;                       jnb ri,$
;                       clr ri
                        ret
;=========================================================================
AT_atcmgs_no:           call delay1sec
                        call delay1sec
                        call display_dot
        
                        mov dptr,#SMS_AT_atcmgs
                        call SMS_GSM_int
        
                        mov dptr,#Finalnumber1
                        call SMS_GSM_int
        
                        mov a,#'"'
                        mov sbuf,a
                        jnb ti,$
                        clr ti
        
                        mov a,#13
                        mov sbuf,a
                        jnb ti,$
                        clr ti

                        mov a,#10
                        mov sbuf,a
                        jnb ti,$
                        clr ti
                        ret
;=========================================================================
AT_atcmgs_no_2:         call delay1sec
                        call delay1sec
                        call display_dot
        
                        mov dptr,#SMS_AT_atcmgs
                        call SMS_GSM_int
        
                        mov dptr,#Finalnumber2
                        call SMS_GSM_int
        
                        mov a,#'"'
                        mov sbuf,a
                        jnb ti,$
                        clr ti
        
                        mov a,#13
                        mov sbuf,a
                        jnb ti,$
                        clr ti
        
                        mov a,#10
                        mov sbuf,a
                        jnb ti,$
                        clr ti
                        ret
;=========================================================================
display_dot:            mov LCDtempreg,#'.'
                        call LCDdata
                        ret
;=======================================================================
;=======================================================================
;               GSM INTERFACING 
;=======================================================================
SMS_GSM_int:             mov LCDreg,#00h
SMS_GSM_int2:            mov a,LCDreg
                        movc a,@a+dptr
                        cjne a,#'$',SMS_GSM_int3
                        ret
SMS_GSM_int3:            mov sbuf,a
                        jnb ti,$
                        clr ti
                        inc LCDreg
                        jmp SMS_GSM_int2
;====================================================================
Send_SMS_Part_1:        call AT_at1310
                        call AT_atcmgf1         ;AT+CMGF=1
                        call AT_atcmgs_no       ;;AT+CMGS="9860119860"
                        ret
;=========================================================
Send_SMS_Part_2:        call delay1sec
                        call delay1sec
                        call display_dot
                        call SMS_GSM_int
                        call display_dot
                        ret
;=========================================================================
Send_SMS_Part_2_all:    call delay1sec
                        call delay1sec
                        call display_dot
                        call SMS_GSM_int
                        call display_dot


                        mov a,#'L'
                        mov sbuf,a
                        jnb ti,$
                        clr ti

                        mov a,#'g'
                        mov sbuf,a
                        jnb ti,$
                        clr ti

                        mov a,#'='
                        mov sbuf,a
                        jnb ti,$
                        clr ti

                mov a,Reg_GPS11
                        mov sbuf,a
                        jnb ti,$
                        clr ti

                mov a,Reg_GPS12
                        mov sbuf,a
                        jnb ti,$
                        clr ti

                mov a,Reg_GPS13
                        mov sbuf,a
                        jnb ti,$
                        clr ti

                mov a,Reg_GPS14
                        mov sbuf,a
                        jnb ti,$
                        clr ti

                mov a,Reg_GPS15
                        mov sbuf,a
                        jnb ti,$
                        clr ti

                mov a,Reg_GPS16
                        mov sbuf,a
                        jnb ti,$
                        clr ti

                mov a,Reg_GPS17
                        mov sbuf,a
                        jnb ti,$
                        clr ti

                mov a,Reg_GPS18
                        mov sbuf,a
                        jnb ti,$
                        clr ti

                mov a,Reg_GPS19
                        mov sbuf,a
                        jnb ti,$
                        clr ti

                mov a,Reg_GPS1A
                        mov sbuf,a
                        jnb ti,$
                        clr ti

                mov a,Reg_GPS1B
                        mov sbuf,a
                        jnb ti,$
                        clr ti




                        mov a,#10
                        mov sbuf,a
                        jnb ti,$
                        clr ti
                        mov a,#13
                        mov sbuf,a
                        jnb ti,$
                        clr ti

                        mov a,#'L'
                        mov sbuf,a
                        jnb ti,$
                        clr ti

                        mov a,#'t'
                        mov sbuf,a
                        jnb ti,$
                        clr ti

                        mov a,#'='
                        mov sbuf,a
                        jnb ti,$
                        clr ti


                mov a,Reg_GPS21
                        mov sbuf,a
                        jnb ti,$
                        clr ti

                mov a,Reg_GPS22
                        mov sbuf,a
                        jnb ti,$
                        clr ti

                mov a,Reg_GPS23
                        mov sbuf,a
                        jnb ti,$
                        clr ti

                mov a,Reg_GPS24
                        mov sbuf,a
                        jnb ti,$
                        clr ti

                mov a,Reg_GPS25
                        mov sbuf,a
                        jnb ti,$
                        clr ti

                mov a,Reg_GPS26
                        mov sbuf,a
                        jnb ti,$
                        clr ti

                mov a,Reg_GPS27
                        mov sbuf,a
                        jnb ti,$
                        clr ti

                mov a,Reg_GPS28
                        mov sbuf,a
                        jnb ti,$
                        clr ti

                mov a,Reg_GPS29
                        mov sbuf,a
                        jnb ti,$
                        clr ti

                mov a,Reg_GPS2A
                        mov sbuf,a
                        jnb ti,$
                        clr ti

                mov a,Reg_GPS2B
                        mov sbuf,a
                        jnb ti,$
                        clr ti

                mov a,Reg_GPS2C
                        mov sbuf,a
                        jnb ti,$
                        clr ti
        
                        mov a,#26
                        mov sbuf,a
                        jnb ti,$
                        clr ti
                        call display_dot
                        ret
;=========================================================================
send_sms_all
                        mov dptr,#msgsmsall
                        call LCDdisp

                        call Send_SMS_Part_1
                        mov dptr,#Finalsmsall
                        call Send_SMS_Part_2_all

                        mov dptr,#msgsmsall2
                        call LCDdisp
                        call delay2sec

                        ret
;=========================================================================
send_sms_invalid:
                        mov dptr,#msgsmsinvalid
                        call LCDdisp

                        call Send_SMS_Part_1
                        mov dptr,#Finalsmsinvalid
                        call Send_SMS_Part_2_all

                        mov dptr,#msgsmsinvalid2
                        call LCDdisp
                        call delay2sec

                        ret
;=========================================================================
; Messages to be displayed on LCD
;=========================================================================

msgwelcome:             db "SCHOOL BUS@TRACKING SYSTEM"
msgGPSinvalid:          db "GPS DATA @INVALID  "
msgGPSinvalid1:         db "GPS DATA INVALID@ADJUST ANTENNA"

msgGPSdisplay:  db "Lg=@Lt="


shriganesha:            DB "School bus tracking system using GPS and GSM technology",10,13,'$'
msggsminit:             DB "Intialising Plz @wait        "
msgpoweron1             DB "SENDING POWERON @SMS........     "
msgpoweron2             DB "POWERON SMS     @SENT SUCESSFULLY"


SMS_AT_at1310:          DB "AT",'$'
SMS_AT_atcmgf1:         DB "AT+CMGF=1",'$'
SMS_AT_atcmgs:          DB "AT+CMGS=",'"','$'
Finalsmsall:            DB "School bus co-ordinates are:",10,13,'$'
Finalsmsinvalid:        DB "GPS data is invalid. Please adjust the antenna.",10,13,'$'

msgsmsall:              DB "SENDING SMS     "
msgsmsall2:             DB "SMS SENT    "

msgsmsinvalid:          DB "INVALID GPS DATA@SENDING SMS     "
msgsmsinvalid2:         DB "INVALID GPS DATA@    SMS SENT    "

Finalnumber1:           DB "9800000000"
Finalnumber2:           DB "9811111111"
;==========================================================
;     Program ENDS here
;==========================================================
