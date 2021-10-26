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

RUNINIT .proc
            ldy #$00
            sty STOPLN
            sty STOPLN+1
            sty ERRNUM
            sty DEGFLAG
            sty DATAD
            sty DATALN
            sty DATALN+1
            dey
            sty TRAPLN+1
            sty BRKKEY
            jmp CLSALL
        .endp

; vi:syntax=mads
