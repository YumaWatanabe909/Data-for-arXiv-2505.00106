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

# setting
set xlabel 'J/U'
set ylabel 'none'

set xrange [0.2:0.46]
set xtics 0.2,0.05,0.45
set mxtics 5

set yrange [0.0:0.75]
set ytics 0.0,0.2,0.8
set mytics 2

set key top right

Lnum = 3 
array Ls = [64,128,256]

Fnum = 3
array filenames = ["SuperfluidOrderParameter", "StringOrderParameter", "DensityWaveOrderParameter"]

do for [f=1:Fnum]{
set ylabel sprintf('%s', filenames[f])

if (filenames[f] eq "SuperfluidOrderParameter"){
  set output sprintf('%s.png', filenames[f])
  plot for [l=1:Lnum] sprintf('L%d/%s.dat', Ls[l], filenames[f]) w lp lw 2 ps 1.2 pt l t sprintf('L = %d', Ls[l])
}else{
  set output sprintf('%s.png', filenames[f])
  plot for [l=1:Lnum-1] sprintf('L%d/%s.dat', Ls[l], filenames[f]) w lp lw 2 ps 1.2 pt l t sprintf('L = %d', Ls[l])

}
}




### Superfluid correlation function in log log scale
# setting
set logscale
set xlabel 'r'
unset xrange
set ylabel 'C_{SF}(r)'
unset yrange
set format y '10^{%L}'
set key bottom left

Jnum = 4
array Js[Jnum] = [0.30,0.32,0.34,0.36]
dirname = "L256/variable_J"

set output 'sfcor.png'
plot for [j=1:Jnum] sprintf('%s/J_%f/SuperFluidCorrelator_bandA.dat', dirname, Js[j]) w p ps 0.7 pt j lc j t sprintf('J = %.2f', Js[j])


### String order parameter
# setting
unset logscale
set xlabel '1/L'
set xrange [0.0:0.016]
set xtics 0.0,0.004,0.02
set mxtics 4
set ylabel 'O_{STG}'
set format y '%g'
set yrange [0:0.03]
set ytics 0.0,0.01,0.03
set mytics 2
set key top left

# fitting
f_sf(x)  = a_sf * x + b_sf
f_hsf(x) = a_hsf * x + b_hsf
fit f_sf(x)  'phases/SF_J0.46/StringOrderParameter.txt' u (1.0/($1)):2 via a_sf, b_sf
fit f_hsf(x) 'phases/HSF_J0.38/StringOrderParameter.dat' u (1.0/($1)):2 via a_hsf, b_hsf


# plot HSF & SF
set output 'stgop.png'
plot 'phases/SF_J0.46/StringOrderParameter.txt' u (1.0/($1)):2 w p pt 5 ps 1.1 lc 'blue' t 'SF',\
     'phases/HSF_J0.38/StringOrderParameter.dat' u (1.0/($1)):2 w p pt 7 ps 1.2 lc 'red' t 'HSF',\
     f_sf(x) w l lw 2 lc 'blue' t '',\
     f_hsf(x) w l lw 2 lc 'red' t ''

