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
# optimization: -O2 -Os -O3
# testing: -Werror -Wshadow
# pedantic mode: -Wpedantic -predantic
CFLAGS 		:= -Wall -Wextra -Wpedantic -pedantic -O2
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

.c.o:
	$(CC) $(CFLAGS) $(CPPFLAGS) -c -o $@ $<

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
fclean: clean  ## Remove main executable file
	$(RM) $(TARGET)

.DEFAULT_GOAL := help
.PHONY: help
help:  ## Show this output, i.e. help to use the commands
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

info-%:
	@make --dry-run --always-make $* | grep -v "info"

print-%:
	@$(info '$*'='$($*)')

