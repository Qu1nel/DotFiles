# @author Qu1nel (Иван Ковач, "Ivan Kovach")
#######################################  LARGE  ##
#
# This Makefile-template is used for larger
# projects that use libraries with their own
# Makefile, as well as a '.build' directory and a
# directory for header files - 'include'.

#------------------------------------------------#
# 	VARIABLES                                    #
#------------------------------------------------#
# TARGET 		- Main purpose, static library,
# 			   		archive, make result
#
# LIBS 			- Libraries to be used
# LIBS_TARGET 	- Libraries to be built
#
# INCLD_NAME 	- Name for include folder
#
# SRC_DIR 		- Source directory
# INCLDS 	 	- All include folder find
# INCLD_DIRS 	- Include directories (correct format)
# BUILD_DIR 	- Build directory
#
# CC 			- Compiler
# CFLAGS 		- Compiler flags
# CPPFLAGS 		- Preprocessor flags
# LDFLAGS 		- Linker flags
# LDLIBS 		- Libraries name
#
# ALL_SRCS 		- All source code files find
# SOURCES 		- Source files (with SRC_DIR)
# OBJECTS 		- Object files
# DEPS 			- Dependency files
#
# RM 			- Force remove
# MAKEFLAGS 	- Make flags
# DIR_DUP 		- Duplicate directory tree


TARGET 		:= main

# NOTE: !!! > EDIT < !!!
LIBS 		:= one two m
LIBS_TARGET := lib/library1/libone.a lib/library2/libtwo.a
# NOTE: !!! ^ EDIT ^ !!!

INCLD_NAME 	:= include

SRC_DIR     := src
INCLDS 		:= $(shell find . -type d -name '$(INCLD_NAME)' 2>/dev/null)
INCLD_DIRS 	:= $(INCLDS:./%=%)
BUILD_DIR   := .build

ALL_SRCS  	:= $(shell find $(SRC_DIR) -type f -name '*.c' 2>/dev/null)
SOURCES		:= $(ALL_SRCS:$(SRC_DIR)/%=%)
OBJECTS     := $(SOURCES:%.c=$(BUILD_DIR)/%.o)
DEPS 		:= $(OBJECTS:.o=.d)

CC 			:= clang
# optimization: -O2 -Os -O3
CFLAGS 		:= -Wall -Wextra -Werror -O2
CPPFLAGS 	:= $(addprefix -I,$(INCLD_DIRS)) -MMD -MP
LDFLAGS 	:= $(addprefix -L,$(dir $(LIBS_TARGET)))
LDLIBS 		:= $(addprefix -l,$(LIBS))

RM          := rm -f
MAKEFLAGS 	+= --silent --no-print-directory
DIR_DUP     = mkdir -p $(@D)


#------------------------------------------------#
# 	RECIPES                                      #
#------------------------------------------------#
# all 		- Default goal
# $(TARGET) - Linking *.o -> archive
# $(LIBS) 	- Build libraries
# %.o 		- Compilation source files *.c -> *.o
# build 	- Rebuild archive
# re 		- Remake default goal
# run 		- Run program
# clean 	- Remove *.o and *.d
# fcrean 	- Remove *.o and *.d + binary
#
# info-% 	- Rule will execute a make % command
# 			   with --dry-run
# print-% 	- That works like print-<rule> will
# 			   print the value of an arbitrary variable


.PHONY: all
all: $(TARGET)

$(TARGET): $(OBJECTS) $(LIBS_TARGET)
	$(CC) $(LDFLAGS) $(OBJECTS) $(LDLIBS) -o $@
	$(info CREATED $@ $(CC) $(LDFLAGS) $(OBJECTS) $(LDLIBS) -o $@)

$(LIBS_TARGET):
	$(MAKE) -C $(@D)

$(BUILD_DIR)/%.o: $(SRC_DIR)/%.c
	$(DIR_DUP)
	$(CC) $(CFLAGS) $(CPPFLAGS) -c -o $@ $<
	$(info COMPILED $@ : $(CC) $(CFLAGS) $(CPPFLAGS) -c -o $@ $<)

-include $(DEPS)

.PHONY: build
build: $(TARGET)

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
	for f in $(dir $(LIBS_TARGET)); do $(MAKE) -C $$f clean; done
	$(info $(RM) $(OBJECTS) $(DEPS))
	$(RM) $(OBJECTS) $(DEPS)

.PHONY: fclean
fclean: clean
	for f in $(dir $(LIBS_TARGET)); do $(MAKE) -C $$f fclean; done
	$(info $(RM) $(TARGET))
	$(RM) $(TARGET)

info-%:
	@make --dry-run --always-make $* | grep -v "info"

print-%:
	@$(info '$*'='$($*)')


.SILENT:

