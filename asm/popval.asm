;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                                                            ;;
;; TurboBasic XL v1.5 disassembly, in MADS format.            ;;
;;                                                            ;;
;; Disassembled and translated to MADS by dmsc, 2017-2021     ;;
;;                                                            ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
; This disassembly is based on the published TurboBasic XL binaries,
; and should be public-domain by now.
;

        ; "POP1" in Atari BASIC: Get Value in FR0
GETFP       jsr EXEXPR
        ; "ARGPOP" in Atari BASIC: Pop Argument Stack Entry to FR0 or FR1
X_POPVAL    ldy ARSLVL
POPVALY     dec ARSLVL
            lda ARGSTK5,Y
            sta FR0+5
            lda ARGSTK4,Y
            sta FR0+4
            lda ARGSTK3,Y
            sta FR0+3
            lda ARGSTK2,Y
            sta FR0+2
            lda ARGSTK1,Y
            sta FR0+1
            lda ARGSTK0,Y
            sta FR0
            lda VARSTK1,Y
            sta VNUM
            lda VARSTK0,Y
            sta VTYPE
            rts

        ; "ARGP2" in Atari BASIC: Pop TOS to FR1,TOS-1 to FR0
X_POPVAL2   dec ARSLVL
            ldy ARSLVL
            lda ARGSTK5+1,Y
            sta FR1+5
            lda ARGSTK4+1,Y
            sta FR1+4
            lda ARGSTK3+1,Y
            sta FR1+3
            lda ARGSTK2+1,Y
            sta FR1+2
            lda ARGSTK1+1,Y
            sta FR1+1
            lda ARGSTK0+1,Y
            sta FR1
            jmp POPVALY

; vi:syntax=mads
