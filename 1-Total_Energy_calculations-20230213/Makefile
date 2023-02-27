NAME := celldm
OUTPUT_DIR := output
SRCS := $(shell seq 98 2 110 | xargs printf "${OUTPUT_DIR}/${NAME}-%03d.in\n")
DSTS := $(SRCS:.in=.out)


.PRECIOUS: %.in
%.in:
	CELLDM=$(shell echo $@ | sed "s/.*-\([0-9]*\)\([0-9]\).*/\1.\2/" | bc) bin/build-input > "$@"

%.out: %.in
	pw.x < "$<" > "$@"

$(NAME)-energy.data: $(DSTS)
	find $(DSTS) | bin/build-data total-energy 0.1 > "$@"

$(NAME)-time.data: $(DSTS)
	find $(DSTS) | bin/build-data cpu-time 0.1 > "$@"

.PHONY: energy
energy: $(NAME)-energy.data

.PHONY: time
time: $(NAME)-time.data

.PHONY: all
all: $(DSTS)
all: $(NAME)-energy.data
all: $(NAME)-time.data

.PHONY: clean
clean:
	rm -rf $(SRCS)
	rm -rf $(DSTS)
	rm -rf $(NAME)-energy.data
	rm -rf $(NAME)-time.data
