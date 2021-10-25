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


RESET_V
.if .not .def tb_fixes
            ; This code is not needed, as DOSINI must already point to this
            ; vector and PORTB is already initialized by the OS.
            lda #<RESET_V
            ldy #>RESET_V
            sta DOSINI
            sty DOSINI+1
            lda #$FF
            sta PORTB
.endif
JMPDOS      jsr $0000
            lda #$FE
            sta PORTB
.if .not .def tb_fixes
            ; Restore original MEMLO value after returning from DOS
            ; This is not needed in the new version, as we use a fixed value
            ; for the start of the BASIC memory.
            lda LOMEM
            ldy LOMEM+1
            sta MEMLO
            sty MEMLO+1
.endif
            jmp COLDSTART

; vi:syntax=mads
