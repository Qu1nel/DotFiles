# ------------- * Init settings * -------------
# tools
CXX := g++
LDFLAGS :=
CFLAGS := -Wall
COMFLAGS := $(CFLAGS) -c

# path macros
SRC_DIRPATH := src/
BLD_DIRPATH := build/

BIN_DIRNAME := debug
OBJ_DIRNAME := object-files

BIN_DIRPATH = $(BLD_DIRPATH)$(BIN_DIRNAME)/
OBJ_DIRPATH = $(BLD_DIRPATH)$(OBJ_DIRNAME)/

INSTALL_PATH = /usr/local/bin/


# compile macros
TARGET := main
TARGET_EXECUTABLE := $(BIN_DIRPATH)$(TARGET)
INSTALL_EXECUTABLE := $(INSTALL_PATH)$(TARGET)

# src & obj files
SOURCES := $(shell find $(SRC_DIRPATH) -type f -name '*.cpp' -or -name '*.cc' 2>/dev/null)
OBJECTS := $(addprefix $(OBJ_DIRPATH), $(addsuffix .o, $(notdir $(basename $(SOURCES)))))

# clean lists
DISTCLEAN_LIST := $(OBJECTS)
CLEAN_LIST := $(TARGET_EXECUTABLE) $(DISTCLEAN_LIST)

