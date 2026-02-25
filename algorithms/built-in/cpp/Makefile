CC = g++
CFLAGS = -std=c++20 -Werror -Wall -Wextra -Wpedantic -Wmissing-declarations -O3 -march=native

BIN = sort
SRC = $(BIN).cpp
OBJ := $(SRC:%.cpp=%.o)

all: $(BIN)

$(BIN): $(OBJ) $(INC)
	$(CC) -o $(BIN) $(OBJ)

$(OBJ): %.o:%.cpp $(INC)
	$(CC) $(CFLAGS) -c $< 

clean: 
	rm -rf $(BIN) $(OBJ)
