# @author Qu1nel (Иван Ковач, "Ivan Kovach")
########################################  SMALL  ##
#
# This Makefile-template is used for small
# projects that do not have a source code folder
# and all files are located with the Makefile.

#------------------------------------------------#
# 	VARIABLES                                    #
#------------------------------------------------#
# TARGET 	- Main purpose, executable file,
# 			   binary, make result
# 
# CC 		- Compiler
# CFLAGS 	- Compiler flags
# CPPFLAGS 	- Preprocessor flags
# LDFLAGS 	- Linker flags
# 
# SOURCES 	- Source files
# OBJECTS 	- Object files
#
# RM 		- Force remove
# MAKEFLAGS - Make flags


TARGET 		:= main

CC 			:= clang
CFLAGS 		:= -Wall -Wextra -Werror
CPPFLAGS 	:= -I .
LDFLAGS 	:= 

SOURCES 	:= $(shell find . -type f -name '*.c' 2>/dev/null)
OBJECTS 	:= $(SOURCES:.c=.o)

RM 			:= rm -rf
MAKEFLAGS 	+= --no-print-directory


#------------------------------------------------#
# 	RECIPES                                      #
#------------------------------------------------#
# all 		- Default goal
# $(TARGET) - Linking *.o -> binary
# .c.o 		- Compilation source files *.c -> *.o
# build 	- Rebuild binary
# re 		- Remake default goal
# run 		- Run binary file
# clean 	- Remove *.o
# fcrean 	- Remove *.o + binary


.PHONY: all
all: $(TARGET)

$(TARGET): $(OBJECTS)
	$(CC) $(LDFLAGS) $(OBJECTS) -o $(TARGET)

.c.o:
	$(CC) $(CFLAGS) $(CPPFLAGS) -c -o $@ $<

.PHONY: build
build: all

.PHONY: re
re:
	$(MAKE) fclean
	$(MAKE) all

.PHONY: run
run:
	./$(TARGET)

.PHONY: clean
clean:
	$(RM) $(OBJECTS)

.PHONY: fclean
fclean: clean
	$(RM) $(TARGET)

