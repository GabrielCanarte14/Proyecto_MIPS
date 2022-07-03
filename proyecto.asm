#REGISTROS
#----------------------------------------------
#	t0 = Contador de monedas
#       t1 = Numero a llamar
#----------------------------------------------

.data
 mensaje: .asciiz "Llamada en curso ... Presione C para cancelar "
 advertencia: .asciiz "¡Le quedan menos de $0.05!"
 llamadaFin: .asciiz "Ha terminado su llamada"
 titulo: .asciiz "\nProyecto 1er Parcial\n "
 ingreso: .asciiz "Ingrese su moneda: "
 salto: .asciiz "\n"
 incorrecto: .asciiz "Moneda no valida"
 saldo: .asciiz "\nSaldo: \$"
 numero: .asciiz "Ingrese el numero a llamar: "
 cMinuto: .asciiz "Costo de llamada por minuto: \$0."
 inicio: .asciiz "¿Desea iniciar la llamada? Si[1] / No[0]: "
 cFinal: .asciiz "Costo de la llamada: \$"
 duracion: .asciiz "Duracion de la llamada"
 cambio: .asciiz "Su cambio es:"
 error: .asciiz "Moneda no valida"
 zeroAsFloat: .float 0.0
 buffer: .space 10
 p: .float 0.12
 fp1: .float -1
 v1: .float 0.05
 v2: .float 0.10
 v3: .float 0.25
 v4: .float 0.5
 v5: .float 1
 
.text
.globl main

main:
	lwc1 $f4, zeroAsFloat 
	
	#imprime isntrucciones
	jal instrucciones
	
	#Llama al ingreso de monedas
	jal ingresar
	
	#Ingresar el numero de telefono
	jal ingresarTelefono
	
	#Generar cuanto va a costar el minuto.
	jal generar
	
	#Simular llamada
	jal iniciarLlamada
	
	#Termina el programa
	j done
	
#Generar coste aleatorio
generar:
	#Nueva linea
	li $v0, 4
	la $a0, salto
	syscall
	
	li $v0, 4
    	la $a0, cMinuto
    	syscall
    
	addi $a1,$zero, 30
	addi $v0,$zero, 42
 	syscall
    
	add $a0,$a0,10
    	    	   	
    	addi $v0, $zero, 1
     	syscall
     	
    	jr $ra

#Simular llamada
iniciarLlamada:
	#Nueva linea
	li $v0, 4
	la $a0, salto
	syscall
	
	li $v0, 4
	la $a0, inicio
	syscall
	
	li $v0,5
	syscall
	
	beqz $v0,done
	
	#Nueva linea
	li $v0, 4
	la $a0, salto
	syscall
	
	j simular

#Simulacion
simular:
	
#loopSimular: 
calcular:


	
#Solicita el ingreso de monedas
ingresar:	
	li $v0, 4
	la $a0, ingreso
	syscall
	
	li $v0, 6
	syscall
	
	lwc1 $f5,fp1
	c.eq.s $f0,$f5
	
	bc1t seguir 
	j ValidarMoneda		
	
	j ingresar
	
#Suma el saldo
sumarSaldo:
	add.s $f12, $f12, $f0	
	li $v0, 11
	la $a0, salto
	syscall
	
	j ingresar
	
#Valida que ingrese la moneda correcra
ValidarMoneda:
	lwc1 $f6,v1
	lwc1 $f7,v2
	lwc1 $f8,v3
	lwc1 $f9,v4
	lwc1 $f10,v5
		
	#Compara si ambosd valores son iguales, en caso de serlo la bandera sera 0
	c.eq.s $f6,$f0
	#se ejecuta si es 0
	bc1t sumarSaldo
	
	c.eq.s $f7,$f0
	bc1t sumarSaldo
	
	c.eq.s $f8,$f0
	bc1t sumarSaldo
	
	c.eq.s $f9,$f0
	bc1t sumarSaldo
	
	c.eq.s $f10,$f0
	bc1t sumarSaldo
	
	j noValido
		
	
#Mensaje de moneda incorrecta
noValido:
	li $v0, 4
	la $a0, error
	syscall
	
	#Nueva linea
	li $v0, 4
	la $a0, salto
	syscall
	
	j ingresar
	
#Para regresar a main e imprimir la suma de monedas	
seguir:	
	li $v0, 4
	la $a0, saldo
	syscall
	
	li $v0, 2
	add.s $f11, $f12, $f4
	syscall
	
	#Regresas a main linea 31
	jr $ra
	
#Imprime las instrucciones del programa
instrucciones:
	li $v0, 4
	la $a0, titulo
	syscall
	
	#Regresas a main linea 31
	jr $ra

#Validar numero de telefono
ingresarTelefono:
	li $v0, 4
	la $a0, salto
	syscall
	
	#Solicita el ingreso del numero de telefono
	li $v0, 4
	la $a0, numero
	syscall
	
	li $v0, 5	
	syscall
	
	j validarNumero
	jr $ra

validarNumero:
	jr $ra
	
		
#Finaliza el programa
done:
	li $v0,10
	syscall
