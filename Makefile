.PHONY: all build clean run-server run-client run test install help

# List all cmd packages
CMD_PACKAGES := $(notdir $(wildcard cmd/*))

# Define the build directory
BUILD_DIR = bin
BIN_DIR := bin

# Define binary names
SERVER_BIN = btools
J2P_BIN = j2p
P2J_BIN = p2j

# Define the paths to the source files
SERVER_SRC = main.go
J2P_SRC = cmd/j2p/main.go
P2J_SRC = cmd/p2j/main.go

# Default target: build all binaries
all: build

# Build all binaries using the dynamic approach
build: $(BUILD_DIR) $(addprefix $(BIN_DIR)/, $(CMD_PACKAGES))
	go build -o $(BUILD_DIR)/$(SERVER_BIN) $(SERVER_SRC)

# Create build directory if it doesn't exist
$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

# Rule to build each binary dynamically
$(BIN_DIR)/%: cmd/%/main.go
	go build -o $@ $<

# The following are kept for backward compatibility
build-server: $(BUILD_DIR)
	go build -o $(BUILD_DIR)/$(SERVER_BIN) $(SERVER_SRC)

build-j2p: $(BUILD_DIR)
	go build -o $(BUILD_DIR)/$(J2P_BIN) $(J2P_SRC)

build-p2j: $(BUILD_DIR)
	go build -o $(BUILD_DIR)/$(P2J_BIN) $(P2J_SRC)

# Clean build artifacts
clean:
	rm -rf $(BUILD_DIR)

# Run tests
test:
	go test ./...

# Install binaries to GOBIN
install: all
	cp $(BUILD_DIR)/* $(GOBIN)/

# Run the server
run-server:
	go run $(SERVER_SRC) -server


# Run the client (web frontend)
run-client:
	cd web && yarn start

# Run both server and client concurrently
run:
	$(MAKE) run-server & $(MAKE) run-client

# Show help
help:
	@echo "Available targets:"
	@echo "  all:        Build all binaries (default)"
	@echo "  build:      Same as 'all'"
	@echo "  clean:      Remove all built binaries"
	@echo "  run-server: Run the API server"
	@echo "  run-client: Run the web client"
	@echo "  run:        Run both server and client concurrently"
	@echo "  help:       Show this help message"

