# @author Qu1nel (Иван Ковач, "Ivan Kovach")
######################################  MEDIUM  ##
#
# This Makefile-template is used for medium
# projects which have a source code folder and
# also assume a "obj" folder which will include
# object files and folder "include" which will
# include header files.

#------------------------------------------------#
# 	VARIABLES                                    #
#------------------------------------------------#
# TARGET 	- Main purpose, executable file,
# 			   binary, make result
#
# SRC_DIR 	- Source directory
# INCLD_DIR - Include directory
# OBJ_DIR 	- Object directory
#
# CC 		- Compiler
# CFLAGS 	- Compiler flags
# CPPFLAGS 	- Preprocessor flags
# LDFLAGS 	- Linker flags
#
# ALL_SRCS 	- All source code files find
# SOURCES 	- Source files (with SRC_DIR)
# OBJECTS 	- Object files
#
# RM 		- Force remove
# MAKEFLAGS - Make flags
# DIR_DUP 	- Duplicate directory tree


TARGET 		:= main

SRC_DIR     := src
INCLD_DIR 	:= include
OBJ_DIR     := obj

CC 			:= clang
# optimization: -O2 -Os -O3
# testing: -Werror -Wshadow
# pedantic mode: -Wpedantic -predantic
CFLAGS 		:= -Wall -Wextra -Wpedantic -pedantic -O2
CPPFLAGS 	:= -I $(INCLD_DIR)
LDFLAGS 	:=

ALL_SRCS  	:= $(shell find $(SRC_DIR) -type f -name '*.c' 2>/dev/null)
SOURCES		:= $(ALL_SRCS:$(SRC_DIR)/%=%)
OBJECTS     := $(SOURCES:%.c=$(OBJ_DIR)/%.o)

RM          := rm -f
MAKEFLAGS 	+= --no-print-directory
DIR_DUP     = mkdir -p $(@D)


#------------------------------------------------#
# 	RECIPES                                      #
#------------------------------------------------#
# all 		- Default goal
# $(TARGET) - Linking *.o -> binary
# %.o 		- Compilation source files *.c -> *.o
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
	$(CC) $(LDFLAGS) $(OBJECTS) -o $(TARGET)
	$(info LINKED $@ : $(CC) $(LDFLAGS) $(OBJECTS) -o $(TARGET))

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c
	$(DIR_DUP)
	$(CC) $(CFLAGS) $(CPPFLAGS) -c -o $@ $<
	$(info COMPILED $@ : $(CC) $(CFLAGS) $(CPPFLAGS) -c -o $@ $<)

.PHONY: build
build: all  ## Compile project

.PHONY: re
re:  ## Recompile project
	$(MAKE) fclean
	$(MAKE) all

.PHONY: run
run: $(TARGET)  ## Run executable file
	$(info Starting $(TARGET))
	./$(TARGET)

.PHONY: clean
clean:  ## Remove all object files
	$(info $(RM) $(OBJECTS))
	$(RM) $(OBJECTS)

.PHONY: fclean
fclean: clean  ## Remove main executable file
	$(info $(RM) $(TARGET))
	$(RM) $(TARGET)

.DEFAULT_GOAL := help
.PHONY: help
help:  ## Show this output, i.e. help to use the commands
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

info-%:
	@make --dry-run --always-make $* | grep -v "info"

print-%:
	@$(info '$*'='$($*)')


.SILENT:

