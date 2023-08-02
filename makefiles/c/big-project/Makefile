# @author Qu1nel (Иван Ковач, "Ivan Kovach") 2023
###################################################################  LARGE  ##
##
## 	This Makefile-template is used for larger projects that use libraries with
## 	their own Makefile, as well as a '.build' directory and a directory for
## 	header files - 'include'.
##
####################################################################  DESC  ##

#----------------------------------------------------------------------------#
# 	VARIABLES                                                                #
#----------------------------------------------------------------------------#
# TARGET_NAME 	- Name for final result of make                              #
#                                                                            #
# LIBS 			- Own libraries to be used                                   #
# EXTERN_LIBS 	- Extern libraries from system (math etc.)                   #
#                                                                            #
# LDIR_NAME 	- Name of directory with dependent libraries                 #
# LBUILD_DIR 	- Directory which include release library                    #
# LIBS_TARGET 	- Paths to 'lib.a'                                           #
# LIBS_DIRS 	- Paths to purposeful directory of library                   #
#                                                                            #
# IDIR_NAME 	- Name for 'include' folder                                  #
#                                                                            #
# SRC_DIR 		- Name for source directory                                  #
# BUILD_DIR 	- Name for build directory                                   #
#                                                                            #
# INCLDS 	 	- All include folder find                                    #
# OBJ_DIR 		- Name for object files in build directory                   #
# EXEC_DIR 		- Name folder for executable target                          #
#                                                                            #
# TARGET 		- Main target in EXEC_DIR                                    #
#                                                                            #
# OBJECTS 		- Object files                                               #
# DEPS 			- Dependency files                                           #
#                                                                            #
# CC 			- Compiler                                                   #
# CFLAGS 		- Compiler flags                                             #
# CPPFLAGS 		- Preprocessor flags                                         #
# LDFLAGS 		- Linker flags                                               #
# LDLIBS 		- Libraries name                                             #
#                                                                            #
# RM 			- Force remove                                               #
# MAKEFLAGS 	- Make flags                                                 #
# DIR_DUP 		- Duplicate directory tree                                   #
#----------------------------------------------------------------------------#


TARGET_NAME	:= main

LIBS 		:= SomeOne SomeTwo
EXTERN_LIBS := m

LDIR_NAME 	:= lib
LBUILD_DIR 	:= .build
LIBS_TARGET := $(foreach l, $(LIBS), $(LDIR_NAME)/$(l)/$(LBUILD_DIR)/lib$(l).a)
LIBS_DIRS 	:= $(dir $(LIBS_TARGET))

IDIR_NAME 	:= include

SRC_DIR     := src
BUILD_DIR   := .build

INCLDS 		:= $(patsubst ./%, %, $(shell find . -type d -name '$(IDIR_NAME)' 2>/dev/null))
OBJ_DIR 	:= $(BUILD_DIR)/objects
EXEC_DIR 	:= $(BUILD_DIR)/release

TARGET 		:= $(EXEC_DIR)/$(TARGET_NAME)

OBJECTS     := $(patsubst %.c, $(OBJ_DIR)/%.o, $(patsubst $(SRC_DIR)/%, %, $(shell find $(SRC_DIR) -type f -name '*.c' 2>/dev/null)))
DEPS 		:= $(OBJECTS:.o=.d)

CC 			:= clang
CFLAGS 		:= -std=c17 -Wall -Wextra -Werror -Wshadow -Wvla -Walloca -Wundef -Wfloat-equal \
			   -Wstrict-prototypes -Wconversion -Wswitch-enum -Wswitch-default -Wimplicit-fallthrough \
			   -Wunreachable-code -Wformat=2 -Wparentheses -Wmisleading-indentation -Wpedantic -pedantic -O2

CPPFLAGS 	:= $(addprefix -I,$(INCLDS)) -MMD -MP
LDFLAGS 	:= $(addprefix -L,$(dir $(LIBS_TARGET)))
LDLIBS 		:= $(addprefix -l,$(LIBS)) $(addprefix -l,$(EXTERN_LIBS))

RM          := rm -f
MAKEFLAGS 	+= --silent --no-print-directory
DIR_DUP     = mkdir -p $(@D)


#--------------------------------------------------------------------------------------------------#
# 	RECIPES                                                                                        #
#--------------------------------------------------------------------------------------------------#
# all 				- Alias for build                                                              #
# $(TARGET) 		- Linking *.o + *.a -> executable file                                         #
# $(LIBS_TARGET) 	- Build libraries                                                              #
# %.o 		- Compilation source files *.c -> *.o                                                  #
# build 	- Build this project                                                                   #
# re 		- Rebuild this project                                                                 #
# clean 	- Remove all *.o and *.d                                                               #
# fcrean 	- Remove all *.o and *.d + executable                                                  #
#                                                                                                  #
# help 		- Show help about commands (DEFAULT GOAL)                                              #
# info-% 	- Rule will execute a make % command with --dry-run                                    #
# print-% 	- That works like print-<rule> will print the value of an arbitrary variable           #
#--------------------------------------------------------------------------------------------------#


.PHONY: all
all: build

$(TARGET): $(OBJECTS) $(LIBS_TARGET)
	$(DIR_DUP)
	$(CC) $(OBJECTS) $(LDFLAGS) $(LDLIBS) -o $@
	$(info [LINKING] $@ : $(CC) $(OBJECTS) $(LDFLAGS) $(LDLIBS) -o $@)

$(LIBS_TARGET):
	for d in $(LIBS_DIRS:%$(LBUILD_DIR)/=%); do \
		$(MAKE) -C $$d; \
	done

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c
	$(DIR_DUP)
	$(CC) -c $< -o $@ $(CFLAGS) $(CPPFLAGS)
	$(info [COMPILED] $@ : $(CC) -c $< -o $@ $(CFLAGS) $(CPPFLAGS))

-include $(DEPS)

.PHONY: build
build: $(TARGET)  ## Compile project

.PHONY: re
re:  ## Recompile project
	$(MAKE) fclean
	$(MAKE) all

.PHONY: clean
clean:  ## Remove all object and dep files
	for f in $(LIBS_DIRS:%$(LBUILD_DIR)/=%); do $(MAKE) -C $$f clean; done
	$(info $(RM) $(OBJECTS) $(DEPS))
	$(RM) $(OBJECTS) $(DEPS)

.PHONY: fclean
fclean: clean  ## Remove all executable files + object + dep files
	for f in $(LIBS_DIRS:%$(LBUILD_DIR)/=%); do $(MAKE) -C $$f fclean; done
	$(info $(RM) $(TARGET))
	$(RM) $(TARGET)

.DEFAULT_GOAL := help
.PHONY: help
help:  ## Show this output, i.e. help to use the commands
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' Makefile | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

info-%:
	@make --dry-run --always-make $* | grep -v "info"

print-%:
	@$(info '$*'='$($*)')


.SILENT:

