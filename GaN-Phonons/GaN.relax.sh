#!/usr/bin/bash

module load QuantumESPRESSO/6.8-intel-2021a

NAME="GaN.relax"
echo $NAME

out=output/relax
mkdir -p "$out"

cat > $out/${NAME}.slrm << EOF
#!/bin/bash
#SBATCH --partition=batch
#SBATCH --job-name=mah
#SBATCH --cpus-per-task=1
#SBATCH --mem=50gb
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=6
#SBATCH --output=%x-%j.out
#SBATCH --error=%x-%j.err

module load QuantumESPRESSO/6.8-intel-2021a

srun pw.x < ${NAME}.in > $out/${NAME}.out
EOF

sbatch "$out/${NAME}.slrm"