# colors TODO: make support for MacOS
RED := \\033[1;31m
GRN := \\033[0;32m
LGRN := \\033[1;32m
YLW := \\033[0;33m
LYLW := \\033[1;33m
PNK := \\033[0;95m
LPNK := \\033[1;95m
BLU := \\033[0;94m
LBLU := \\033[1;94m
RST := \\033[0m

# project settings
PROJECT_NAME := C++ Project

# last change check file
LAST := $(BLD_DIRPATH).last_changed

# default rules
default: show-info makedir all
	
# phony rules
.PHONY: configure check tests



# ------------- * Main * -------------
# non-phony rules
$(TARGET_EXECUTABLE): $(OBJECTS)
ifeq ($(OBJECTS),)
	@echo "$(RED)[WARNING]: You will be compiling an executable from old object files. In addition, no source code was found.$(RST)"
	@echo "$(LPNK)[Linking]:\t$(RST) $(CXX) $(LDFLAGS) $(shell find $(OBJ_DIRPATH) -type f -name '*.o' 2>/dev/null) -o $@"

	@$(CXX) $(LDFLAGS) $(shell find $(OBJ_DIRPATH) -type f -name '*.o' 2>/dev/null) -o $@

else
	@$(shell $(CXX) $(LDFLAGS) $(OBJECTS) -o $@)

	@if [ "$(.SHELLSTATUS)" -eq 0 ]; then\
		echo "$(LPNK)[Linking]:\t$(LGRN)SUCCEED$(RST)\t $(CXX) $(LDFLAGS) $(OBJECTS) -o $@";\
	else\
		echo "$(LPNK)[Linking]:\t$(RED)FAILED$(RST)\t $(CXX) $(LDFLAGS) $(OBJECTS) -o $@";\
	fi

endif
	@echo "$(LGRN)======================================= * DONE * =======================================$(RST)\n"
	@echo "You can run the program with $(GRN)\`make run\`$(RST) or see the help by writing $(GRN)\`make help\`$(RST)."


$(OBJ_DIRPATH)%.o: $(SRC_DIRPATH)%.cpp
	@$(shell $(CXX) $(COMFLAGS) $< -o $@)

	@if [ "$(.SHELLSTATUS)" -eq 0 ]; then\
		echo "$(LBLU)[Compilation]:\t$(LGRN)SUCCEED$(RST)\t $(CXX) $(COMFLAGS) $< -o $@";\
	else\
		echo "$(LBLU)[Compilation]:\t$(RED)FAILED$(RST)\t $(CXX) $(COMFLAGS) $< -o $@";\
	fi


$(LAST): $(SOURCES)
	@touch $(LAST)



# ------------- * Init rules * -------------
.PHONY: all
all: $(TARGET_EXECUTABLE)

.PHONY: makedir
makedir:
	@mkdir -pv $(SRC_DIRPATH) $(BLD_DIRPATH) $(OBJ_DIRPATH) $(BIN_DIRPATH)



# ------------- * Show info & Help * -------------
.PHONY: show-info
show-info: $(LAST)
ifeq ($(shell find $(BIN_DIRPATH) -type f -name $(TARGET) 2>/dev/null),)  # no executable file

ifeq ($(or $(shell find $(OBJ_DIRPATH) -type f -name '*.o' 2>/dev/null),$(OBJECTS)),)  # no any object files
ifeq ($(SOURCES),)  # and no source files
	@echo "$(RED)[ERROR]: There are not files to assemble the project$(RST)"
	@exit 1

endif
endif
	@echo "$(YLW)There is no executable file."
	@echo "Building project \"$(PROJECT_NAME)\"..$(RST)"
	@echo "\n$(LGRN)====================================== * PROCESS * =====================================$(RST)"

else ifeq ($(words $(shell find $(SRC_DIRPATH) -type f -name '*.cpp' -or -name '*.cpp' 2>/dev/null)),0)  # no source files
	@echo "$(RED)[WARNING]: No source code was found, but there is an executable which you can run with the command $(GRN)\`make run\`$(RED).$(RST)"

else ifneq ($(words $(shell find $(OBJ_DIRPATH) -type f -name '*.o' 2>/dev/null)), $(words $(SOURCES)))  # no object files
	@echo "$(YLW)There are no object files."
	@echo "Building project \"$(PROJECT_NAME)\"..$(RST)"
	@echo "\n$(LGRN)====================================== * PROCESS * =====================================$(RST)"

else  # changing several source files or nothing happened
	@if [ "$(shell date +%s)" -eq "$(shell stat -c '%Z' $(LAST))" ]; then\
		echo "$(YLW)There have been some minor changes to the source files.";\
		echo "Building project \"$(PROJECT_NAME)\"..$(RST)";\
		echo "\n$(LGRN)===================================== * PROCESS * =====================================$(RST)";\
	else\
		echo "$(YLW)The project is already built..";\
		echo "You don't need to build anything, just write a $(GRN)\`make run\`$(YLW) to run it$(RST)";\
	fi

endif


.PHONY: help
help:
	@echo usage: make [target]
	@echo
	@echo Options:
	@echo "$(LYLW)    build$(RST)                 $(GRN)Build app$(RST)"
	@echo "$(LYLW)    install$(RST)               $(GRN)Install executable in \"$(INSTALL_PATH)\"$(RST)"
	@echo "$(LYLW)    uninstall$(RST)             $(GRN)Uninstall executable from \"$(INSTALL_PATH)\"$(RST)"
	@echo "$(LYLW)    clean$(RST)                 $(GRN)Clean all$(RST)"
	@echo "$(LYLW)    distclean$(RST)             $(GRN)Clean object files$(RST)"
	@echo "$(LYLW)    execlean$(RST)              $(GRN)Clean executable file$(RST)"
	@echo
	@echo Other:
	@echo "$(LYLW)    help$(RST)                  $(GRN)Show this help.$(RST)"
	@echo "$(LYLW)    run$(RST)                   $(GRN)Running \"$(TARGET_EXECUTABLE)\"$(RST)"
	@echo



# ------------- * Build & Run * -------------
.PHONY: build
build: show-info makedir $(TARGET_EXECUTABLE)

.PHONY: run
run: $(TARGET_EXECUTABLE)
	@echo "Starting C++ program \"$(PROJECT_NAME)\": $(GRN)$(TARGET_EXECUTABLE)$(RST)"
	@./$(TARGET_EXECUTABLE)



# ------------- * Clean & Distclean * -------------
.PHONY: clean
clean:
ifneq ($(DISTCLEAN_LIST),)
	@echo "$(YLW)Removing: $(RST)$(CLEAN_LIST)$(RED)\n"
	@rm -fv $(CLEAN_LIST)

else ifneq ($(shell find $(OBJ_DIRPATH) -name '*.o' 2>/dev/null),)
	@echo "$(YLW)Removing: $(RST)$(shell find $(OBJ_DIRPATH) -name '*.o')$(CLEAN_LIST)$(RED)\n"
	@rm -fv $(shell find $(OBJ_DIRPATH) -name '*.o' 2>/dev/null) $(CLEAN_LIST)

else
	@echo "$(YLW)There is nothing to remove.$(RST)"

endif
	@echo "\n$(RST)Now you can run $(GRN)\`make build\`$(RST) and then $(GRN)\`make run\`$(RST)"


.PHONY: distclean
distclean:
ifneq ($(DISTCLEAN_LIST),)
	@echo "$(YLW)Removing: $(RST)$(DISTCLEAN_LIST)$(RED)\n"
	@rm -fv $(DISTCLEAN_LIST)

else ifneq ($(shell find $(OBJ_DIRPATH) -name '*.o' 2>/dev/null),)
	@echo "$(YLW)Removing: $(RST)$(shell find $(OBJ_DIRPATH) -name '*.o')$(RED)\n"
	@rm -fv $(shell find $(OBJ_DIRPATH) -name '*.o' 2>/dev/null)

else
	@echo "$(YLW)There is nothing to remove.$(RST)"

endif
	@echo "\n$(RST)Now you can run $(GRN)\`make build\`$(RST) and then $(GRN)\`make run\`$(RST)"


.PHONY: execlean
execlean:
	@echo "$(YLW)Remove: $(RST)$(TARGET_EXECUTABLE)$(RED)\n"
	@rm -fv $(TARGET_EXECUTABLE)
	@echo "\n$(RST)Now you can run $(GRN)\`make build\`$(RST) and then $(GRN)\`make run\`$(RST)"



# ------------- Installing & Uninstalling -------------
.PHONY: install
install:
	@echo "$(RED)INSTALL $(LGRN)$(INSTALL_EXECUTABLE)$(RST)"
	@cp -i $(TARGET_EXECUTABLE) $(INSTALL_PATH)

.PHONY: uninstall
uninstall:
	@echo "$(RED)REMOVE $(LGRN)$(INSTALL_EXECUTABLE)$(RST)"
	@rm -f $(INSTALL_EXECUTABLE)

