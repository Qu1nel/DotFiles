# @author Qu1nel (Иван Ковач, "Ivan Kovach")
##############################  Static Library  ##
#
# This Makefile template is used for static
# library projects .a for C, including the
# '.build' folder and 'include' folder for keep
# header files.

#------------------------------------------------#
# 	VARIABLES                                    #
#------------------------------------------------#
# TARGET 	- Main purpose, static library,
# 			   archive, make result
#
# SRC_DIR 	- Source directory
# INCLD_DIR - Include directory
# BUILD_DIR - Build directory
#
# CC 		- Compiler
# CFLAGS 	- Compiler flags
# CPPFLAGS 	- Preprocessor flags
# LDFLAGS 	- Linker flags
# AR 		- Object file archiver
# ARFLAGS 	- Archiver flags
#
# ALL_SRCS 	- All source code files find
# SOURCES 	- Source files (with SRC_DIR)
# OBJECTS 	- Object files
# DEPS 		- Dependency files
#
# RM 		- Force remove
# MAKEFLAGS - Make flags
# DIR_DUP 	- Duplicate directory tree


TARGET 		:= libone.a

SRC_DIR     := src
INCLD_DIR 	:= include
BUILD_DIR   := .build

ALL_SRCS  	:= $(shell find $(SRC_DIR) -type f -name '*.c' 2>/dev/null)
SOURCES		:= $(ALL_SRCS:$(SRC_DIR)/%=%)
OBJECTS     := $(SOURCES:%.c=$(BUILD_DIR)/%.o)
DEPS 		:= $(OBJECTS:.o=.d)

CC 			:= clang
# optimization: -O2 -Os -O3
# testing: -Werror -Wshadow
# pedantic mode: -Wpedantic -predantic
CFLAGS 		:= -Wall -Wextra -Wpedantic -pedantic -O2
CPPFLAGS 	:= -MMD -MP -I $(INCLD_DIR)
LDFLAGS 	:=
AR 			:= ar
ARFLAGS 	:= -r -c -s

RM          := rm -f
MAKEFLAGS 	+= --no-print-directory
DIR_DUP     = mkdir -p $(@D)


#------------------------------------------------#
# 	RECIPES                                      #
#------------------------------------------------#
# all 		- Default goal
# $(TARGET) - Linking *.o -> library
# %.o 		- Compilation source files *.c -> *.o
# build 	- Rebuild library
# re 		- Remake default goal
# clean 	- Remove *.o and *.d
# fcrean 	- Remove *.o and *.d + library
#
# info-% 	- Rule will execute a make % command
# 			   with --dry-run
# print-% 	- That works like print-<rule> will
# 			   print the value of an arbitrary variable


.PHONY: all
all: $(TARGET)

$(TARGET): $(OBJECTS)
	$(AR) $(ARFLAGS) $(TARGET) $(OBJECTS)
	$(shell ranlib $(TARGET))
	$(info CREATED $@ : $(AR) $(ARFLAGS) $(TARGET) $(OBJECTS))

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

.PHONY: clean
clean:
	$(info $(RM) $(OBJECTS) $(DEPS))
	$(RM) $(OBJECTS) $(DEPS)

.PHONY: fclean
fclean: clean
	$(info $(RM) $(TARGET))
	$(RM) $(TARGET)

info-%:
	@make --dry-run --always-make $* | grep -v "info"

print-%:
	@$(info '$*'='$($*)')


.SILENT:

