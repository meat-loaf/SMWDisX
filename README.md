# SMWDisX
(Yet another) disassembly of Super Mario World.
This disassembly will focus on code readability and the ability to assemble any of the four console releases of the original game (J, U, E 1.0, & E 1.1). It also assembles the Super System arcade version of the game.

# How to Assemble
You'll need the assembler, Asar v1.61 (you can find it [here](https://www.smwcentral.net/?p=section&s=tools)). You can also find the current master branch [here](https://github.com/RPGHacker/asar). Work is in progress to eliminate warnings for version 1.81.

After cloning the repository, you can simply run `make`, which will build all versions. If you dont have asar installed in your PATH, you can edit the makefile.

On windows, you can install `make` in your path, and run `make` or simply use the `PATCH.bat` script.

The makefile validates the checksum of the resultant output files, so it is usefull to ensure any changes haven't modified the output image.

# Status
All 5 versions assemble and play exactly like they should. The only current oustanding issue is the SS version's checksum, which (in the original image) is inverted.

# Format
I'm focusing on readability so its important that everything is nice and consistent.
1. 22 characters for label, 42 characters for instruction, then the PCs, then comment.
2. The PC goes in the order of J, U, SS, E0, the E1. The separator symbols are unique to each so you can prefix a bank address with one to look for that version specifically.
3. Address mode hints (.B .W .L) should be used by the following instructions if they are not accumulator addressed: TSB TRB BIT LDA LDX LDY STA STX STY STZ CMP CPX CPY ORA AND EOR ADC SBC ASL ROL LSR ROR DEC INC. Some address modes (e.g. LDA $addr,Y) are unambiguous but should be kept for consistency.
4. Everything should be relative, using labels. This is kind of assumed, but it is very important with multiple version support since stuff shifts around a lot.
5. Any operand that refers to an address should use a variable. This includes immediates.
6. Large datablocks should be placed in bin files and incbin'd in the disassembly, to reduce text file size.
7. Version differences should be clearly marked with special comments. See label `GameMode17` in bank_00.asm.
   - Exceptions are single instructions with either different addressing modes (use the applicable macro) or different constant operands (use the `con` function).
8. Spaces not tabs.
9. Probably more things that I'll add as I think of them.

# Bugs
The assembler Asar is an open source project still under development. Some bugs exist which require the disassembly to go against formatting protocol in order to assembly correctly. Here is a list of things I've run into to remind myself to go back and fix if the bugs are ever fixed:
1. Turning `check bankcross off` will cause the pc to always act as FastROM. This causes labels to have $80 added to their bank.
   - `padbyte pad` requires the FastROM address. See bank_08-0B.asm.
     - Temp fix: set the high byte of the bank in the `pad` command.
   - All references to labels in a non-bankcross-checked area will have the high bit set. See `GFXFilesBank` label in bank_00.asm.
     - Temp fix: Mask away the high bit of the bank by using `&$7F`.
