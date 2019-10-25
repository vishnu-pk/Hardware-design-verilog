transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+E:/Masters/Computer\ Hardware\ Design/Lab/Lab\ 8 {E:/Masters/Computer Hardware Design/Lab/Lab 8/part3.v}

