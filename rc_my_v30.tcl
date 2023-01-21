
# All HDL files, separated by spaces
set hdl_files { row_decoder.v }

set DESIGN row_decoder 

set clkpin clock 

#  CLOCK PERIODS in PICOSECONDS

#  625 psec
#set period 625 

# 2.5 nsec 
set period 2500

# /home1/fac1/amitrt/PDKs/FreePDK45/osu_soc/lib/freepdk45_cells/


#set osucells $env(OSU_FREEPDK)

#set osucells $env(NCSU_PDK)

set_attribute hdl_search_path {./} /
set_attribute lib_search_path ./ /

set_attribute information_level 6 /

# this is the same .lib as in 
#  /home1/fac1/amitrt/PDKs/FreePDK45/osu_soc/lib/files/gscl45nm.lib
#   but copied in my current (pwd) directory where this script lives
#
set_attribute library gscl45nm.lib

#set_attribute library NCSU_TechLib_FreePDK

read_hdl ${hdl_files}

elaborate $DESIGN

# Apply Constraints

set clock [define_clock -period ${period} -name ${clkpin} [clock_ports]]	
external_delay -input   0 -clock clock [find / -port ports_in/*]
external_delay -output  0 -clock clock [find / -port ports_out/*]
# Sets transition to default values for Synopsys SDC format, fall/rise
# 400ps
dc::set_clock_transition .2 clock 

report clocks > report_clocks_2.5nsec_rep.txt

check_design -unresolved

report timing -lint > report_timing_lint_2.5nsec.rep

#*Synthesis
synthesize -to_mapped


report timing > timing_2.5nsec.rep
report gates  > cell_2.5nsec.rep
report power  > power_2.5nsec.rep

write_hdl -mapped >  ${DESIGN}_2.5nsec.vh
write_sdc >  ${DESIGN}_2.5nsec.sdc



