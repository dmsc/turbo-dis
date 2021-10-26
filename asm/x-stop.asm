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

X_STOP      jsr SAVSTOPLN
            jsr PUTEOL
            lda #<STOPPED
            sta SCRADR
            lda #>STOPPED
            sta SCRADR+1
            jsr LPRTOKEN
            jmp ERROR.PLNUM

            ; Save stopped line number
SAVSTOPLN   ldy #$01
            lda (STMCUR),Y
            bmi SETDZ
            sta STOPLN+1
            dey
            lda (STMCUR),Y
            sta STOPLN
SETDZ       ; Set device #0 as LIST/ENTER devices
            lda #$00
            sta ENTDTD
            sta L00B5
            rts
STOPPED     .cb 'STOPPED '

; vi:syntax=mads
