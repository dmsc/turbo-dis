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

; MATHPACK temporary variables, used to accelerate MUL and DIV
; EXPAND_POW2 stores all the
FPTMP0      .ds 8
FPTMP1      .ds 8
FPTMP2      .ds 8
FPTMP3      .ds 8
FPTMP4      .ds 8
FPTMP5      .ds 8

; vi:syntax=mads
