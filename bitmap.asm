#Alunos: Klaus Dieter Kupper

.data
FILENAME: .asciiz "/home/klausdk/Documentos/Projetos/Assembly/homer.ppm"
#FILENAME: .asciiz "/home/klausdk/Documentos/Projetos/Assembly/mario.ppm"
#FILENAME: .asciiz "/home/klausdk/Documentos/Projetos/Assembly/robocop.ppm"
STR: .ascii "                                                                                                             "
word: .word 0 #trablhar word por word, e quando acontece a proxima leitura, parte ja lida "foi consumida" e vai pra proxima
byte: .byte 0
P: .byte 80 #80 representa P
S: .byte 54 #54 representa 6
erro: .asciiz "Erro"

.text
j main

error:
li $v0,4
la $a0, erro
syscall
j fim

PROC_string:#recebe a0 como file descriptor e salva a string em STR

li $v0,14
la $a1,byte
li $a2,1
syscall

lb $t8,byte 
lb $t9, P
bne $t8,$t9,error #compara P(cod80) com o dado do arquivo
sb $t9, STR#coloca byte lido em STR


li $v0,14
la $a1,byte
li $a2,1
syscall

lb $t8, byte
lb $t9, S
bne $t9,$t8,error  #compara 6 com o dado do arquivo
sb $t9, STR + 1    #coloca byte lido em STR

la $t5, STR       #t5 ponteiro para STR
addi $t5,$t5,2    #mais dois no endere�o de STR para passar p6
la $t8, byte     # t8 ponteiro para byte lido

loopstring:     #le string apos P6
li $v0,14
la $a1,byte
li $a2,1
syscall

lb $t9, 0($t8)        #copia valor do byte para t9
sb $t9, 0($t5)       #salva o byte lido em STR
addi $t5,$t5,1         #proximo byte em t5(STR) 
beq $t9, 10, contador   #compara para saber se � barra n
j loopstring

contador:
addi $k0,$k0,1
beq $k0,4,retorno     #quando encontrar 4 barra n volta para a fun��o
j loopstring

retorno:
addi $t5,$t5,1
sb $zero, 0($t5)    #fim da string
jr $ra

main:
#carrega endereco memoria do periferico em s0
li $s0, 0x10040000
#abre arquivo
li $v0,13
la $a0, FILENAME
li $a1,0 #sempre 0
li $a2,0 #0 le, 1 escreve
syscall

#Verificar se o arquivo foi aberto
bltz $v0,error

#file descriptor para a0
move $a0, $v0

jal PROC_string

#a3 � a word
la $a3, word

loop:
#le arquivo(a0 ja contem file descriptor)
li $v0,14
la $a1,word
li $a2,3
syscall
#trocar B e R
la $s1,word
lb $t7,0($s1)     #copia B em t7
la $s2,word + 2
lb $t6,0($s2)     #copia R em t6

sb $t7,0($s2)    #salva R na primeira parte da word
sb $t6,0($s1)    #salva B na terceira parte da word
lw $t0,0($a3)
sw $t0,0($s0)    #salva conteudos do word em s0(10040000)

addi $s0,$s0,4    #vai para a proxima word em 100400000
bnez $v0, loop

# Fechar o arquivo
li   $v0, 16  
# file descriptor ja esta em a0
syscall            

#printar string
li $v0,4
la $a0, STR
syscall


fim:
li $v0, 10	# c�digo para encerrar o programa
syscall
