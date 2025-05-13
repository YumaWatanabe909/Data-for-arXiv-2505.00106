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

# energy density
unset xrange
set xlabel 'maxdim {/Symbol c}'
set ylabel 'energy density'

set key center right

set output 'energydensity.png'
plot 'energydensity.dat' u 1:2 w p pt 7 lc 'black' t 'entire',\
     'energydensity.dat' u 1:3 w p pt 7 ps 1.2 lc 'red' t 'band A',\
     'energydensity.dat' u 1:4 w p pt 7 lc 'blue' t 'band B'


# particle density
unset xrange
set xlabel 'maxdim {/Symbol c}'
set ylabel 'particle density'

set key center right

set output 'particledensity.png'
plot 'particledensity.dat' u 1:2 w p pt 7 lc 'black' t 'entire',\
     'particledensity.dat' u 1:3 w p pt 7 ps 1.2 lc 'red' t 'band A',\
     'particledensity.dat' u 1:4 w p pt 7 lc 'blue' t 'band B'


# entropy
unset xrange
set xlabel 'maxdim {/Symbol c}'
set ylabel 'entropy'

set key top right

set output 'entropy.png'
plot 'energydensity.dat' u 1:2 w p pt 7 lc 'black' t 'entire'


## entanglement spectrum
set xlabel 'i'
set ylabel 'spectrum {/Symbol x}_i'

set key right bottom

# entire
unset xrange
set output 'entanglementspectrum_entire.png'
plot 'maxdim_50/entanglementspectrum_infinite.dat' w p pt 7 t 'maxdim = 50',\
     'maxdim_100/entanglementspectrum_infinite.dat' w p pt 7 t 'maxdim = 100',\
     'maxdim_150/entanglementspectrum_infinite.dat' w p pt 7 t 'maxdim = 150',\
     'maxdim_200/entanglementspectrum_infinite.dat' w p pt 7 t 'maxdim = 200',\
     'maxdim_250/entanglementspectrum_infinite.dat' w p pt 7 t 'maxdim = 250',\
     'maxdim_300/entanglementspectrum_infinite.dat' w p pt 7 t 'maxdim = 300',\
     'maxdim_350/entanglementspectrum_infinite.dat' w p pt 7 t 'maxdim = 350',\
     'maxdim_400/entanglementspectrum_infinite.dat' w p pt 7 t 'maxdim = 400',\
     'maxdim_450/entanglementspectrum_infinite.dat' w p pt 9 t 'maxdim = 450'

# upto 40
set xrange [:40]

set output 'entanglementspectrum_upto40.png'
plot 'maxdim_50/entanglementspectrum_infinite.dat' w p pt 7 t 'maxdim = 50',\
     'maxdim_100/entanglementspectrum_infinite.dat' w p pt 7 t 'maxdim = 100',\
     'maxdim_150/entanglementspectrum_infinite.dat' w p pt 7 t 'maxdim = 150',\
     'maxdim_200/entanglementspectrum_infinite.dat' w p pt 7 t 'maxdim = 200',\
     'maxdim_250/entanglementspectrum_infinite.dat' w p pt 7 t 'maxdim = 250',\
     'maxdim_300/entanglementspectrum_infinite.dat' w p pt 7 t 'maxdim = 300',\
     'maxdim_350/entanglementspectrum_infinite.dat' w p pt 7 t 'maxdim = 350',\
     'maxdim_400/entanglementspectrum_infinite.dat' w p pt 7 t 'maxdim = 400',\
     'maxdim_450/entanglementspectrum_infinite.dat' w p pt 9 t 'maxdim = 450'



#    EOF
