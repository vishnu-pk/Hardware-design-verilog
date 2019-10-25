transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+E:/Masters/Computer\ Hardware\ Design/Lab/Lab\ 8/Fitzmorris {E:/Masters/Computer Hardware Design/Lab/Lab 8/Fitzmorris/part1.v}

