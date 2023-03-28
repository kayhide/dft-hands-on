#!/usr/bin/bash

module load QuantumESPRESSO/6.8-intel-2021a

out=output/force
mkdir -p "$out"


slrm="$out/run.slrm"
cat <<EOF > "$slrm"
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

EOF

find -name "GaN-*.in" | sort -V | while read -r f; do
    dst="$out/$(basename ${f/.in/.out})"
    echo "srun pw.x < "$f" > "$dst"" >> "$slrm"
done

echo "create: $slrm"
sbatch "$slrm"
