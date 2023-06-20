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
CFLAGS 		:= -Wall -Wextra -Werror
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
build: all

.PHONY: re
re:
	$(MAKE) fclean
	$(MAKE) all

.PHONY: run
run: $(TARGET)
	$(info Starting $(TARGET))
	./$(TARGET)

.PHONY: clean
clean:
	$(info $(RM) $(OBJECTS))
	$(RM) $(OBJECTS)

.PHONY: fclean
fclean: clean
	$(info $(RM) $(TARGET))
	$(RM) $(TARGET)


.SILENT:

