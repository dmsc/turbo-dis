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

.if .not .def tb_fixes
; Note: 6 bytes skipped to align next block to $2300
            .ds 6
;            org $2300
;            This code was a leftover, unused!
            nop
            jsr DISROM
            jmp ERR_9
.endif ; tb_fixes


; All CIO string constants
IO_DIRSPEC  .byte 'D:*.*', CR
DEV_S_      .byte 'S:', CR
DEV_C_      .byte 'C:', CR
DEV_P_      .byte 'P:', CR

BLOADFLAG   .ds 1


; vi:syntax=mads
