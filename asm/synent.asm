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

        ; Perform line pre-compile
SYNENT  .proc
            ldy #$00
            sty OPSTKX
            lda (SCRADR),Y
            asl
            tay
            lda SYN_ATAB,Y
            sta CPC
            sta SPC
            lda SYN_ATAB+1,Y
            sta CPC+1
            sta SPC+1
            lda COX
            sta SOX
            lda CIX
            sta SIX
NEXT        inc CPC
            bne @+
            inc CPC+1
@           ldx #$00
            lda (CPC,X)
            bmi ERNTV
            cmp #$05
            bcc POP_SYN
            jsr TERMTST
            bcc NEXT
            jmp FAIL
ERNTV       asl
            tay
            lda SYN_ATAB+1,Y
            pha
            lda SYN_ATAB,Y
            pha
            cpy #$12
            bcs PUSH
            pla
            tay
            pla
            jsr JSR_AY
            bcc NEXT
            jmp FAIL

JSR_AY      pha
            tya
            pha
            rts
.endp

NEXT = SYNENT.NEXT

; vi:syntax=mads
