## Generated SDC file "processor.sdc"

## Copyright (C) 2017  Intel Corporation. All rights reserved.
## Your use of Intel Corporation's design tools, logic functions 
## and other software and tools, and its AMPP partner logic 
## functions, and any output files from any of the foregoing 
## (including device programming or simulation files), and any 
## associated documentation or information are expressly subject 
## to the terms and conditions of the Intel Program License 
## Subscription Agreement, the Intel Quartus Prime License Agreement,
## the Intel FPGA IP License Agreement, or other applicable license
## agreement, including, without limitation, that your use is for
## the sole purpose of programming logic devices manufactured by
## Intel and sold by Intel or its authorized distributors.  Please
## refer to the applicable agreement for further details.


## VENDOR  "Altera"
## PROGRAM "Quartus Prime"
## VERSION "Version 17.1.0 Build 590 10/25/2017 SJ Lite Edition"

## DATE    "Fri May 20 14:55:19 2022"

##
## DEVICE  "EP4CE30F23I7"
##


#**************************************************************
# Time Information
#**************************************************************

set_time_format -unit ns -decimal_places 3



#**************************************************************
# Create Clock
#**************************************************************

create_clock -name {altera_reserved_tck} -period 100.000 -waveform { 0.000 50.000 } [get_ports {altera_reserved_tck}]
create_clock -name {clock} -period 25.000 -waveform { 0.000 12.500 } [get_ports {clock}]


#**************************************************************
# Create Generated Clock
#**************************************************************



#**************************************************************
# Set Clock Latency
#**************************************************************



#**************************************************************
# Set Clock Uncertainty
#**************************************************************

set_clock_uncertainty -rise_from [get_clocks {clock}] -rise_to [get_clocks {clock}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {clock}] -fall_to [get_clocks {clock}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {clock}] -rise_to [get_clocks {clock}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {clock}] -fall_to [get_clocks {clock}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {altera_reserved_tck}] -rise_to [get_clocks {altera_reserved_tck}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {altera_reserved_tck}] -fall_to [get_clocks {altera_reserved_tck}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {altera_reserved_tck}] -rise_to [get_clocks {altera_reserved_tck}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {altera_reserved_tck}] -fall_to [get_clocks {altera_reserved_tck}]  0.020  


#**************************************************************
# Set Input Delay
#**************************************************************

set_input_delay -add_delay  -clock [get_clocks {clock}]  0.000 [get_ports {altera_reserved_tck}]
set_input_delay -add_delay  -clock [get_clocks {clock}]  0.000 [get_ports {altera_reserved_tdi}]
set_input_delay -add_delay  -clock [get_clocks {clock}]  0.000 [get_ports {altera_reserved_tms}]
set_input_delay -add_delay  -clock [get_clocks {clock}]  0.000 [get_ports {clock}]
set_input_delay -add_delay  -clock [get_clocks {clock}]  0.000 [get_ports {exec}]
set_input_delay -add_delay  -clock [get_clocks {clock}]  0.000 [get_ports {in[0]}]
set_input_delay -add_delay  -clock [get_clocks {clock}]  0.000 [get_ports {in[1]}]
set_input_delay -add_delay  -clock [get_clocks {clock}]  0.000 [get_ports {in[2]}]
set_input_delay -add_delay  -clock [get_clocks {clock}]  0.000 [get_ports {in[3]}]
set_input_delay -add_delay  -clock [get_clocks {clock}]  0.000 [get_ports {in[4]}]
set_input_delay -add_delay  -clock [get_clocks {clock}]  0.000 [get_ports {in[5]}]
set_input_delay -add_delay  -clock [get_clocks {clock}]  0.000 [get_ports {in[6]}]
set_input_delay -add_delay  -clock [get_clocks {clock}]  0.000 [get_ports {in[7]}]
set_input_delay -add_delay  -clock [get_clocks {clock}]  0.000 [get_ports {in[8]}]
set_input_delay -add_delay  -clock [get_clocks {clock}]  0.000 [get_ports {in[9]}]
set_input_delay -add_delay  -clock [get_clocks {clock}]  0.000 [get_ports {in[10]}]
set_input_delay -add_delay  -clock [get_clocks {clock}]  0.000 [get_ports {in[11]}]
set_input_delay -add_delay  -clock [get_clocks {clock}]  0.000 [get_ports {in[12]}]
set_input_delay -add_delay  -clock [get_clocks {clock}]  0.000 [get_ports {in[13]}]
set_input_delay -add_delay  -clock [get_clocks {clock}]  0.000 [get_ports {in[14]}]
set_input_delay -add_delay  -clock [get_clocks {clock}]  0.000 [get_ports {in[15]}]
set_input_delay -add_delay  -clock [get_clocks {clock}]  0.000 [get_ports {reset}]


