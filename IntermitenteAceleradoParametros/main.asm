/***********************************************************
		 Intermitente Acelerado con Parametros
					   roberechev
***********************************************************/
.equ DEBUG = 0

ser r16
out ddrd, r16
main:
	ldi r17, 101				;inicializamos a 101 para nada mas empezar decrementar y empezar con los 1000ms
	repetir:
		ldi r16, 0b11111111		
		out portd,r16			;mostramos leds encendidos
		
		dec r17					;decrel¡mentamos 10ms 
		;delay50ms
		push r17
		call delayx10ms			;llamamos a la funcion delay
		pop r17 

		clr r16
		out portd,r16			;mostramos leds apagados
		;delay50ms
		push r17
		call delayx10ms			;llamamos a la funcion delay
		pop r17 
		
	cpi r17, 0					;comparamos que r17 a llegado a 0
	brne repetir


	rjmp main

/***********************************************************
		Fin Intermitente Acelerado con Parametros
***********************************************************/


/***********************************************************
		DELAY dentro de la funcion con parametros
***********************************************************/

delayx10ms:
		push YH				;guardo en una pila de la ram los registros (como copia de seguridad)
		push YL
		IN YL, SPL			;copia SPL en el registro YL
		IN YH, SPH			;copia SPH en el registro YH
		PUSH R0
		PUSH R18			;push como backups de las variables
		PUSH R19
		LDD R0, Y+5			;coges el valor de la pila en este caso y+5 y lo guardas en un registro como R0

.if (DEBUG == 0)			;si estas debugueando no entra 
bucleForR0:
	ldi r18, 208
	ldi r19, 202
L1: dec r19					;bucle delay
	brne L1
	dec r18
	brne L1
	nop

dec r0						;este es el parametro que habiamos pasado (100), cuando llegue a 0 sale del bucle
brne bucleForR0
.endif

	pop r19
	pop r18
	pop r0				;recuperamos datos guardados 
	pop YL
	pop YH
	RET					;vuelve a la instruccion de donde vino (call delayx10ms) 
