.PHONY: all clean build

# List all cmd packages
CMD_PACKAGES := $(notdir $(wildcard cmd/*))

# Define output directory
BIN_DIR := bin

# Default target
all: build

# Build all binaries
build: $(BIN_DIR) $(addprefix $(BIN_DIR)/, $(CMD_PACKAGES))

# Rule to create bin directory
$(BIN_DIR):
	mkdir -p $(BIN_DIR)

# Rule to build each binary
$(BIN_DIR)/%: cmd/%/main.go
	go build -o $@ $<

# Clean up
clean:
	rm -rf $(BIN_DIR)

# Show help
help:
	@echo "Available targets:"
	@echo "  all:    Build all binaries (default)"
	@echo "  build:  Same as 'all'"
	@echo "  clean:  Remove all built binaries"
	@echo "  help:   Show this help message"

