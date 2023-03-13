#!/bin/sh
####################################################
# This is a sample script to run scf total-energy
# calculations on a unit cell of Al using 
# different values for the Monkhorst-Pack grid divisions
# an different values of smearing parameter degauss
#
#
# You should copy this file and modify it as 
# appropriate for the tutorial.
####################################################
# Notes:
#
# 1. You can loop over a variable by using the 
#    'for...do...done' construction. 
# 2. Variables can be referred to within the script 
#    by typing the variable name preceded by the '$' 
#    sign. 
#
####################################################
# Important initial variables for the code
# (change these as necessary)
####################################################

NAME='celldm'
DEG=0.02
NK=20


for CELLDM in 7.0 7.2 7.4 7.6 7.8 8.0; do
cat > Al.$NAME.$CELLDM.in << EOF
 &control
    calculation = 'scf',
    verbosity = 'high'
    prefix = 'Al_exc1'
    outdir = './tmp/'
    pseudo_dir = '../pseudo/'
 /
 &system
    ibrav =  2, 
    celldm(1) = $CELLDM,
    nat =  1, 
    ntyp = 1,
    ecutwfc = 12.0,
    occupations = 'smearing',
    smearing = 'marzari-vanderbilt',
    degauss = $DEG
 /
 &electrons
    mixing_beta = 0.7
 /

ATOMIC_SPECIES
 
Al 26.98  Al.pz-vbc.UPF

ATOMIC_POSITIONS (alat)
 Al 0.0 0.0 0.0

K_POINTS (automatic)
  $NK $NK $NK 1 1 1
EOF

pw.x < Al.$NAME.$CELLDM.in >  Al.$NAME.$CELLDM.out

done
