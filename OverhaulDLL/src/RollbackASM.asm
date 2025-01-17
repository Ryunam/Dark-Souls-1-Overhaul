_DATA SEGMENT

_DATA ENDS

_TEXT    SEGMENT

EXTERN sendNetMessage_return: qword
extern sendNetMessage_helper: proc

PUBLIC sendNetMessage_injection
sendNetMessage_injection PROC
sub     rsp, 10h
movdqu  [rsp], xmm0
sub     rsp, 10h
movdqu  [rsp], xmm1
sub     rsp, 10h
movdqu  [rsp], xmm2
sub     rsp, 10h
movdqu  [rsp], xmm3
push    rcx
push    rdx
push    r8
push    r9
push    r10
push    r11
sub     rsp, 20h

mov     ecx, r8d ;packet type
call    sendNetMessage_helper

add     rsp, 20h
pop     r11
pop     r10
pop     r9
pop     r8
pop     rdx
pop     rcx
movdqu  xmm3, [rsp]
add     rsp, 10h
movdqu  xmm2, [rsp]
add     rsp, 10h
movdqu  xmm1, [rsp]
add     rsp, 10h
movdqu  xmm0, [rsp]
add     rsp, 10h

;check if we abort this call or not
test    eax, eax
jnz     normal
xor     al, al ;aborting call, so return false
ret

;original code
normal:
mov     rax, rsp
push    rdi
push    r12
push    r13
push    r14
push    r15
sub     rsp, 80h
jmp     sendNetMessage_return
sendNetMessage_injection ENDP


EXTERN getNetMessage_return: qword
extern getNetMessage_helper: proc

PUBLIC getNetMessage_injection
getNetMessage_injection PROC
sub     rsp, 10h
movdqu  [rsp], xmm0
sub     rsp, 10h
movdqu  [rsp], xmm1
sub     rsp, 10h
movdqu  [rsp], xmm2
sub     rsp, 10h
movdqu  [rsp], xmm3
push    rcx
push    rdx
push    r8
push    r9
push    r10
push    r11
sub     rsp, 20h

mov     ecx, r8d ;packet type
call    getNetMessage_helper

add     rsp, 20h
pop     r11
pop     r10
pop     r9
pop     r8
pop     rdx
pop     rcx
movdqu  xmm3, [rsp]
add     rsp, 10h
movdqu  xmm2, [rsp]
add     rsp, 10h
movdqu  xmm1, [rsp]
add     rsp, 10h
movdqu  xmm0, [rsp]
add     rsp, 10h

;check if we abort this call or not
test    eax, eax
jnz     normal
xor     eax, eax ;aborting call, so return 0 bytes
ret

;original code
normal:
mov     [rsp+8], rbx
mov     [rsp+10h], rbp
mov     [rsp+18h], rsi
jmp     getNetMessage_return
getNetMessage_injection ENDP


EXTERN send_generalplayerinfo_return: qword
extern send_generalplayerinfo_helper: proc

PUBLIC send_generalplayerinfo_injection
send_generalplayerinfo_injection PROC
;original code
mov     r11, rsp
push    rbp
push    rsi
lea     rbp, [r11-5Fh]
sub     rsp, 0B8h

sub     rsp, 10h
movdqu  [rsp], xmm0
sub     rsp, 10h
movdqu  [rsp], xmm1
sub     rsp, 10h
movdqu  [rsp], xmm2
sub     rsp, 10h
movdqu  [rsp], xmm3
push    rax
push    rcx
push    rdx
push    r8
push    r9
push    r10
push    r11
sub     rsp, 28h

mov     rcx, qword ptr [rdx+10h] ;pointer to the PlayerIns parent from PlayerCtrl
call    send_generalplayerinfo_helper

add     rsp, 28h
pop     r11
pop     r10
pop     r9
pop     r8
pop     rdx
pop     rcx
pop     rax
movdqu  xmm3, [rsp]
add     rsp, 10h
movdqu  xmm2, [rsp]
add     rsp, 10h
movdqu  xmm1, [rsp]
add     rsp, 10h
movdqu  xmm0, [rsp]
add     rsp, 10h

jmp     send_generalplayerinfo_return
send_generalplayerinfo_injection ENDP


EXTERN Read_GeneralPlayerData_return: qword
extern Read_GeneralPlayerData_helper: proc

PUBLIC Read_GeneralPlayerData_injection
Read_GeneralPlayerData_injection PROC
;original code
mov     r11, rsp
push    rbp
push    rdi
push    r15
lea     rbp, [r11-5Fh]
sub     rsp, 0D0h

sub     rsp, 10h
movdqu  [rsp], xmm0
sub     rsp, 10h
movdqu  [rsp], xmm1
sub     rsp, 10h
movdqu  [rsp], xmm2
sub     rsp, 10h
movdqu  [rsp], xmm3
;push    rax
push    rcx
push    rdx
push    r8
push    r9
push    r10
push    r11
sub     rsp, 20h

;NetworkManipulator is passed in implicitly as rcx
call    Read_GeneralPlayerData_helper
;rax gets set to a const afterwards, so we can clobber it here

add     rsp, 20h
pop     r11
pop     r10
pop     r9
pop     r8
pop     rdx
pop     rcx
;pop     rax
movdqu  xmm3, [rsp]
add     rsp, 10h
movdqu  xmm2, [rsp]
add     rsp, 10h
movdqu  xmm1, [rsp]
add     rsp, 10h
movdqu  xmm0, [rsp]
add     rsp, 10h

;the game for some reason still processes stuff from type1 even if it doesn't get any packet
;need to exit the function if we're in rollback netcode mode
cmp     rax, 0
je      no_rollback
ADD     RSP, 0D0h
POP     R15
POP     RDI
POP     RBP
RET
no_rollback:
jmp     Read_GeneralPlayerData_return
Read_GeneralPlayerData_injection ENDP

_TEXT    ENDS

END
