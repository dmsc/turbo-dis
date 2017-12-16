# Makefile: builds a bootable ATR image

# Define to add minor fixes
MADS_DEF=-d:tb_fixes

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

# Assemble using MADS to a ".com" file, includes fixes
bin/tb.com: turbo-mads.asm
	mads $(MADS_DEF) $< -o:$@ -l:$(@:.com=.lst)

# Assemble using MADS to a ".com" file, original version
bin/tb15.com: turbo-mads.asm
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

