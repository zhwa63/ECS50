//Authors:Angela(Haowen) Zhou && Courtney Laux
#include <stdio.h>

void sort(int ar[], int n)
{
	asm(".intel_syntax noprefix\n\t"
//sort:
  // register usage:
  // eax = &array[j]
  // ebx = array[j]
  // ecx = &array
  // edx = temp
  // esi = i
  // edi = j
//count_offset equ 12
//array_offset equ 8

  "push ebp\n\t"
  "mov ebp, esp\n\t"
  "push eax\n\t"
  "push ebx\n\t"
  "push ecx\n\t"
  "push edx\n\t"
  "push esi\n\t"
  "push edi\n\t"


  "mov esi, 1\n\t"
  "mov ecx, [ebp + 8]\n\t"

"loop:\n\t"
  "cmp esi, [ebp + 12]\n\t"
  "jge done\n\t"

  "lea eax, [esi * 4]\n\t"
  "add eax, ecx\n\t"
  "mov edx, [eax]\n\t"

  "mov edi, esi\n\t"
  "loop2:\n\t"
  "dec edi\n\t"
  "cmp edi, 0\n\t"
  "jl loop3\n\t"

  "lea eax, [edi * 4]\n\t"
  "add eax, ecx\n\t"
  "mov ebx, [eax]\n\t"
  "cmp edx, ebx\n\t"
  "jge loop3\n\t"

  "mov [eax + 4], ebx\n\t"

  "jmp loop2\n\t"

"loop3:\n\t"

  "inc edi\n\t"
  "lea eax, [edi * 4]\n\t"
  "add eax, ecx\n\t"
  "mov [eax], edx\n\t"

  "inc esi\n\t"
  "jmp loop\n\t" 

"done:\n\t"  
 "pop edi\n\t"
  "pop esi\n\t"
  "pop edx\n\t"
  "pop ecx\n\t"
  "pop ebx\n\t"
  "pop eax\n\t"
  "pop ebp\n\t"
  "ret\n\t");

} // sort()

int main()
{
  int i, ar[10] = {5, 8, 12, 2, 1, 7};
  sort(ar, 6);
  for(i = 0; i < 6; i++)
  	printf("%d\n", ar[i]);
  	
  return 0;
} // main


