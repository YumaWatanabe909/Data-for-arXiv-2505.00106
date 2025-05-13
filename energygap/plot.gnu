

###
#  NEUTRAL ENERGY GAP
###

# setting
set term png font 'Times,18'
set xlabel '1/L'
set xrange [0:0.030]
set xtics 0,0.01,0.03
set mxtics 5

set yrange [0.0:0.12]
set ytics 0.0,0.05,0.10
set mytics 5

set key left top

# neutral energy gap
# fitting
f_hi_obc_En(x)  = a_hi_obc_En * x + b_hi_obc_En
f_hsf_obc_En(x) = a_hsf_obc_En * x + b_hsf_obc_En
f_sf_obc_En(x)  = a_sf_obc_En * x + b_sf_obc_En
f_hi_bias_En(x)  = a_hi_bias_En * x + b_hi_bias_En
f_hsf_bias_En(x) = a_hsf_bias_En * x + b_hsf_bias_En
f_sf_bias_En(x)  = a_sf_bias_En * x + b_sf_bias_En

fit f_hi_obc_En(x) 'data/hi_obc.txt' u (1.0/($1)):2 via a_hi_obc_En, b_hi_obc_En
fit f_hsf_obc_En(x) 'data/hsf_obc.txt' u (1.0/($1)):2 via a_hsf_obc_En, b_hsf_obc_En
fit f_sf_obc_En(x) 'data/sf_obc.txt' u (1.0/($1)):2 via a_sf_obc_En, b_sf_obc_En
fit f_hi_bias_En(x) 'data/hi_bias.txt' u (1.0/($1)):2 via a_hi_bias_En, b_hi_bias_En
fit f_hsf_bias_En(x) 'data/hsf_bias.txt' u (1.0/($1)):2 via a_hsf_bias_En, b_hsf_bias_En
fit f_sf_bias_En(x) 'data/sf_bias.txt' u (1.0/($1)):2 via a_sf_bias_En, b_sf_bias_En


# obc fitting
set output 'obcEn_fitting.png'
plot 'data/hi_obc.txt' u (1.0/($1)):2 w p pt 9 ps 1.5 lc 'dark-grey' t 'HI',\
     'data/hsf_obc.txt' u (1.0/($1)):2 w p pt 7 ps 1.4 lc 'red' t 'HSF',\
     'data/sf_obc.txt' u (1.0/($1)):2 w p pt 5 ps 1.4 lc 'blue' t 'SF',\
     f_hi_obc_En(x) w l lw 2 lc 'dark-grey' t '',\
     f_hsf_obc_En(x) w l lw 2 lc 'red' t '',\
     f_sf_obc_En(x) w l lw 2 lc 'blue' t ''


# bias fitting
set output 'biasEn_fitting.png'
plot 'data/hi_bias.txt' u (1.0/($1)):2 w p pt 9 ps 1.5 lc 'dark-grey' t 'HI',\
     'data/hsf_bias.txt' u (1.0/($1)):2 w p pt 7 ps 1.4 lc 'red' t 'HSF',\
     'data/sf_bias.txt' u (1.0/($1)):2 w p pt 5 ps 1.4 lc 'blue' t 'SF',\
     f_hi_bias_En(x) w l lw 2 lc 'dark-grey' t '',\
     f_hsf_bias_En(x) w l lw 2 lc 'red' t '',\
     f_sf_bias_En(x) w l lw 2 lc 'blue' t ''
     


###
#  CHARGE ENERGY GAP
###

# fitting
f_hi_obc_Ec(x)  = a_hi_obc_Ec * x + b_hi_obc_Ec
f_hsf_obc_Ec(x) = a_hsf_obc_Ec * x + b_hsf_obc_Ec
f_sf_obc_Ec(x)  = a_sf_obc_Ec * x + b_sf_obc_Ec
f_hi_bias_Ec(x)  = a_hi_bias_Ec * x + b_hi_bias_Ec
f_hsf_bias_Ec(x) = a_hsf_bias_Ec * x + b_hsf_bias_Ec
f_sf_bias_Ec(x)  = a_sf_bias_Ec * x + b_sf_bias_Ec

fit f_hi_obc_Ec(x) 'data/hi_obc.txt' u (1.0/($1)):3 via a_hi_obc_Ec, b_hi_obc_Ec
fit f_hsf_obc_Ec(x) 'data/hsf_obc.txt' u (1.0/($1)):3 via a_hsf_obc_Ec, b_hsf_obc_Ec
fit f_sf_obc_Ec(x) 'data/sf_obc.txt' u (1.0/($1)):3 via a_sf_obc_Ec, b_sf_obc_Ec
fit f_hi_bias_Ec(x) 'data/hi_bias.txt' u (1.0/($1)):3 via a_hi_bias_Ec, b_hi_bias_Ec
fit f_hsf_bias_Ec(x) 'data/hsf_bias.txt' u (1.0/($1)):3 via a_hsf_bias_Ec, b_hsf_bias_Ec
fit f_sf_bias_Ec(x) 'data/sf_bias.txt' u (1.0/($1)):3 via a_sf_bias_Ec, b_sf_bias_Ec


# obc fitting
set output 'obcEc_fitting.png'
plot 'data/hi_obc.txt' u (1.0/($1)):3 w p pt 9 ps 1.5 lc 'dark-grey' t 'HI',\
     'data/hsf_obc.txt' u (1.0/($1)):3 w p pt 7 ps 1.4 lc 'red' t 'HSF',\
     'data/sf_obc.txt' u (1.0/($1)):3 w p pt 5 ps 1.4 lc 'blue' t 'SF',\
     f_hi_obc_Ec(x) w l lw 2 lc 'dark-grey' t '',\
     f_hsf_obc_Ec(x) w l lw 2 lc 'red' t '',\
     f_sf_obc_Ec(x) w l lw 2 lc 'blue' t ''

# bias fitting
set output 'biasEc_fitting.png'
plot 'data/hi_bias.txt' u (1.0/($1)):3 w p pt 9 ps 1.5 lc 'dark-grey' t 'HI',\
     'data/hsf_bias.txt' u (1.0/($1)):3 w p pt 7 ps 1.4 lc 'red' t 'HSF',\
     'data/sf_bias.txt' u (1.0/($1)):3 w p pt 5 ps 1.4 lc 'blue' t 'SF',\
     f_hi_bias_Ec(x) w l lw 2 lc 'dark-grey' t '',\
     f_hsf_bias_Ec(x) w l lw 2 lc 'red' t '',\
     f_sf_bias_Ec(x) w l lw 2 lc 'blue' t ''
     


#    EOF
