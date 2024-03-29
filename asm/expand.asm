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

ERR_2_      jmp ERR_2

; Expand memory for a table
EXPLOW      lda #$00
EXPAND  .proc
            sty ECSIZE
            sta ECSIZE+1
            clc
            lda TOPRSTK
            adc ECSIZE
            tay
            lda TOPRSTK+1
            adc ECSIZE+1
            cmp MEMTOP+1
            bcc MEM_OK
            bne ERR_2_
            cpy MEMTOP
            bcc MEM_OK
            bne ERR_2_
MEM_OK      sec
            lda TOPRSTK
            sbc $00,X
            sta MVLNG
            lda TOPRSTK+1
            sbc $01,X
            sta MVLNG+1
            clc
            lda $00,X
            sta INDEX2
            sta MVFA
            adc ECSIZE
            sta MVTA
            lda $01,X
            sta INDEX2+1
            sta MVFA+1
            adc ECSIZE+1
            sta MVTA+1
            ; Move memory pointers up
@           lda $00,X
            adc ECSIZE
            sta $00,X
            lda $01,X
            adc ECSIZE+1
            sta $01,X
            inx
            inx
            cpx #$92
            bcc @-
            sta APPMHI+1
            lda TOPRSTK
            sta APPMHI

.def :DO_MOVEDWN
            inc PORTB
            ldx MVLNG+1
            clc
            txa
            adc MVFA+1
            sta MVFA+1
            clc
            txa
            adc MVTA+1
            sta MVTA+1
            inx
            ldy MVLNG
            beq L2619
L25F4       dey
            lda (MVFA),Y
            sta (MVTA),Y
            tya
            bne L25F4
            beq L2619
L25FE       dec MVFA+1
            dec MVTA+1
L2602       dey
            lda (MVFA),Y
            sta (MVTA),Y
            dey
            lda (MVFA),Y
            sta (MVTA),Y
            dey
            lda (MVFA),Y
            sta (MVTA),Y
            dey
            lda (MVFA),Y
            sta (MVTA),Y
            tya
            bne L2602
L2619       dex
            bne L25FE
            dec PORTB
            rts
        .endp

; vi:syntax=mads
