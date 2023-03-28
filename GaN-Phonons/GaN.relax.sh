#!/usr/bin/bash

module load QuantumESPRESSO/6.8-intel-2021a

NAME="nk"

echo $NAME
####################################################

out=output

CUTOFF=200

for NK in $(seq 10 5 100); do
cat > $out/${NAME}_${NK}.in << EOF
&CONTROL
    calculation = 'scf',
    verbosity = 'high',
    prefix = 'GaN_exc1',
    outdir = '../tmp/'
    pseudo_dir = '../pseudo/'
 /
&SYSTEM
    ibrav = 4,
    celldm(1) = 6.028226348,
    celldm(3) = 1.62696,
    nat = 4,
    ntyp = 2,
    ecutwfc = ${CUTOFF},
/
&ELECTRONS
    mixing_beta = 0.7
/
&IONS
/
&CELL
/
ATOMIC_SPECIES
 Ga 69.723  Ga_ONCV_PBE_sr.upf
 N  14.007  N_ONCV_PBE_sr.upf

ATOMIC_POSITIONS crystal
   Ga 0.6666666666666666    0.3333333333333333    0.4990837100000000
   Ga 0.3333333333333333    0.6666666666666666    0.9990837100000001
   N  0.6666666666666666    0.3333333333333333    0.8759162900000000
   N  0.3333333333333333    0.6666666666666666    0.3759162900000002

K_POINTS automatic
    ${NK} ${NK} ${NK} 0 0 0
EOF


cat > $out/${NAME}_${NK}.slrm << EOF
#!/bin/bash
#SBATCH --partition=batch
#SBATCH --job-name=MAH
#SBATCH --cpus-per-task=1
#SBATCH --mem=50gb
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=6
#SBATCH --output=%x-%j.out
#SBATCH --error=%x-%j.err

module load QuantumESPRESSO/6.8-intel-2021a

srun pw.x < $out/${NAME}_${NK}.in > $out/${NAME}_${NK}.out
EOF

sbatch "$out/${NAME}_${NK}.slrm"

sleep 1

done
