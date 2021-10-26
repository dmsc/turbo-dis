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

X_TIMESET .proc
            jsr EXEXPR
            jsr SETSEOL
            ldy #$00
            sty CIX
            sty FR1+1
            sty FR1+2
            jsr TS_GET2DIG      ; Get HOURS
            cmp #24
            bcs TS_ERR18
            sta FR1
            jsr TS_MUL60
            jsr TS_GET2DIG      ; Get MINUTES
            cmp #60
            bcs TS_ERR18
            jsr TS_ADD
            jsr TS_MUL60
            jsr TS_GET2DIG      ; Get SECONDS
            cmp #60
            bcs TS_ERR18
            jsr TS_ADD
            jsr TS_MUL5         ; Multiply by 5*10 = 50 (PAL)
            jsr TS_MUL10
            lda FR1
            ldy FR1+1
            ldx FR1+2
@           sta RTCLOK+2        ; Write and retry until stable
            sty RTCLOK+1
            stx RTCLOK
            cmp RTCLOK+2
            bne @-
            jmp RSTSEOL
TS_ERR18    jsr RSTSEOL
            jmp ERR_18
TS_GET2DIG  jsr T_GETDIGIT
            inc CIX
            bcs TS_ERR18
            asl
            sta FR1+3
            asl
            asl
            adc FR1+3
            sta FR1+3
            jsr T_GETDIGIT
            inc CIX
            bcs TS_ERR18
            adc FR1+3
            rts
TS_ADD      clc
            adc FR1
            sta FR1
            bcc @+
            inc FR1+1
            bne @+
            inc FR1+2
@           rts
TS_MUL10    asl FR1
            rol FR1+1
            rol FR1+2   ; *2
TS_MUL5     ldy FR1+2
            lda FR1
            ldx FR1+1
            asl FR1
            rol FR1+1
            rol FR1+2   ; *4
            asl FR1
            rol FR1+1
            rol FR1+2   ; *8
            adc FR1
            sta FR1
            txa
            adc FR1+1
            sta FR1+1
            tya
            adc FR1+2
            sta FR1+2   ; *10
            rts
TS_MUL60    jsr TS_MUL10; *10
            ldy FR1+2
            lda FR1
            ldx FR1+1
            asl FR1
            rol FR1+1
            rol FR1+2   ; *20
            adc FR1
            sta FR1
            txa
            adc FR1+1
            sta FR1+1
            tya
            adc FR1+2   ; *30
            asl FR1
            rol FR1+1
            rol
            sta FR1+2   ; *60
.if .not .def tb_fixes
            rts         ; Remove extra RTS
.endif
        .endp
TS_RTS      rts


; vi:syntax=mads
