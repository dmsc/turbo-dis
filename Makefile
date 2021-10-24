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
bin/tb.lo.com: turbo-mads.asm turbo-loader.asm equates.asm
	mads $(MADS_DEF_LO) $< -o:$@ -l:$(@:.com=.lst)

bin/tb.hi.com: turbo-mads.asm turbo-loader.asm equates.asm
	mads $(MADS_DEF_HI) $< -o:$@ -l:$(@:.com=.lst)

# Assemble using MADS to a ".com" file, original version
bin/tb15.com: turbo-mads.asm turbo-loader.asm equates.asm
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

