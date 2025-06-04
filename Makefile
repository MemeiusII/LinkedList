# Fortran compiler
FC = gfortran

# Compilation flags
FFLAGS = -Wall -O2 -J$(BUILD_DIR)

# Directories
SRC_DIR = ./main
SUB_DIR = ./sub
BUILD_DIR = ./build

# Source files
MAIN_SRC = $(SRC_DIR)/main.f90
LIST_SRC = $(SUB_DIR)/list.f90

# Object files
MAIN_OBJ = $(BUILD_DIR)/main.o
LIST_OBJ = $(BUILD_DIR)/list.o

# Executable
EXEC = $(BUILD_DIR)/program.exe

# Default rule
all: $(EXEC)

# Link executable
$(EXEC): $(LIST_OBJ) $(MAIN_OBJ)
	$(FC) $(FFLAGS) -o $@ $^

# Compile list.f90 into list.o and list.mod
$(LIST_OBJ): $(LIST_SRC) | $(BUILD_DIR)
	$(FC) $(FFLAGS) -c $< -o $@

# Compile main.f90 into main.o, must happen after list.f90 (because it uses list.mod)
$(MAIN_OBJ): $(MAIN_SRC) $(LIST_OBJ) | $(BUILD_DIR)
	$(FC) $(FFLAGS) -c $< -o $@

# Ensure build directory exists
$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

# Clean build artifacts
clean:
	rm -rf $(BUILD_DIR)

.PHONY: all clean
