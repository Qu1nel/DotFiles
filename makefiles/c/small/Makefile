TARGET := main

CC := gcc
CFLAGS := -Wall
LDFLAGS :=

SOURCES := $(shell find . -type f -name '*.c' 2>/dev/null)
OBJECTS := $(SOURCES:.c=.o)


.PHONY: configure check tests install uninstall


.PHONY: all
all: $(TARGET)


$(TARGET): $(OBJECTS)
	$(CC) $(LDFLAGS) $(CFLAGS) $(OBJECTS) -o $(TARGET)


.c.o:
	$(CC) $(CFLAGS) -c $< -o $@


.PHONY: build
build: $(TARGET)


.PHONY: run
run: $(TARGET)
	./$(TARGET)


.PHONY: clean
clean:
	rm -rf $(TARGET) $(OBJECTS)

