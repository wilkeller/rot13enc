#rot13enc

This program, rot13enc, is a toy program (as in, not intended for genuine use or public consumption) that handles encoding and decoding of rot13 text from the linux command line. 

It is written in x86-64 assembly, and is functionally my "Hello World," being _the very first_ program that I have written in assembly. 

It's intended use is via *Nix IO redirection, reading in the textfile specified by the user and outputting to a file specified by the user, as follows: 

    $ ./rot13enc > outputfile.txt < inputfile.txt

Naturally, this program is not under any active development, and little effort has gone into making it 'secure' or well-behaved in the face of a malicious user; as I said, it's my 'Hello, World.' That being said, it *should* filter out all non-ASCII-alphabet characters (which is to say, it should only adjust characters that are part of the english alphabet *and* on the ASCII table).  

I may come back at a later date and improve upon this as I learn more and better ASM, but for now I consider the project closed. 