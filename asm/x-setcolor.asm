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

X_SETCOLOR  jsr GET3INT
            and #$0F
            asl L009B
            asl L009B
            asl L009B
            asl L009B
            ora L009B
            ldx L009A
            bne ERR_3A
            ldx L0099
            cpx #$05
            bcs ERR_3A
            sta COLOR0,X
            rts

; vi:syntax=mads
