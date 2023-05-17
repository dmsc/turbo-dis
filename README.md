TurboBasic XL v1.5 disassembly
==============================

This is a disassembly of the TurboBasic XL version 1.5 basic interpreter
for the Atari XL computers, in MADS assembler format.

To assemble you need MADS from http://mads.atari8.info/ and my mkatr tool,
from https://github.com/dmsc/mkatr/.

The source is assembled into two binaries:

 - The original, unmodified interpreter as TB15.COM,
 - A version with some fixes as TB.COM.

This is a work in progress, but most labels have proper name and the code has
many comments.

This code was tested to assemble at different address than the original binary
without breaking.

Relocation
----------

The provided Makefile generates a version of the interpreter that relocates
itself to the lowest address posible, by reading MEMLO and copying the code to
just above the value. This gives more memory to the BASIC programs, depending
on the DOS version.

To assemble this version, the procedure is:

 - The source is assembled at two different MEMLO values, $3000 and $2000.

 - A C program (get-reloc.c) is included that reads the two binaries and builds
   a table with all address that need to be patched in runtime, and includes the
   table inside the binary.

 - Code is included in the binary that at runtime, reads the MEMLO value and
   patches all addresses in the relocation table, then copies the code to the
   final memory address.

To assemble this version, use the `tb_lowmem` define, or use the included
`Makefile`.


Fixed Bugs
----------

The source has fixes for a few interpreter bugs present in all other TurboBasic XL
versions:

 - When adding or deleting lines when inside a `FOR` loop, the runtime stack is
   not correctly adjusted, for example this program:

   ```
   10 ? "START"
   20 FOR J=0 TO 10
   25 ? "J=";J
   30 IF J=5 THEN DEL 10,10
   40 NEXT J
   50 END
   ```

   The interpreter exits the `FOR` on the iteration 5, instead of counting up
   to 10.

 - A bug with the parsing of `IF` statements without `ENDIF`, the end of
   statement is incorrectly checked. This is an example program:

   ```
   10 ? 1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1;1:? 1;1;1;1;1;1;1;1;1;1;;;;;;:IF 1
   20 ENDIF
   ```

   If you remove one "`;`", the program runs correctly, but as shown it prints
   "`ERROR 12`".

 - In the `PRINT` statement, if the last token printed ends in `$12` or `$15`,
   for example a `CONTROL-R` or `CONTROL-U` character on a string, the
   interpreter omits the new-line at the end, as it incorrectly assumes that
   the statement ended in a "`,`" or "`;`".

   This program shows the problematic statements:

   ```
   20 ? "LINE 1:x" : REM   Ok, prints a new-line at end
   30 ? "LINE 1:─" : REM   BUG, does not print the new-line
   40 ? "LINE 1:▄" : REM   BUG, same as above
   60 ? "LINE 1:";1.23456713 : REM   OK, prints a new-line at end
   50 ? "LINE 1:";1.23456712 : REM   BUG, does not print the new-line
   70 ? "LINE 1:";1.23456715 : REM   BUG, same as above
   ```

 - Detection of PAL/NTSC. The original TurboBasic XL assumes PAL ANTIC for the
   `TIME$` function and the `TIME$=` statement, this means only 50 jiffies per
   second, so the functions return an incorrect value in NTSC computers.

   This version includes code at startup that counts the number of scan-lines
   in a screen to detects the ANTIC type. If NTSC is detected the code is
   changed to return the correct values assuming 60 jiffies per second.

   Note that both values are not exact, the real values are 49.86 and 59.92
   jiffies per second in PAL and NTSC respectively, but for the intended usage
   the given values are close enough.

 - The DEC() function accepts lower-case hexadecimal digits.
