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

