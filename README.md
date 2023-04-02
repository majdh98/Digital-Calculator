# Digital Calculator
> Authors: Majd Hamdan, Ruben Vargas

> ENGS 31 - Digital Electronics - Spring 2021 - Final Project
> June 8, 2021

## Overview
In this project, we implement a digital calculator that performs basic mathematical operations such as addition, subtraction, integer division, and multiplication on the [Basys3](https://digilent.com/shop/basys-3-artix-7-fpga-trainer-board-recommended-for-introductory-users/?utm_source=google&utm_medium=cpc&utm_campaign=19550988445&utm_content=148947439830&utm_term=basys%203&gclid=CjwKCAjwrJ-hBhB7EiwAuyBVXdngq3gFscy7oU0qUgXgxJvFHe25JyUn5sgmo0B9GMTEibJU9FXRcxoCqkQQAvD_BwE) FPGA board. We use VHDL to write the source code the calculator and Xilinx Vivado to perform RTL analysis, synthesis, debugging and implementation. 

Order of operations is as follows:
- Input numbers/operations to the Basys 3 board via SCI generator on the [AD2](https://digilent.com/reference/test-and-measurement/analog-discovery-2/start)
- Display the inputs on the 7-segment display
- Perform basic mathematical operations (addition, subtraction, integer division, and multiplication)
- Display the result on the 7-segment display

We use a “top-down” design approach in designing this calculator. We started with a high-level state machine to illustrate the entire process. Then, we move on to implement specific finite state machines and data paths for the digital calculator. As a result, the digital calculator is composed of three main components:
- [digital calculator shell](https://github.com/majdh98/Digital-Calculator/blob/main/digital_calculator_shell.vhd): Perform operations (i.e. subtraction, addition, and multiplication) on inputs.
- [Sci Receiver](https://github.com/majdh98/Digital-Calculator/blob/main/sci_reciever.vhd): Processes SCI packets from the AD2 and provide it to the calculator shell. 
- [ 7-segment Display](https://github.com/majdh98/Digital-Calculator/blob/main/7_segment_display.vhd): Display inputs, operations and outputs on the Basys3 board.

## Content
This repository contains:
- [Digital_Calculator.pdf](https://github.com/majdh98/Digital-Calculator/blob/main/Digital_Calculator.pdf): Digital Calculator full report showing: Top level block diagram, high level state machine, data path (block diagram), Controller (state diagram), and construction and debugging. 
- [Digital_Calculator_Vivado.zip](https://github.com/majdh98/Digital-Calculator/blob/main/Digital_Calculator_Vivado.zip): Vivado project containing RTL, synthesis and implementation of the calculator.
- [SCI_Receiver_Vivado.zip](https://github.com/majdh98/Digital-Calculator/blob/main/SCI_Receiver%20P_Vivado.zip): Vivado project containing RTL, synthesis and implementation of the SCI receiver. This is included in [Digital_Calculator_Vivado.zip](https://github.com/majdh98/Digital-Calculator/blob/main/Digital_Calculator_Vivado.zip) but a separate project was created for it for testing.
- [digital_calculator_shell.vhd](https://github.com/majdh98/Digital-Calculator/blob/main/digital_calculator_shell.vhd): VHDL code of the state machine and data path of the calculator shell.
- [digital_calculator_shell_test_bench.vhd](https://github.com/majdh98/Digital-Calculator/blob/main/digital_calculator_shell_test_bench.vhd): Test bench of the calculator shell. 
- [sci_reciever.vhd](https://github.com/majdh98/Digital-Calculator/blob/main/sci_reciever.vhd): VHDL code of the state machine and data path of the SCI receiver.
- [SCI_Reciever_test_bench.vhd](https://github.com/majdh98/Digital-Calculator/blob/main/SCI_Reciever_test_bench.vhd): Test bench of the SCI receiver.
- [7_segment_display.vhd](https://github.com/majdh98/Digital-Calculator/blob/main/7_segment_display.vhd): VHDL code of the 7 segment display. Adapted from Proff. E.W. Hansen code. 
- [Constraints.xdc](https://github.com/majdh98/Digital-Calculator/blob/main/Constraints.xdc): Constraints for the digital calculator for the Basys3 board

**Additionally, all code and test benches can be found EDA playground. The test bench can be run with different options on EDA playground. Links to the EDA projects: [Digital Calculator shell (entire project)](https://www.edaplayground.com/x/qhNa), [SCI reciever](https://www.edaplayground.com/x/SZ7T), [7-segment display](https://www.edaplayground.com/x/HE_d)**
