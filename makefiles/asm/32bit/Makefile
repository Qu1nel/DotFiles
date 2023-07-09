# @author Qu1nel (Иван Ковач, "Ivan Kovach")
###################################  ASM 32bit  ##
#
# This Makefile-template is used for small
# 32-bit assembly language projects

#------------------------------------------------#
# 	VARIABLES                                    #
#------------------------------------------------#
# TARGET 	- Main purpose, executable file,
# 			   binary, make result
#
# BLD_DIR 	- Build directory
#
# CC 		- Compiler
# CFLAGS 	- Compiler flags
# CPPFLAGS 	- Preprocessor flags
# LFLAGS 	- Linker flags
#
# SOURCES 	- Source files
# OBJECTS 	- Object files
#
# RM 		- Force remove
# MAKEFLAGS - Make flags
# DIR_DUP 	- Duplicate directory tree


TARGET 		:= main

BLD_DIR     := .build

CC 			:= nasm
CPPFLAGS 	:= 
CFLAGS 		:= -f elf32
LFLAGS 		:= -m elf_i386

SOURCES 	:= $(wildcard *.asm)
OBJECTS     := $(SOURCES:%.asm=$(BLD_DIR)/%.o)

RM 			:= rm -rf
MAKEFLAGS 	+= --no-print-directory
DIR_DUP 	= mkdir -p ${@D}


#------------------------------------------------#
# 	RECIPES                                      #
#------------------------------------------------#
# all 		- Default goal
# $(TARGET) - Linking *.o -> binary
# %.o 		- Compilation source files *.asm -> *.o
# build 	- Rebuild binary
# re 		- Remake default goal
# run 		- Run binary file
# clean 	- Remove *.o
# fcrean 	- Remove *.o + binary
#
# help 		- Show help about commands
# info-% 	- Rule will execute a make % command
# 			   with --dry-run
# print-% 	- That works like print-<rule> will
# 			   print the value of an arbitrary variable


.PHONY: all
all: $(TARGET)

$(TARGET): $(OBJECTS) 
	ld $(LFLAGS) $(OBJECTS) -o $@

$(OBJECTS): $(SOURCES)
	$(DIR_DUP)
	$(CC) $(CFLAGS) -o $@ $<

.PHONY: build
build: all  ## Compile project

.PHONY: re
re:  ## Recompile project
	$(MAKE) fclean
	$(MAKE) all

.PHONY: run
run:  ## Run executable file
	./$(TARGET)

.PHONY: clean
clean:  ## Remove all object files
	$(RM) $(OBJECTS)

.PHONY: fclean
fclean: clean  ## Remove executable file
	$(RM) $(TARGET)

.DEFAULT_GOAL := help
.PHONY: help
help:  ## Show this output, i.e. help to use the commands
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

info-%:
	@make --dry-run --always-make $* | grep -v "info"

print-%:
	@$(info '$*'='$($*)')

