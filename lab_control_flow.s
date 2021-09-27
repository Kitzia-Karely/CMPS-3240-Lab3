	.file	"lab_control_flow.c"
	.text
	.globl	user_response
	.bss
	.align 4
	.type	user_response, @object
	.size	user_response, 4
user_response:
	.zero	4
	.section	.rodata
	.align 8
.LC0:
	.string	"==============================="
	.align 8
.LC1:
	.string	"Welcome, here are your options:"
.LC2:
	.string	"1. View employee data"
.LC3:
	.string	"2. View customer data"
.LC4:
	.string	"10. Quit"
.LC5:
	.string	"Enter your response now:"
.LC6:
	.string	"%d"

/* Data to be printed out */
empData:
    .string "Kitzia Gonzalez, 21, 1999"

custData:
    .string "John Doe, 55, blah blah"
/* ------------------------------------ */

	.text
	.globl	main
	.type	main, @function
main:
.LFB0:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6

/* Print options */
loopbody:
	leaq	.LC0(%rip), %rdi
	call	puts@PLT
	leaq	.LC1(%rip), %rdi
	call	puts@PLT
	leaq	.LC2(%rip), %rdi
	call	puts@PLT
	leaq	.LC3(%rip), %rdi
	call	puts@PLT
	leaq	.LC4(%rip), %rdi
	call	puts@PLT
	leaq	.LC0(%rip), %rdi
	call	puts@PLT
	leaq	.LC5(%rip), %rdi
	call	puts@PLT

/* Get user's answer */
looptop:
	leaq	user_response(%rip), %rsi
	leaq	.LC6(%rip), %rdi
	movl	$0, %eax
	call	__isoc99_scanf@PLT

/* If statements */
    movl user_response(%rip), %eax
    /* If user_response - 1 = 0 ==> jump to employeeData */
    cmpl $1, %eax  
    je  employeeData

    /* If user_response - 2 = 0 ==> jump to customerData */
    movl user_response(%rip), %eax
    cmpl $2, %eax
    je customerData
    
    /* If user_response != 10, print options again
     * If user_response == 10, jump to loopquit to exit loop */
    movl user_response(%rip), %eax
    cmpl $10, %eax
    jne loopbody
    je loopquit

/* Print employee data for option 1 */
employeeData:
    leaq    empData(%rip), %rdi
    call    puts@PLT
    jmp     loopbody

/* Print customer data for option 2 */
customerData:
    leaq    custData(%rip), %rdi
    call    puts@PLT
    jmp     loopbody

/* Exit loop when user enters 10 */
loopquit:
    movl $1, %eax
    popq    %rbp
    ret
    .cfi_endproc

.LFE0:
	.size	main, .-main
	.ident	"GCC: (Debian 8.3.0-6) 8.3.0"
	.section	.note.GNU-stack,"",@progbits
