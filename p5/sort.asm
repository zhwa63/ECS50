SECTION .text

GLOBAL sort

sort:
  ; register usage:
  ; eax = &array[j]
  ; ebx = array[j]
  ; ecx = &array
  ; edx = temp
  ; esi = i
  ; edi = j
count_offset equ 12
array_offset equ 8

  push ebp
  mov ebp, esp
  push eax
  push ebx
  push ecx
  push edx
  push esi
  push edi

  mov esi, 1  ; i = 1
  mov ecx, [ebp + array_offset] ; ecx = &array

loop:
  cmp esi, [ebp + count_offset] ; if (i < count)
  jge done

  lea eax, [esi * 4]  ; eax = array offset
  add eax, ecx        ; eax = &array[i]
  mov edx, [eax]      ; temp = array[i]

  mov edi, esi        ; j = i
loop2: 
  dec edi             ; decrements j
  cmp edi, 0          ; if (j >= 0)
  jl loop3

  lea eax, [edi * 4]  ; calculate array offset
  add eax, ecx        ; eax = &array[j]
  mov ebx, [eax]      ; ebx = array[j]
  cmp edx, ebx        ; if (temp < array[j])
  jge loop3

  mov [eax + 4], ebx  ; array[j + 1] = array[j]

  jmp loop2

loop3:

  inc edi             ; j++
  lea eax, [edi * 4]  ; calculate array offset
  add eax, ecx        ; eax = &array[j + 1]
  mov [eax], edx      ; array[j + 1] = temp

  inc esi             ; i++
  jmp loop 

done:  
  pop edi
  pop esi
  pop edx
  pop ecx
  pop ebx
  pop eax
  pop ebp
  ret
