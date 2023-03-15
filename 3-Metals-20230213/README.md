
`Al.sample.sh`
runs simulation for the combination of several `nk` and `degauss`.


`bin/plot`
consumes the outputs of `Al.sample.sh` and plots them.
From this plots, we are supposed to pick appropriate values for `nk` and `degauss`.

`Al.celldm.sh`
runs simulations for various `celldm`.

`bin/plot-celldm`
consumes the outputs of `Al.celldm.sh` and plots total energy for each celldm.
It also outputs `celldm-energy.data`.

After running this you can run `ev.x` to fit and find the minimum.

`ev.out`

contains the estimation of equilibrium lattice constant of Al.
