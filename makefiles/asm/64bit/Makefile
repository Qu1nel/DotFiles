# ------------- * Init settings * -------------
# tools
CC = nasm
CFLAGS = -f elf64
LFLAGS = -m elf_x86_64

# path macros
BLD_DIRPATH := build

# compile macros
TARGET := main
TARGET_EXECUTABLE = $(BLD_DIRPATH)/$(TARGET)

# src & obj files
SOURCES := $(shell find . -type f -name '*.asm' 2>/dev/null)
OBJECTS := $(addsuffix .o, $(notdir $(basename $(SOURCES))))

# project settings
PROJECT_NAME := Assebmly 64bit Project

default: makedirs all

# ------------- * Main * -------------
.PHONY: all
all: $(TARGET_EXECUTABLE)

.PHONY: build
build: $(TARGET_EXECUTABLE)

$(TARGET_EXECUTABLE): $(OBJECTS) 
	ld $(LFLAGS) $(OBJECTS) -o $@

$(OBJECTS): $(SOURCES)
	$(CC) $(CFLAGS) $< -o $@

.PHONY: clean
clean:
	rm -rf $(TARGET_EXECUTABLE) $(OBJECTS)

.PHONY: run
run:
	@echo "Starting the project \"$(PROJECT_NAME)\".."
	@./$(TARGET_EXECUTABLE)

.PHONY: makedirs
makedirs:
	@mkdir -pv $(BLD_DIRPATH)
