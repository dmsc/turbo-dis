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

; The memory for variable and argument stack is also used
; for storing the parsed lines and copy ROM to RAM at init
OUTBUFF = VARSTK0

; Variable and argument stacks
VARSTK0     .ds $20
VARSTK1     .ds $20
ARGSTK0     .ds $20
ARGSTK1     .ds $20
ARGSTK2     .ds $20
ARGSTK3     .ds $20
ARGSTK4     .ds $20
ARGSTK5     .ds $20

; vi:syntax=mads
