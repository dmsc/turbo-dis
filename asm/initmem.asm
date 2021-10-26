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

; Initializes memory pointers, erasing current program
; This is split from XNEW in Atari BASIC to support executing
; the autorun stub on start.
INIT_MEM .proc
            lda #$00
            sta MEOLFLG
            sta LOADFLG
.if .def tb_fixes
            lda #<TOP_LOWMEM
            ldy #>TOP_LOWMEM
.else
            lda MEMLO
            ldy MEMLO+1
.endif
            sta LOMEM
            sty LOMEM+1
            iny
            sta VNTP
            sty VNTP+1
            sta VNTD
            sty VNTD+1
            clc
            adc #$01
            bcc @+
            iny
@           sta VVTP
            sty VVTP+1
            sta STMTAB
            sty STMTAB+1
            sta STMCUR
            sty STMCUR+1
            clc
            adc #$03
            bcc @+
            iny
@           sta STARP
            sty STARP+1
            sta RUNSTK
            sty RUNSTK+1
            sta TOPRSTK
            sty TOPRSTK+1
            sta APPMHI
            sty APPMHI+1
            lda #$00
            tay
            sta (VNTD),Y
            sta (STMCUR),Y
            iny
            lda #$80
            sta (STMCUR),Y
            iny
            lda #$03
            sta (STMCUR),Y
            lda #$0A
            sta PTABW
            jmp X_TRACE.TRACE_OFF
        .endp

; vi:syntax=mads
