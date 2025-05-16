RTL_DIR		= ./rtl
TB_DIR 		= ./tb
BUILD_DIR 	= ./build 
DUT 		= $(RTL_DIR)/adder.v
TEST_BENCH 	=$(TB_DIR)/tb_adder.sv 
LOG 		= simv.log
COMP_OPT 	= -full64 -sverilog -ntb_opts uvm-1.2 \
			-debug_access+all -kdb \
			-timescale=1ns/100ps \
			-Mdir=$(BUILD_DIR)/csrc \
			-o $(BUILD_DIR)/simv \
			# -l $(BUILD_DIR)/comp.log 

SIMV 	  	= ./$(BUILD_DIR)/simv 
FSDB_FILE 	= $(BUILD_DIR)/wave.fsdb
TEST_NAME 	= test
SIMV_OPT  	= +UVM_TESTNAME=$(TEST_NAME) \
			-l ./$(BUILD_DIR)/simv.log \
			+fsdbfile+$(FSDB_FILE)

all: vcs simv

vcs:
	-mkdir build
	vcs $(COMP_OPT) $(DUT) $(TEST_BENCH)

simv:
	$(SIMV) $(SIMV_OPT)


verdi:
	verdi -dbdir $(BUILD_DIR)/simv.daidir -ssf $(FSDB_FILE)


clean:
	rm -rf build csrc *.h *.log *.key


.PHONY: all vcs simv 