INCLUDE_DIR := include
SRC_DIR     := src
LIB_DIR     := 
CODE_DIR    := $(INCLUDE_DIR) $(SRC_DIR)

LIBRARY = cublas cudart

include $(wildcard config.mk)
include $(wildcard Makefile.skel)

all: print

print:
	@echo "BIN_TARGET = $(BIN_TARGET)"
	@echo "OBJ_TARGET = $(OBJ_TARGET)"
	@echo "BIN_NOW = $(BIN_NOW)"
	@echo "OBJ_NOW = $(OBJ_NOW)"
