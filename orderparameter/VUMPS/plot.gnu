#!/usr/bin/gnuplot -persist
#
#    
#    	G N U P L O T
#    	Version 5.4 patchlevel 2    last modified 2021-06-01 
#    
#    	Copyright (C) 1986-1993, 1998, 2004, 2007-2021
#    	Thomas Williams, Colin Kelley and many others
#    
#    	gnuplot home:     http://www.gnuplot.info
#    	faq, bugs, etc:   type "help FAQ"
#    	immediate help:   type "help"  (plot window: hit 'h')
# set terminal qt 0 font "Times,18"
# set output


set term png font 'Times,18'

## order parameter
# setting
set xlabel 'J/U'
set xrange [0.30:0.38]
set xtics 0.3,0.01,0.38
set mxtics 1
set ylabel 'O_{STG}'
set yrange [0.0:0.1]
set ytics 0.0,0.05,0.1
set mytics 5
set key center right

# stgop
set output 'stgop.png'
plot 'stgop/stgop_systemsize_expofit_maxdim250.dat' w lp lw 1.5 pt 7 ps 1 lc 'black' t '{/Symbol c} = 250',\
'stgop/stgop_systemsize_expofit_maxdim450.dat' w lp lw 1.5 pt 5 ps 1 lc 'black' t '{/Symbol c} = 450'

# sfcor at R
set term png font 'Times,18'
set key left top
set xlabel 'J/U'
set ylabel'O_{SF}'

set output 'sfcor_atR200.png'
plot 'sfcor/maxdim_250/sfcor_atR200.dat' w lp lw 1.5 pt 7 ps 1 lc 'black' t '{/Symbol c} = 250',\
'sfcor/maxdim_450/sfcor_atR200.dat' w lp lw 1.5 pt 5 ps 1 lc 'black' t '{/Symbol c} = 450'


## fitting of string order parameter
# setting
set xlabel '1/L'
set ylabel 'O_{STG}({/Symbol c} = 450)'
set xrange [0.0:0.01]
set xtics 0.0,0.005,0.01
set mxtics 5
set yrange [0:0.08]
set ytics 0.0,0.02,0.08
set mytics 2
set key center left

# load fitting function
load 'stgop/J0.31/maxdim_450/var_fitfunc.var'
a1 = a
b1 = b
f1(x) = a1*exp(-b1*x)

load 'stgop/J0.32/maxdim_450/var_fitfunc.var'
a2 = a
b2 = b
f2(x) = a2*exp(-b2*x)

load 'stgop/J0.33/maxdim_450/var_fitfunc.var'
a3 = a
b3 = b
f3(x) = a3*exp(-b3*x)

load 'stgop/J0.34/maxdim_450/var_fitfunc.var'
a4 = a
b4 = b
f4(x) = a4*exp(-b4*x)

filename = "maxdim_450/stgop_bandA_systemsize_defR_L_largest.dat"
Jnum = 4
array Js = [0.31,0.32,0.33,0.34]
set output 'stgop_systemsizescaling.png'
plot for [j=1:Jnum] sprintf('stgop/J%.2f/%s', Js[j], filename) u (1.0/($1)):2 w p pt 3+2*j lc j t sprintf('J = %.2f', Js[j]),\
f1(x) w l lw 1.5 lc 1 t '',\
f2(x) w l lw 1.5 lc 2 t '',\
f3(x) w l lw 1.5 lc 3 t '',\
f4(x) w l lw 1.5 lc 4 t ''



## stg correlation function
# setting
set xlabel 'r'
set ylabel 'C_{STG}(r)({/Symbol c} = 450, L = 400)'
set logscale x
unset xrange
set xtics auto
set mxtics 10
set yrange [0:0.3]
set ytics 0.0,0.05,0.3
set mytics 2
set key center right

filename = "maxdim_450/mappedMPS/systemsize_400/STGcor_bandA.dat"
Jnum = 4
array Js = [0.31,0.32,0.33,0.34]
set output 'stgcor_maxdim450_L400.png'
plot for [j=1:Jnum] sprintf('stgop/J%.2f/%s', Js[j], filename) w p pt 13-j*2 ps 0.6 lc j t sprintf('J = %.2f', Js[j])

unset logscale


## SF correlation function
# settings
set xlabel 'r'
unset xrange
set xtics auto
set mxtics 10
set ylabel 'C_{SF}(r)'
unset yrange
set ytics auto
set mytics 10
set format y '10^{%L}'
set logscale
set key left bottom

Jnum = 4
array Js = [0.30,0.32,0.34,0.36]
set output 'sfcor_maxdim450.png'
plot for [j=1:Jnum] sprintf('sfcor/maxdim_450/varying_J/J_%.3f/SFcor_bandA.dat', Js[j]) w p pt 13-2*j ps 0.7 lc j t sprintf('J = %.2f', Js[j])

set format y '{%g}'
unset logscal

