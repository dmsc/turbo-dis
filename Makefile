# Makefile: builds a bootable ATR image

# Uncomment to compile some minor fixes
#MADS_DEF=-d:tb_fixes

# Output ATR filename:
ATR=tbasic.atr

# Output files inside the ATR
FILES=\
    bin/tb.com \
    bin/readme \
    bin/startup.bat \

# BW-DOS files to copy inside the ATR
DOSDIR=bin/dos/
DOS=\
    bin/dos/xbw130.dos\
    bin/dos/copy.com\

# Main make rule
all: $(ATR)

# Build an ATR disk image using "mkatr".
tbasic.atr: $(DOS) $(FILES)
	mkatr $@ $(DOSDIR) -b $^

# Rule to remove all build files
clean:
	rm -f $(ATR)
	rm -f $(FILES)

# Assemble using MADS to a ".com" file
bin/tb.com: turbo-mads.asm
	mads $(MADS_DEF) $< -o:$@ -l:$(@:.com=.lst)

# Transform a text file to ATASCII (replace $0A with $B1)
bin/%: %
	tr '\n' '\233' < $< > $@

