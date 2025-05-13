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

# Run this after running 'fit.o'

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

# upto 40 (lowest spectrum only) + spectrum at infinite bond dimension limit
set xrange [:40]
set output sprintf('%s/entanglementspectrum_upto40.png', dirnames[d])
plot for [i=1:chinum] sprintf('%s/maxdim_%d/entanglementspectrum_infinite.dat', dirnames[d], chis[i]) w p pt 2*i lc 'grey50' t sprintf('{/Symbol c} = %d', chis[i]),\
sprintf('%s/labels/spectrum_atInfiniteBonddim.dat', dirnames[d]) w p pt 7 lc 'black' t '{/Symbol c} = inf'

}
#    EOF
