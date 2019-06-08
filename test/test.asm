* test patterns for Motorola m6800-assembly (as0)
* 
* symbol defs
val1    equ 254 ; decimal
val2    equ $fe ; hex
val3    equ %11111110 ; binary
val4    equ @376 ; octal
* expressions - there is no provision for parenthesized expressions
val5    equ val2*3 + $04 - $03/@2 % 33 & 0b0101 ~$fe | abc ^ dd ; arithmetic/bit operators
val6    equ $FFF0 ; addresss ref
* form constant ascii-bytes with single quote
        fcb 'a,'b,'z,'A,'Z,'0,'1,'9 ; alpha-numeric
        fcb '~, '`, '!, '@, '#, '$, '%, '^, '&, '*, '(, '), '-, '_, '=, '+ ; top row symbols
        fcb '{, '}, '[, '], '\, '|, ':, ';, '", '', '<, ',, '., '>, '/, '? ; other symbols
        fcb 'a' ; a closing quote is allowed with a single char per line
        fcb '  ; a space
        fcb 'zzz ; invalid
* comments
        ldaa #32 anything-after-operand style comments are not highlighed
* labels and strings  
label1:
        FCC "Hello, World"
        fcc 'hello 2;';''
        fcc ,HELLO 3, ; strings delimitered with non-quotes are valid, but not highlighted
* label too long, truncated without warning
underscored_label
        ldaa #1
l1:     inca
        bne l1
* index modes
        ldaa 2,x ; indexed
        staa $40,x ; indexed, hex
        cmpa %10101110,x ; indexed, binary
        cmpb @234,X ; indexed, octal
        cmpa val1,X ; indexed, symbol
        cmpa $45 ; zero page
        ldaa #32 ; immediate
        ldab #'A ; immediate, char
        anda #$ff ; immediate, hex
        anda #%10101001 ; immediate, binary
        anda #@4557 ; immediate, octal
        anda #val2 ; immediate, symbol
        ldx  pdata1*2 ; arithmetic op
        staa pdata1+$f
        anda #$aa&%01010111|$f0 ; bit op
val7    equ (32+$44-%01010011+(@372/4*($3444+2))) ;  parenthesized expressions are not supported
val8    equ $12-17+%0010*4/2 ; (18-17+2)*4/2 = 6
        cpx #$4fff
        org label1 + $400
        jsr colon_label
        jmp $4555
        jmp 29783
        jmp %1101000111110000
        jmp @23442
        bra *-$0f ; * = current_address, highlighted as a operator though
        LDAA #32
        LDAB #'C' ; with closing quote
        cmpb #'q'; comment right after the quote
colon_label:
        rti
* opcodes - all
        nop
        tap
        tpa
        inx
        dex
        clv
        sev
        clc
        sec
        cli
        sei
        sba
        cba
        tab
        tba
        daa
        aba
        bra label1
        bhi label1
        bls label1
        bcc label1
        bcs label1
        bne label1
        beq label1
        bvc label1
        bvs label1
        bpl label1
        bge label1
        blt label1
        bgt label1
        ble label1
        tsx
        ins
        pula
        pulb
        des
        txs
        psha
        pshb
        rts
        rti
        wai
        swi
        nega
        coma
        lsra
        rora
        asra
        asla
        rola
        deca
        inca
        tsta
        clra
        negb
        comb
        lsrb
        rorb
        asrb
        aslb
        rolb
        decb
        incb
        tstb
        clrb
        neg
        com
        lsr
        ror
        asr
        asl
        rol
        dec
        inc
        tst
        jmp
        clr
        suba
        cmpa
        sbca
        anda
        bita
        ldaa
        staa
        eora
        adca
        oraa
        adda
        cpx
        jsr
        lds
        sts
        subb
        cmpb
        sbcb
        andb
        bitb
        ldab
        stab
        eorb
        adcb
        orab
        addb
        ldx
        stx
* directives - all
        bsz
mylbl   equ 10
        fcb
        fcc
        fdb
        fill $55, 32
        opt s
        org
        page
        rmb
        zmb
        end ; undocumented supported
* true
* end
