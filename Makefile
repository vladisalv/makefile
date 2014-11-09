# ============================================================================ #
# Version: 3.0                                                                 #
# Last update: 12.10.2014                                                      #
#                                                                              #
#                                                                              #
# !!!!!!!!!!!!!!!!!!!!!!! ВАЖНО !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! #
#                                                                              #
#   При первом запуске выйдет ОШИБКА при линковке в окончательный модуль!      #
#   Это особенность данной версии Makefile. просто соберите проект еще раз!    #
#                                                                              #
# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! #
#                                                                              #
#  если интересно в чем ошибка:                                                #
# дело в том, что откомпилированные объектные файлы сохраняются не корневой    #
# каталог, а в папку obj, но утилита make (видимо ее особенность) запоминает   #
# отсутствие файлов в корневом каталоге и потом ищет их только там (хотя опция #
# vpath %.o $(OBJ_NOW) стоит задолго до этого). В будущем исправлю             #
#                                                                              #
# Что нужно будет сделать:                                                     #
# 1. Исправить ошибку первого прохода                                          #
# ============================================================================ #

# structure:
# name in config
# name in Makefile (redifinition config)
# name in Makefile.sqel (redifinition Makefile, template)
# goals

# ====================  INCLUDE CONFIG FILE  ===================================

include $(wildcard config.mk)

# ========================  REDEFINE NAME  =====================================
PROGRAM_NAME ?= "PROGRAM"
VERSION_NUMBER ?= "UNKNOW"
# ----------------------  INPUT/OUTPUT FILES  ----------------------------------
INPUT_DIR   ?= input
INPUT_FILE  ?= input_$(DATE)
OUTPUT_DIR  ?= output
OUTPUT_FILE ?= output_$(DATE)
# ----------------------  LAUNCH OPTIONS  --------------------------------------
ARGUMENTS ?= -h
MACHINE ?= host
NODE ?=
NUMBER_PROC ?= 1
QUEUE ?=
TIME ?=
# ========================  DEFINE NAME  =======================================
BIN_NAME ?= $(PROGRAM_NAME)

TARGET ?= debug release
TARGET_NOW ?= debug
# -----------------------  CODE DIRECTORY  -------------------------------------
INCLUDE_DIR ?= include
SRC_DIR ?= src
LIB_DIR ?=
LIBRARY ?=
# ----------------------------  FLAGS  -----------------------------------------

# FLAGS := $(FLAGSCOMMON) $(FLAGSGOAL) $(FLAGSINCLUDES) $(FLAGLIBS) 

# ====================  INCLUDE SKELETON FILE  =================================

include $(wildcard Makefile.skel)

# =============================  GOALS  ========================================

# абстрактные цели (выполняются в любом случае)
.PHONY: all run clean clean_exec clean_result

# главная цель (пустая команда make)
all: build

build: $(OBJ_MODULES)
	@echo Compiling program.....
	@$(CC) $(CFLAGS) $^ -o $(BIN_NOW)/$(BINARY_NAME) # $(CFLAGSLIB) в конце

# запуск
run:
	@echo "RUN PROGRAM"

rebuild: clean_exec build

clean: clean_exec clean_result

clean_exec:
	@echo Cleaning...

clean_result:
	@echo Cleaning...

# вывести опции программы
option:
	@$(BIN_NOW)/$(BINARY_NAME) -h

# посмотреть свою очередь
watch:
	watch -n 1 squeue -u $(USER)

# отменить все поставленные задачи
cancel:
	scancel -u $(USER)

test:

begin:

finish:
