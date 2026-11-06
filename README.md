# Round Robin Bus Arbiter

## Project Description
A Round Robin Bus Arbiter is a hardware arbitration mechanism
that provides fair access to a shared bus among multiple masters.

## Features
- Four bus masters
- Round Robin priority allocation
- Fair bus access
- Prevents starvation
- Verilog/SystemVerilog implementation
- Testbench verification

## Tools Used
- Verilog / SystemVerilog
- EDA Playground
- Questa / Icarus Verilog
- GitHub

## Project Files
- design.sv - RTL design
- testbench.sv - Verification testbench

## Simulation
The design is tested using a SystemVerilog testbench.
All four masters continuously request the bus to verify
the rotating grant sequence.

