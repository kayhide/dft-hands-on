https://aritz.bcb.eus/calmodulin/#batch-scripts

```console
> ssh -X ...
```

`-X` Enabels X11 forwarding.

Set "TERM=xterm" if said "WARNING: terminal is not fully functional" on the following commands.

### List available modules

```console
> module av
```

### Load a module

```console
> module load QuantumESPRESSO/6.8-intel-2021a
```

### List tasks

```console
> squeue
```

### Direction

`*.slrm`
```sh
#!/bin/bash
#SBATCH --partition=batch
#SBATCH --job-name=JOB_NAME
#SBATCH --cpus-per-task=1
#SBATCH --mem=200gb
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=24
#SBATCH --output=%x-%j.out
#SBATCH --error=%x-%j.err

module load <program>/<program_version>

srun pw.x < xxx.in > xxx.out
```


- `--partition` don't touch
- `--job_name` give something, ex) `si_scf`, `si_at1`,...
- `--cpus-per-task` 1?
- `--mem`  50gb?
- `--nodes` 1, dont touch
- `--ntasks-per-node`6?
- `--output`%x-%j.out
- `--error`%x-%j.err

### Submit a task

```console
> sbatch si.slrm
```

### Cancel a task

```console
> scancel <JOBID>
```
