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

elenum = 14
array Js[elenum]
do for [i=1:elenum]{ Js[i] = 0.2 + (i-1)*0.02 }

set output 'entire_sfcor.png'
plot for [i=1:elenum] sprintf('variable_J/J_%f/SuperFluidCorrelator_bandA.dat', Js[i]) w p ps 1.5 t sprintf('J = %.2f', Js[i])

set key bottom left
set logscale y
set output 'entire_sfcor_semilog.png'
replot

set logscale
set output 'entire_sfcor_loglog.png'
replot


set key top right
unset logscale
set output 'J0.3to0.46_sfcor.png'
plot for [i=6:elenum] sprintf('variable_J/J_%f/SuperFluidCorrelator_bandA.dat', Js[i]) w p ps 1.5 t sprintf('J = %.2f', Js[i])


set key bottom left
set logscale y
set output 'J0.3to0.46_sfcor_semilog.png'
replot

set logscale
set output 'J0.3to0.46_sfcor_loglog.png'
replot


unset logscale
#    EOF
