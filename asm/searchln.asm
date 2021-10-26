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

; Search line number and fill STMCUR, rebuilding hash first
SRCHLN_NC   jsr GEN_LNHASH
; Search line number and fill STMCUR, using line hash
SEARCHLINE  lda STMCUR
            sta SAVCUR
            lda STMCUR+1
            sta SAVCUR+1
            lda TSLNUM+1
            tax
            asl
            tay
            lda (LOMEM),Y
            sta STMCUR+1
            iny
            lda (LOMEM),Y
LC976       sta STMCUR
            ldy #$01
            txa
            cmp (STMCUR),Y
            bne LC992
            dey
            lda (STMCUR),Y
            cmp TSLNUM
            bcs LC999
LC986       ldy #$02
            lda (STMCUR),Y
            adc STMCUR
            bcc LC976
            inc STMCUR+1
            bcs LC976
LC992       bcc LC997
            clc
            bcc LC986
LC997       sec
            rts
LC999       bne LC997
            clc
            rts

; vi:syntax=mads
