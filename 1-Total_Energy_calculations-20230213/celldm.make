SRCS := $(shell seq 98 2 110 | xargs printf "${OUTPUT_DIR}/${NAME}-%03d.in\n")
DSTS := $(SRCS:.in=.out)
ENERGY_DATA := $(OUTPUT_DIR)/$(NAME)-energy.data
TIME_DATA := $(OUTPUT_DIR)/$(NAME)-time.data

.PRECIOUS: %.in
%.in:
	CELLDM=$(shell echo $@ | sed "s/.*-\([0-9]*\)\([0-9]\).*/\1.\2/" | bc) bin/build-input > "$@"

$(ENERGY_DATA): $(DSTS)
	find $(DSTS) | bin/build-data total-energy 0.1 > "$@"

$(TIME_DATA): $(DSTS)
	find $(DSTS) | bin/build-data cpu-time 0.1 > "$@"
