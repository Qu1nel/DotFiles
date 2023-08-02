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


LIBNAME 	:= SomeTwo
TARGET_NAME := lib$(LIBNAME).a

SRC_DIR     := src
INCLD_DIR 	:= include
BUILD_DIR   := .build
OBJ_DIR 	:= $(BUILD_DIR)/objects

TARGET 		:= $(BUILD_DIR)/$(TARGET_NAME)

OBJECTS     := $(patsubst %.c, $(OBJ_DIR)/%.o, $(patsubst $(SRC_DIR)/%, %, $(shell find $(SRC_DIR) -type f -name '*.c' 2>/dev/null)))
DEPS 		:= $(OBJECTS:.o=.d)

CC 			:= clang
CFLAGS 		:= -std=c17 -Wall -Wextra -Werror -Wshadow -Wvla -Walloca -Wundef -Wfloat-equal \
			   -Wstrict-prototypes -Wconversion -Wswitch-enum -Wswitch-default -Wimplicit-fallthrough \
			   -Wunreachable-code -Wformat=2 -Wparentheses -Wmisleading-indentation -Wpedantic -pedantic -O2

CPPFLAGS 	:= -I$(INCLD_DIR) -MMD -MP
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
all: build

$(TARGET): $(OBJECTS)
	$(AR) $(ARFLAGS) $(TARGET) $(OBJECTS)
	$(info [BUILD] $@ : $(AR) $(ARFLAGS) $(TARGET) $(OBJECTS))

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c
	$(DIR_DUP)
	$(CC) -c $< -o $@ $(CFLAGS) $(CPPFLAGS)
	$(info [COMPILED] $@ : $(CC) -c $< -o $@ $(CFLAGS) $(CPPFLAGS))

-include $(DEPS)

.PHONY: build
build: $(TARGET)  ## Build library
	$(shell ranlib $(TARGET))
	$(info [RABLIB] ralib $(TARGET))

.PHONY: re
re:  # Rebuild library
	$(MAKE) fclean
	$(MAKE) all

.PHONY: clean
clean:  ## Remove all object and dep files
	$(info $(RM) $(OBJECTS) $(DEPS))
	$(RM) $(OBJECTS) $(DEPS)

.PHONY: fclean
fclean: clean  ## Remove library + all object files + dep files
	$(info $(RM) $(TARGET))
	$(RM) $(TARGET)

.PHONY: help
help:  ## Show this output, i.e. help to use the commands
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' Makefile | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

info-%:
	@make --dry-run --always-make $* | grep -v "info"

print-%:
	@$(info '$*'='$($*)')


.SILENT:

