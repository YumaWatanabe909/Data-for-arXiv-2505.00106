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

set term png font 'Times, 15'

## entanglement spectrum
# dir 
dirnum = 3
array dirnames = ["HI_J0.30", "HSF_J0.38", "SF_J0.46"]

# bond dim
chinum = 9
array chis[chinum]
do for [i=1:chinum:1]{
chis[i] = 50 + 50*(i-1)
}


do for [d = 1:dirnum]{

set xlabel 'i'
set ylabel 'spectrum {/Symbol x}_i'
set key right bottom

# entire
unset xrange
set output sprintf('%s/entanglementspectrum_entire.png', dirnames[d])
plot for [i=1:chinum] sprintf('%s/maxdim_%d/entanglementspectrum_infinite.dat', dirnames[d], chis[i]) w p pt 7 t sprintf('maxdim = %d', chis[i])

# upto 40 (lowest spectrum only)
set xrange [:40]
set output sprintf('%s/entanglementspectrum_upto40.png', dirnames[d])
set output 'entanglementspectrum_upto40.png'
plot for [i=1:chinum] sprintf('%s/maxdim_%d/entanglementspectrum_infinite.dat', dirnames[d], chis[i]) w p pt 7 t sprintf('maxdim = %d', chis[i])


}
#    EOF
