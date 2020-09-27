#-------------------------------------------------------------------------------
# labo-2-synth-impl.tcl
#
# On peut lancer Vivado et l'exécution des commandes de ce fichier
# directement de l'invite de cmomande de Windows avec la commande :
# "C:\Xilinx\Vivado\2020.1\bin\vivado -mode tcl -source labo-2-synth-impl.tcl"
#
# On peut aussi lancer Vivado, puis copier-coller des commandes du présent fichier
# une à une ou en groupe, selon les besoins afin d'avancer dans le flot selon son rythme
# et les erreurs qui peuvent survenir.
#
#-------------------------------------------------------------------------------
#
# lecture des fichiers
remove_files [get_files]
read_vhdl -vhdl2008 ../musee_labo_2.vhd
read_vhdl -vhdl2008 ../basys_3_top_labo_2.vhd
read_vhdl -vhdl2008 ../inf3500_utilitaires_pkg.vhd
read_xdc ../basys-3-top.xdc

#synthese
synth_design -top basys_3_top_labo_2 -part xc7a35tcpg236-1 -assert

#implémentation (placement et routage)
place_design
route_design

#génération du fichier de configuration
write_bitstream -force basys_3_top_labo_2.bit

# programmation du FPGA
open_hw_manager
connect_hw_server
get_hw_targets
open_hw_target
current_hw_device [get_hw_devices xc7a35t_0]
set_property PROGRAM.FILE {basys_3_top_labo_2.bit} [get_hw_devices xc7a35t_0]
program_hw_devices [get_hw_devices xc7a35t_0]
