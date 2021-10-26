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

; Copy FR0 to variable
RTNVAR  .proc
            lda VNUM
            jsr VAR_PTR
            lda VTYPE
            sta (WVVTPT),Y
            iny
            lda VNUM
            sta (WVVTPT),Y
            iny
            lda FR0
            sta (WVVTPT),Y
            iny
            lda FR0+1
            sta (WVVTPT),Y
            iny
            lda FR0+2
            sta (WVVTPT),Y
            iny
            lda FR0+3
            sta (WVVTPT),Y
            iny
            lda FR0+4
            sta (WVVTPT),Y
            iny
            lda FR0+5
            sta (WVVTPT),Y
            rts
        .endp

; GVVTADR in Atari Basic - get pointer to variable table in WVVTPT
VAR_PTR .proc
            asl
            rol
            rol
            rol
            tay
            ror
            and #$F8
            clc
            adc VVTP
            sta WVVTPT
            tya
            and #$07
            adc VVTP+1
            sta WVVTPT+1
            ldy #$00
            rts
        .endp

; vi:syntax=mads
