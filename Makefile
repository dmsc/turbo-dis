# Makefile: builds a bootable ATR image

# Define to add minor fixes
MADS_DEF_LO=-d:tb_fixes -d:tb_lowmem=32
MADS_DEF_HI=-d:tb_fixes -d:tb_lowmem=48

# Flags for compilation of relocation program
CFLAGS=-O2 -Wall

# Output ATR filename:
ATR=tbasic.atr

# Output files inside the ATR
FILES=\
    bin/tb.com \
    bin/tb15.com \
    bin/readme \
    bin/startup.bat \

# Source ASM files
ASM_FILES=\
    turbo-mads.asm\
    asm/altopen.asm\
    asm/argstack.asm\
    asm/bloadrun.asm\
    asm/ciocall.asm\
    asm/cio-getchar.asm\
    asm/cio-open.asm\
    asm/ciotest.asm\
    asm/ciov.asm\
    asm/contract.asm\
    asm/dirspecs.asm\
    asm/disrom.asm\
    asm/equates.asm\
    asm/errors.asm\
    asm/errortab.asm\
    asm/execnl.asm\
    asm/exexpr.asm\
    asm/expand.asm\
    asm/fastplot.asm\
    asm/fix-rstk.asm\
    asm/flist.asm\
    asm/fptmp.asm\
    asm/getint.asm\
    asm/getkey.asm\
    asm/getlabel.asm\
    asm/getline.asm\
    asm/getlnum.asm\
    asm/getstr.asm\
    asm/giochan.asm\
    asm/gloadciox.asm\
    asm/hashlnum.asm\
    asm/initmem.asm\
    asm/inkey-tab.asm\
    asm/iosetvar.asm\
    asm/irq-nmi.asm\
    asm/loader.asm\
    asm/mathpack.asm\
    asm/mv6rs.asm\
    asm/newfile.asm\
    asm/nmi-end.asm\
    asm/operators.asm\
    asm/opetab.asm\
    asm/opstack.asm\
    asm/ovsearch.asm\
    asm/pdum.asm\
    asm/popreturn.asm\
    asm/popval.asm\
    asm/prtline.asm\
    asm/prtnum.asm\
    asm/prtstr.asm\
    asm/prtvar.asm\
    asm/pushval.asm\
    asm/putchar.asm\
    asm/rcont.asm\
    asm/ready.asm\
    asm/relocate.asm\
    asm/renum.asm\
    asm/reset-v.asm\
    asm/rexpand.asm\
    asm/rstptr.asm\
    asm/rtnvar.asm\
    asm/runinit.asm\
    asm/scantab.asm\
    asm/searchln.asm\
    asm/s-eif.asm\
    asm/s-erem.asm\
    asm/setseol.asm\
    asm/skipstmt.asm\
    asm/s-label.asm\
    asm/s-numconst.asm\
    asm/s-oper.asm\
    asm/s-stconst.asm\
    asm/statements.asm\
    asm/stmttab.asm\
    asm/stsearch.asm\
    asm/synent.asm\
    asm/synfail.asm\
    asm/syngetvar.asm\
    asm/synpop.asm\
    asm/synpush.asm\
    asm/synsetcode.asm\
    asm/synsrcont.asm\
    asm/syntable.asm\
    asm/syntax.asm\
    asm/turbo-loader.asm\
    asm/ucasebuf.asm\
    asm/unfix-rstk.asm\
    asm/x-abs.asm\
    asm/x-adr.asm\
    asm/x-arrparen.asm\
    asm/x-asc.asm\
    asm/x-bitops.asm\
    asm/x-bputget.asm\
    asm/x-break.asm\
    asm/x-bye.asm\
    asm/x-chr.asm\
    asm/x-circle.asm\
    asm/x-cload.asm\
    asm/x-close.asm\
    asm/x-clr.asm\
    asm/x-cls.asm\
    asm/x-color.asm\
    asm/x-comparison.asm\
    asm/x-constant.asm\
    asm/x-cont.asm\
    asm/x-dec.asm\
    asm/x-degrad.asm\
    asm/x-del.asm\
    asm/x-dim.asm\
    asm/x-dir.asm\
    asm/x-dos.asm\
    asm/x-dpeek.asm\
    asm/x-dpoke.asm\
    asm/x-drawto.asm\
    asm/x-dsound.asm\
    asm/x-dump.asm\
    asm/x-endproc.asm\
    asm/x-enter.asm\
    asm/x-errl.asm\
    asm/x-exec.asm\
    asm/x-exit.asm\
    asm/x-fcolor.asm\
    asm/x-ff.asm\
    asm/x-fileops.asm\
    asm/x-for1.asm\
    asm/x-for2.asm\
    asm/x-for3.asm\
    asm/x-fpassign.asm\
    asm/x-fpcomp.asm\
    asm/x-fpop.asm\
    asm/x-frac.asm\
    asm/x-fre.asm\
    asm/x-get.asm\
    asm/x-getkey.asm\
    asm/x-gosub.asm\
    asm/x-graphics.asm\
    asm/x-gsdo.asm\
    asm/x-hexstr.asm\
    asm/x-ifthen.asm\
    asm/x-inkey.asm\
    asm/x-input.asm\
    asm/x-instr.asm\
    asm/x-int.asm\
    asm/x-len.asm\
    asm/x-list.asm\
    asm/x-load.asm\
    asm/x-locate.asm\
    asm/x-logical.asm\
    asm/x-loop.asm\
    asm/x-lprint.asm\
    asm/x-mod.asm\
    asm/x-move.asm\
    asm/x-new.asm\
    asm/x-next.asm\
    asm/x-note.asm\
    asm/x-on.asm\
    asm/x-paint.asm\
    asm/x-pause.asm\
    asm/x-peek.asm\
    asm/x-plot.asm\
    asm/x-point.asm\
    asm/x-poke.asm\
    asm/x-pop.asm\
    asm/x-position.asm\
    asm/x-pow.asm\
    asm/x-pputget.asm\
    asm/x-print.asm\
    asm/x-put.asm\
    asm/x-random.asm\
    asm/x-read.asm\
    asm/x-restore.asm\
    asm/x-return.asm\
    asm/x-run.asm\
    asm/x-save.asm\
    asm/x-setcolor.asm\
    asm/x-status.asm\
    asm/x-sticks.asm\
    asm/x-stop.asm\
    asm/x-str.asm\
    asm/x-strassign.asm\
    asm/x-strcmp.asm\
    asm/x-strparen.asm\
    asm/x-text.asm\
    asm/x-time.asm\
    asm/x-timeset.asm\
    asm/x-timestr.asm\
    asm/x-trace.asm\
    asm/x-trap.asm\
    asm/x-trig.asm\
    asm/x-until.asm\
    asm/x-usr.asm\
    asm/x-val.asm\
    asm/x-wend.asm\
    asm/x-while.asm\
    asm/x-xio.asm\
    asm/zvar.asm\

