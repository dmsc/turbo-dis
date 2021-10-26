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

; Compare FOR count with limit
FOR_CMPLIM .proc
            sta L00EC
            ldy #$00            ; FLIM in BASIC sources
            lda (TOPRSTK),Y
            cmp FR0
            bne CMP_EXP
            iny
            lda (TOPRSTK),Y
            cmp FR0+1
            bne CMP_NE
            iny
            lda (TOPRSTK),Y
            cmp FR0+2
            bne CMP_NE
            iny
            lda (TOPRSTK),Y
            cmp FR0+3
            bne CMP_NE
            iny
            lda (TOPRSTK),Y
            cmp FR0+4
            bne CMP_NE
            iny
            lda (TOPRSTK),Y
            cmp FR0+5
            beq RTS_18
CMP_NE      ror
            eor L00EC
            eor FR0
            asl
RTS_18      rts
CMP_EXP     ora FR0
            eor L00EC
            bpl RTS_18
            ror
            eor #$80
            asl
            rts
        .endp

; vi:syntax=mads
