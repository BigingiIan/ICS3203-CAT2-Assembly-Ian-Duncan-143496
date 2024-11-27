# 1. Control Flow and Conditional Logic
## Purpose:
This program prompts the user to enter a number and classifies it as POSITIVE, NEGATIVE, or ZERO using conditional and unconditional jumps.
## Compiling and Running:
### 1. Assemble the program:
`nasm -f elf32 control_flow.asm -o control_flow.o`
### 2. Link the object file:
`ld -m elf_i386 control_flow.o -o control_flow`
### 3. Run the program:
`./control_flow`
## Challenges/Insights:
Implementing logical branching with a mix of conditional (e.g., je, jg) and unconditional jumps (e.g., jmp) required careful flow control.
Ensuring all edge cases (positive, zero, and negative numbers) were handled correctly emphasized the importance of comparison order.

# 2. Array Manipulation with Looping and Reversal
## Purpose:
This program accepts an array of five integers as input, reverses it in place, and displays the reversed array.
## Compiling and Running:
### 1. Assemble the program:
`nasm -f elf32 array_reversal.asm -o array_reversal.o`
### 2. Link the object file:
`ld -m elf_i386 array_reversal.o -o array_reversal`
### 3. Run the program:
`./array_reversal`
## Challenges/Insights:
Reversing the array in place without additional memory was achieved using two pointers. Managing pointer arithmetic required careful attention to avoid overwriting values.
Understanding how stack-based loops worked in NASM helped to efficiently iterate through the array.

# 3. Modular Program with Subroutines for Factorial Calculation
## Purpose:
This program calculates the factorial of a given number using a recursive subroutine, with registers preserved using the stack.
## Compiling and Running:
### 1. Assemble the program:
`nasm -f elf32 factorial.asm -o factorial.o`
### 2. Link the object file:
`ld -m elf_i386 factorial.o -o factorial`
### 3. Run the program:
`./factorial`
## Challenges/Insights:
Implementing recursion in assembly required manually managing the stack to preserve values across calls.
Handling edge cases for 0! and 1! was straightforward but validating user input to stay within bounds (e.g., non-negative integers only) added complexity.
The print_number subroutine required converting multi-digit results (e.g., 5! = 120) to a string for output.

# 4. Data Monitoring and Control Using Port-Based Simulation
## Purpose:
This program simulates a control system that:
Reads a "sensor value" (e.g., water level).
Controls a "motor" (on/off) and triggers an "alarm" based on the sensor value.
Simulates memory-mapped I/O with specific memory locations.
## Compiling and Running:
### 1. Assemble the program:
`nasm -f elf32 data_monitoring.asm -o data_monitoring.o`
### 2. Link the object file:
`ld -m elf_i386 data_monitoring.o -o data_monitoring`
### 3. Run the program:
`./data_monitoring`
## Challenges/Insights:
Simulating hardware behavior using memory-mapped locations was an interesting abstraction.
Handling multiple thresholds (e.g., high, moderate) with nested conditional statements required careful flow control.
Debugging stack-based memory manipulation highlighted the importance of comments and program structure.

# General Compilation and Execution Notes
All programs are designed for 32-bit Linux systems and require a 32-bit assembler and linker (e.g., nasm and ld).
Ensure you are running on a system that supports 32-bit binaries (use a 32-bit environment or enable 32-bit compatibility on a 64-bit system).

# General Insights and Challenges
### 1. Register Management:
Preserving and restoring registers using the stack was a critical learning point, especially in modular programs.
### 2. Output Handling:
Printing multi-digit numbers required converting integers to ASCII and managing individual digits in a stack-based fashion.
### 3. Logical Flow:
Branching and looping logic in assembly language demanded careful ordering of comparisons and jump instructions.
### 4. Debugging:
Debugging assembly code with tools like gdb or strace proved invaluable for identifying stack and memory issues.
