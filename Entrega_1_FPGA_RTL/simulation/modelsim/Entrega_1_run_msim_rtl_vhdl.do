transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {/home/labarqcomp/Documents/Embarcados-Avancados/Entrega-1/toplevel.vhd}
vcom -93 -work work {/home/labarqcomp/Documents/Embarcados-Avancados/Entrega-1/stepmotor.vhd}

