# bitmapReader

This project is capable of opening bitmap files, working with their information and printing them in a bitmap display. It was developed in assembly MIPS, and runs with Mars 4.5 and its tool bitmap display.

To run it, follow the steps:
- `Run Mars4_5.jar using java;` Any versions of JDK should work

- `On Mars, open the bitmap.asm file;`

- `Now, check the FILENAME variable in the code, it should have the correct path to the .ppm file you want to prin;` 

An example of file address on Ubuntu(user klausdk) would be: 

.data

FILENAME: .asciiz "/home/klausdk/Documentos/Projetos/Assembly/homer.ppm"

- `On Mars open the "Tools" menu on the top, and select bitmap display;` 

- `On the bitmap display, select the following settings, 1 , 1, 256, 256, 0x10040000(heap), and then click the "Connect to MIPS" button;`      
After that the display is connected in the correct addres, and you should run the code

- `To run the code click the assemble button(icon showing a screwdriver and a spanner) the click the green play button that should show on the side of the assemble button`
