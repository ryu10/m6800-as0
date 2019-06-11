# m6800-as0 README

![screenshot](https://github.com/ryu10/m6800-as0/blob/master/screenshot.png?raw=true)

Syntax highlighting for 6800 assembly ([as0](https://github.com/JimInCA/motorola-6800-assembler)).

## Requirements

[motorola-6800-assembler (as0)](https://github.com/JimInCA/motorola-6800-assembler)
for assemble command.

## Tips for running as0 on Windows

* To install and run as0 on Windows, use Windows10 WSL or Cygwin.

* For Cygwin, change M6800-as0 configuration: **As0 Path**, for example, to:
  * /c/cygwin64/usr/local/bin/

* Set **End of Line Sequence** to **LF** for *.asm source code files.

## Known Issues

* An empty listing file is generated if no listing option is specified.

## Release Notes

### 0.0.3

Updated Readme.

### 0.0.2

Test code modified.

### 0.0.1

Initial release of m6800-as0.

**Enjoy!**
