_DATA SEGMENT

sub_140426ba0   dq  140426ba0h

_DATA ENDS

_TEXT    SEGMENT

EXTERN homing_spell_trigger_injection_return: qword
EXTERN homing_spell_trigger_injection_helper_function: PROC

;Triggered when a homing spell (such as homing soul mass orb) is fired off
;Forcably send a type 1 packet out at this time, which we overload to include the relevant spell data
;We setup the data struct arg to the send packet function to our custom structure, which will be parsed opponent side by another injection

PUBLIC homing_spell_trigger_injection
homing_spell_trigger_injection PROC

cmp     dword ptr [rbx+9Ch], 10044000h ;check this homing bullet is from the PC, since we (the player with the bullet) are the sole decider of if it fires or not
jne     exit

sub     rsp, 8
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
sub     rsp, 20h

mov     ecx, dword ptr [rsp + 20h + 80h + 20h] ;get the bullet target entity id
lea     rdx, dword ptr [rbx+10h] ;get the bullet position
call    homing_spell_trigger_injection_helper_function

add     rsp, 20h
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
add     rsp, 8

;original code
exit:
movaps  xmm0, [rsp+020h]
lea     rdx, [rsp+060h]
movaps  xmm1, [rsp+030h]

jmp     homing_spell_trigger_injection_return

homing_spell_trigger_injection ENDP


EXTERN type1_p2pPacket_parse_injection_return: qword
extern type1_p2pPacket_parse_injection_helper_function: PROC

;Check if the incoming type1 packet is a magic specific custom struct (created above)
;If so, don't do the normal code and instead extact it and save it to be later used
PUBLIC type1_p2pPacket_parse_injection
type1_p2pPacket_parse_injection PROC

cmp     dword ptr [rsp+30h], 7fc00001h
jne     normal_exit

lea     rcx, [rsp+30h] ;the incoming packet data
sub     rsp, 30h ;align the stack and add shadow stack space
call    type1_p2pPacket_parse_injection_helper_function

;exit the function we've injected into
add     rsp, 90h
pop     rdi
ret

;original code
normal_exit:
movups  xmm0, [rsp+30h]
movzx   eax,bpl
movups  xmm1, [rsp+40h]

jmp     type1_p2pPacket_parse_injection_return

type1_p2pPacket_parse_injection ENDP


EXTERN homing_spell_checkIfTriggered_injection_return: qword
extern homing_spell_checkIfTriggered_injection_helper_function: PROC

;Inject where the bullet is checked if it has a target
;And if the bullet params match a received network packet's details, set it's target
PUBLIC homing_spell_checkIfTriggered_injection
homing_spell_checkIfTriggered_injection PROC

;original code
movaps  xmm2, xmm6
lea     rdx, [rsp+20h]
mov     rcx, rbx
call    qword ptr [sub_140426ba0]

;call the helper
sub     rsp, 8
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
sub     rsp, 20h

mov     rcx, rbx ;bulletIns
lea     rdx, dword ptr [rsp + 20h + 80h + 20h]; bulletParamEntry.target_id
call    homing_spell_checkIfTriggered_injection_helper_function

add     rsp, 20h
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
add     rsp, 8

jmp     homing_spell_checkIfTriggered_injection_return

homing_spell_checkIfTriggered_injection ENDP


_TEXT    ENDS

END
