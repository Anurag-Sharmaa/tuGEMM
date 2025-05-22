tuGEMM: Temporal Unary GEMM in Verilog
This repository contains the Verilog HDL implementation of the tuGEMM architecture for performing General Matrix Multiplication (GEMM) on 2×2, 4×4, and 8×8 matrices. The design is based on the Temporal Unary GEMM (tuGEMM) methodology proposed for efficient low-precision matrix multiplication in edge AI applications.

Description
The project implements the tuGEMM architecture to achieve area- and power-efficient matrix multiplication using unary computing techniques. The Verilog code is written to support matrix sizes of 2×2, 4×4, and 8×8, and is suitable for FPGA synthesis and testing. The implementation focuses on parallelism and temporal encoding to reduce hardware resource consumption, making it ideal for energy-constrained edge devices.

The design closely follows the architecture proposed in the following paper:

H. Nair et al.,
"tuGEMM: Area-Power-Efficient Temporal Unary GEMM Architecture for Low-Precision Edge AI,"
2023 IEEE International Symposium on Circuits and Systems (ISCAS), Monterey, CA, USA, 2023, pp. 1–5.
DOI: 10.1109/ISCAS46773.2023.10181357

