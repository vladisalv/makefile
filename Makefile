# ============================================================================ #
# Version: 3.0                                                                 #
# Last update: 05.10.2014                                                      #
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
# ============================================================================ ##structure:
# name in config
# name in Makefile (redifinition config)
# name in Makefile.sqel (redifinition Makefile, template)
# goals




include $(wildcard config.mk)






ifndef INCLUDE_DIR
    INCLUDE_DIR := include
endif

SRC_DIR     := src
LIB_DIR     := 

LIBRARY = cublas cudart

OUTPUT_DIR
OUTPUT_FILE

INPUT_DIR
INPUT_FILE


# дополнительные параметры для запуска
ARGUMENTS   = --index-geometry $(INDEX_GEOMETRY) -x $(NUM_NODE_X) -y $(NUM_NODE_Y) -z $(NUM_NODE_Z)
ARGUMENTS  += --interval-print $(INTER_PRINT) --number-steps $(NUMBER_STEPS) --delta $(DELTA) --kappa $(KAPPA) --cfl $(CFL)
NODE        = 1
NUMBER_PROC = 8
QUEUE       = test
TIME        = 15:00




include $(wildcard Makefile.skel)




# ============== GOALS =========================================================

# абстрактные цели (выполняются в любом случае)
.PHONY: print clean all run

# главная цель (пустая команда make)

all: print

print:
	@echo "INCLUDE_DIR = $(INCLUDE_DIR)"

build:
	@echo Compiling program.....

# пересобрать
rebuild: clean build

# запуск
run:
	@echo "RUN PROGRAM"

# очистка от исполняемых данных
clean:
	@echo Cleaning...

# полная очистка. удаление исполняемых файлов и файлов результата
cleanAll: clean
	@echo Delete output file
	@rm -f DATA/*
	@rm -f $(OUTPUT_DIR)/*

# вывести опции программы
help:
	@$(BIN_NOW)/$(PROG_NAME) -h

# посмотреть свою очередь
watch:
	watch -n 1 squeue -u $(USER)

# отменить все поставленные задачи
cancel:
	scancel -u $(USER)
vim:
	@vim -s vim_file

test:
