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

X_TIMEP .proc
            jsr X_TIME
            dec ARSLVL
            ldx #$05
@           lda JF_DAY,X
            sta FR1,X
            dex
            bpl @-
            jsr T_FDIV
            ldy #$00
            lda FR0
            cmp #$40
            bne @+
            sty FR0+1
@           sty CIX
            lda #$24
            jsr TM_EXTRACT
            lda #$60
            jsr TM_EXTRACT
            lda #$60
            jsr TM_EXTRACT
            ldy #$06
            lda #<LBUFF
            jmp RET_STR_A

TM_EXTRACT  pha
            jsr NORMALIZE
            jsr T_FMOVE
            jsr T_FLD1
            pla
            sta FR0+1
            jsr T_FMUL
            lda #$00
            ldy FR0
            cpy #$40
            bne @+
            ldy FR0+1
            sta FR0+1
            tya
@           tax
            lsr
            lsr
            lsr
            lsr
            jsr TM_GETDIG
            txa
            and #$0F
TM_GETDIG   ora #'0'
            cmp #'9'+1
            bcc @+
            adc #'A'-'9' - 2
@           ldy CIX
            sta LBUFF,Y
            inc CIX
            rts
        .endp

FP_256      .fl 256     ; Used in X_TIME
JF_DAY      .fl 4320000 ; A day in jiffies: 50Hz * 60 * 60 * 24

; vi:syntax=mads
