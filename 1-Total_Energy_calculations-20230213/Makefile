# Usage:
#   Give NAME and run `make all`.
#   NAME can be one of `*.make` file existing in this directory.
#   The following is an example to build everything for `ecut` variations.
#     NAME=ecut make all

OUTPUT_DIR := output

include $(NAME).make
ENERGY_PLOT := $(ENERGY_DATA:.data=.svg)
TIME_PLOT := $(TIME_DATA:.data=.svg)

%.out: %.in
	pw.x < "$<" > "$@"

%.svg: %.data
	gnuplot -e "set terminal svg size 640,480 background rgb 'white'; set output '$@'; plot '$<' w l"

.PHONY: all
all: $(DSTS) $(ENERGY_DATA) $(ENERGY_PLOT) $(TIME_DATA) $(TIME_PLOT)

.PHONY: clean
clean:
	rm -rf $(SRCS)
	rm -rf $(DSTS)
	rm -rf $(ENERGY_DATA)
	rm -rf $(TIME_DATA)
	rm -rf $(ENERGY_PLOT)
	rm -rf $(TIME_PLOT)
