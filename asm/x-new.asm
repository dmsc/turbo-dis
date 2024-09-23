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

; Cold-Start
COLDSTART   ldx #$FF
            txs
            cld
            lda LOADFLG
            beq WARMSTART

X_NEW       jsr INIT_MEM
WARMSTART   jsr RUNINIT
SNX1        jsr CLSALL
SNX2        jsr SETDZ
            lda MEOLFLG
            beq SNX3
            jsr RSTSEOL
SNX3        jsr PREADY

; Fall trough SYN_START


; vi:syntax=mads
