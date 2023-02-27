SRCS := $(shell seq 10 5 30 | xargs printf "${OUTPUT_DIR}/${NAME}-%03d.in\n")
DSTS := $(SRCS:.in=.out)
ENERGY_DATA := $(OUTPUT_DIR)/$(NAME)-energy.data
TIME_DATA := $(OUTPUT_DIR)/$(NAME)-time.data

.PRECIOUS: %.in
%.in:
	CUTOFF=$(shell echo $@ | sed "s/.*-\([0-9]*\).*/\1/" | bc) bin/build-input > "$@"

$(ENERGY_DATA): $(DSTS)
	find $(DSTS) | bin/build-data total-energy > "$@"

$(TIME_DATA): $(DSTS)
	find $(DSTS) | bin/build-data cpu-time > "$@"