# BW-DOS files to copy inside the ATR
DOSDIR=bin/dos/
DOS=\
    bin/dos/xbw130.dos\
    bin/dos/copy.com\

# Main make rule
all: check-md5 $(ATR)

# Build an ATR disk image using "mkatr".
tbasic.atr: $(DOS) $(FILES)
	mkatr $@ $(DOSDIR) -b $^

# Rule to remove all build files
clean:
	rm -f $(ATR)
	rm -f $(FILES)

# Compile relocation program
bin/get-reloc: reloc/get-reloc.c
	$(CC) $(CFLAGS) -o $@ $<

# Generate relocatable binary, from the two assemblies
bin/tb.com: bin/tb.hi.com bin/tb.lo.com bin/get-reloc
	bin/get-reloc $(filter %.com,$^) 0x1000 $@

# Assemble using MADS to a ".com" file, includes fixes
bin/tb.lo.com: $(ASM_FILES)
	mads $(MADS_DEF_LO) $< -o:$@ -l:$(@:.com=.lst)

bin/tb.hi.com: $(ASM_FILES)
	mads $(MADS_DEF_HI) $< -o:$@ -l:$(@:.com=.lst)

# Assemble using MADS to a ".com" file, original version
bin/tb15.com: $(ASM_FILES)
	mads $< -o:$@ -l:$(@:.com=.lst)

# Checks that generated binary is same as original
check-md5: bin/tb15.com.md5
	@cmp tb15.orig.md5 $< || ( \
	    echo "#####################################################"; \
	    echo "######### ERROR - FILE NOT SAME AS ORIGINAL #########"; \
	    echo "#####################################################"; \
	    false )

# Generates checksum (MD5) of a file
%.md5: %
	md5sum $< > $@

# Transform a text file to ATASCII (replace $0A with $B1)
bin/%: %
	tr '\n' '\233' < $< > $@