#**************************************************************
# Set Output Delay
#**************************************************************

set_output_delay -add_delay  -clock [get_clocks {clock}]  0.000 [get_ports {LED_a[0]}]
set_output_delay -add_delay  -clock [get_clocks {clock}]  0.000 [get_ports {LED_a[1]}]
set_output_delay -add_delay  -clock [get_clocks {clock}]  0.000 [get_ports {LED_a[2]}]
set_output_delay -add_delay  -clock [get_clocks {clock}]  0.000 [get_ports {LED_a[3]}]
set_output_delay -add_delay  -clock [get_clocks {clock}]  0.000 [get_ports {LED_a[4]}]
set_output_delay -add_delay  -clock [get_clocks {clock}]  0.000 [get_ports {LED_a[5]}]
set_output_delay -add_delay  -clock [get_clocks {clock}]  0.000 [get_ports {LED_a[6]}]
set_output_delay -add_delay  -clock [get_clocks {clock}]  0.000 [get_ports {LED_a[7]}]
set_output_delay -add_delay  -clock [get_clocks {clock}]  0.000 [get_ports {LED_b[0]}]
set_output_delay -add_delay  -clock [get_clocks {clock}]  0.000 [get_ports {LED_b[1]}]
set_output_delay -add_delay  -clock [get_clocks {clock}]  0.000 [get_ports {LED_b[2]}]
set_output_delay -add_delay  -clock [get_clocks {clock}]  0.000 [get_ports {LED_b[3]}]
set_output_delay -add_delay  -clock [get_clocks {clock}]  0.000 [get_ports {LED_b[4]}]
set_output_delay -add_delay  -clock [get_clocks {clock}]  0.000 [get_ports {LED_b[5]}]
set_output_delay -add_delay  -clock [get_clocks {clock}]  0.000 [get_ports {LED_b[6]}]
set_output_delay -add_delay  -clock [get_clocks {clock}]  0.000 [get_ports {LED_b[7]}]
set_output_delay -add_delay  -clock [get_clocks {clock}]  0.000 [get_ports {LED_c[0]}]
set_output_delay -add_delay  -clock [get_clocks {clock}]  0.000 [get_ports {LED_c[1]}]
set_output_delay -add_delay  -clock [get_clocks {clock}]  0.000 [get_ports {LED_c[2]}]
set_output_delay -add_delay  -clock [get_clocks {clock}]  0.000 [get_ports {LED_c[3]}]
set_output_delay -add_delay  -clock [get_clocks {clock}]  0.000 [get_ports {LED_c[4]}]
set_output_delay -add_delay  -clock [get_clocks {clock}]  0.000 [get_ports {LED_c[5]}]
set_output_delay -add_delay  -clock [get_clocks {clock}]  0.000 [get_ports {LED_c[6]}]
set_output_delay -add_delay  -clock [get_clocks {clock}]  0.000 [get_ports {LED_c[7]}]
set_output_delay -add_delay  -clock [get_clocks {clock}]  0.000 [get_ports {LED_d[0]}]
set_output_delay -add_delay  -clock [get_clocks {clock}]  0.000 [get_ports {LED_d[1]}]
set_output_delay -add_delay  -clock [get_clocks {clock}]  0.000 [get_ports {LED_d[2]}]
set_output_delay -add_delay  -clock [get_clocks {clock}]  0.000 [get_ports {LED_d[3]}]
set_output_delay -add_delay  -clock [get_clocks {clock}]  0.000 [get_ports {LED_d[4]}]
set_output_delay -add_delay  -clock [get_clocks {clock}]  0.000 [get_ports {LED_d[5]}]
set_output_delay -add_delay  -clock [get_clocks {clock}]  0.000 [get_ports {LED_d[6]}]
set_output_delay -add_delay  -clock [get_clocks {clock}]  0.000 [get_ports {LED_d[7]}]
set_output_delay -add_delay  -clock [get_clocks {clock}]  0.000 [get_ports {LED_e[0]}]
set_output_delay -add_delay  -clock [get_clocks {clock}]  0.000 [get_ports {LED_e[1]}]
set_output_delay -add_delay  -clock [get_clocks {clock}]  0.000 [get_ports {LED_e[2]}]
set_output_delay -add_delay  -clock [get_clocks {clock}]  0.000 [get_ports {LED_e[3]}]
set_output_delay -add_delay  -clock [get_clocks {clock}]  0.000 [get_ports {LED_e[4]}]
set_output_delay -add_delay  -clock [get_clocks {clock}]  0.000 [get_ports {LED_e[5]}]
set_output_delay -add_delay  -clock [get_clocks {clock}]  0.000 [get_ports {LED_e[6]}]
set_output_delay -add_delay  -clock [get_clocks {clock}]  0.000 [get_ports {LED_e[7]}]
set_output_delay -add_delay  -clock [get_clocks {clock}]  0.000 [get_ports {LED_f[0]}]
set_output_delay -add_delay  -clock [get_clocks {clock}]  0.000 [get_ports {LED_f[1]}]
set_output_delay -add_delay  -clock [get_clocks {clock}]  0.000 [get_ports {LED_f[2]}]
set_output_delay -add_delay  -clock [get_clocks {clock}]  0.000 [get_ports {LED_f[3]}]
set_output_delay -add_delay  -clock [get_clocks {clock}]  0.000 [get_ports {LED_f[4]}]
set_output_delay -add_delay  -clock [get_clocks {clock}]  0.000 [get_ports {LED_f[5]}]
set_output_delay -add_delay  -clock [get_clocks {clock}]  0.000 [get_ports {LED_f[6]}]
set_output_delay -add_delay  -clock [get_clocks {clock}]  0.000 [get_ports {LED_f[7]}]
set_output_delay -add_delay  -clock [get_clocks {clock}]  0.000 [get_ports {LED_g[0]}]
set_output_delay -add_delay  -clock [get_clocks {clock}]  0.000 [get_ports {LED_g[1]}]
set_output_delay -add_delay  -clock [get_clocks {clock}]  0.000 [get_ports {LED_g[2]}]
set_output_delay -add_delay  -clock [get_clocks {clock}]  0.000 [get_ports {LED_g[3]}]
set_output_delay -add_delay  -clock [get_clocks {clock}]  0.000 [get_ports {LED_g[4]}]
set_output_delay -add_delay  -clock [get_clocks {clock}]  0.000 [get_ports {LED_g[5]}]
set_output_delay -add_delay  -clock [get_clocks {clock}]  0.000 [get_ports {LED_g[6]}]
set_output_delay -add_delay  -clock [get_clocks {clock}]  0.000 [get_ports {LED_g[7]}]
set_output_delay -add_delay  -clock [get_clocks {clock}]  0.000 [get_ports {LED_h[0]}]
set_output_delay -add_delay  -clock [get_clocks {clock}]  0.000 [get_ports {LED_h[1]}]
set_output_delay -add_delay  -clock [get_clocks {clock}]  0.000 [get_ports {LED_h[2]}]
set_output_delay -add_delay  -clock [get_clocks {clock}]  0.000 [get_ports {LED_h[3]}]
set_output_delay -add_delay  -clock [get_clocks {clock}]  0.000 [get_ports {LED_h[4]}]
set_output_delay -add_delay  -clock [get_clocks {clock}]  0.000 [get_ports {LED_h[5]}]
set_output_delay -add_delay  -clock [get_clocks {clock}]  0.000 [get_ports {LED_h[6]}]
set_output_delay -add_delay  -clock [get_clocks {clock}]  0.000 [get_ports {LED_h[7]}]
set_output_delay -add_delay  -clock [get_clocks {clock}]  0.000 [get_ports {SEL[0]}]
set_output_delay -add_delay  -clock [get_clocks {clock}]  0.000 [get_ports {SEL[1]}]
set_output_delay -add_delay  -clock [get_clocks {clock}]  0.000 [get_ports {SEL[2]}]
set_output_delay -add_delay  -clock [get_clocks {clock}]  0.000 [get_ports {SEL[3]}]
set_output_delay -add_delay  -clock [get_clocks {clock}]  0.000 [get_ports {SEL[4]}]
set_output_delay -add_delay  -clock [get_clocks {clock}]  0.000 [get_ports {SEL[5]}]
set_output_delay -add_delay  -clock [get_clocks {clock}]  0.000 [get_ports {SEL[6]}]
set_output_delay -add_delay  -clock [get_clocks {clock}]  0.000 [get_ports {SEL[7]}]
set_output_delay -add_delay  -clock [get_clocks {clock}]  0.000 [get_ports {altera_reserved_tdo}]


#**************************************************************
# Set Clock Groups
#**************************************************************

set_clock_groups -asynchronous -group [get_clocks {altera_reserved_tck}] 


#**************************************************************
# Set False Path
#**************************************************************



#**************************************************************
# Set Multicycle Path
#**************************************************************



#**************************************************************
# Set Maximum Delay
#**************************************************************



#**************************************************************
# Set Minimum Delay
#**************************************************************



#**************************************************************
# Set Input Transition
#**************************************************************

