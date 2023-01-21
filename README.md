# CanaryCell_row_decoder
DRAM row decoder for canary cell array; input is 17 bits of row address, output is 131072 row selects (one hot select)
Verilog RTL,  verilog synthesized netlist from Cadence  RTL Compiler (RC14.28), 400 MHz clock, with gscl45nm  ASIC std cell library; timing reports;
meets timing in 2.5 nsec, or 4 periods of a 1.6 GHz clock.
