OUTPUT_DIR := output

include $(NAME).make

%.out: %.in
	pw.x < "$<" > "$@"

.PHONY: energy
energy: $(ENERGY_DATA)

.PHONY: time
time: $(TIME_DATA)

.PHONY: all
all: $(DSTS) $(ENERGY_DATA) $(TIME_DATA)

.PHONY: clean
clean:
	rm -rf $(SRCS)
	rm -rf $(DSTS)
	rm -rf $(ENERGY_DATA)
	rm -rf $(TIME_DATA)
