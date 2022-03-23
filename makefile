CFLAGS = -std=c++11 -msse4.2 -O3 -march=native 
CC = g++
OBJDIR = obj
SDSLFLAGS = -DNDEBUG -I ~/include -L ~/lib -lsdsl -ldivsufsort -ldivsufsort64
vpath %.cpp src
vpath %.hpp src

program: $(OBJDIR)/main.o $(OBJDIR)/intersection.o $(OBJDIR)/util_functions.o $(OBJDIR)/barbay_and_kenyon.o
	$(CC) $(CFLAGS) -o program $(OBJDIR)/main.o $(OBJDIR)/intersection.o $(OBJDIR)/util_functions.o $(OBJDIR)/barbay_and_kenyon.o -O3 -DNDEBUG -I ~/include -L ~/lib -lsdsl -ldivsufsort -ldivsufsort64

build: test/build_tries.cpp
	$(CC) $(CFLAGS) test/build_tries.cpp -o build $(SDSLFLAGS)

queries: test/intersection_query_log.cpp
	$(CC) $(CFLAGS) test/intersection_query_log.cpp -o queries $(SDSLFLAGS)

$(OBJDIR)/intersection.o: src/intersection.cpp src/intersection.hpp
	mkdir -p obj
	$(CC) $(CFLAGS) -c -o $@ src/intersection.cpp $(SDSLFLAGS)

$(OBJDIR)/util_functions.o: src/util_functions.cpp src/util_functions.hpp
	mkdir -p obj
	$(CC) $(CFLAGS) -c -o $@ src/util_functions.cpp $(SDSLFLAGS)

$(OBJDIR)/barbay_and_kenyon.o: src/barbay_and_kenyon.cpp src/barbay_and_kenyon.hpp
	mkdir -p obj
	$(CC) $(CFLAGS) -c -o $@ src/barbay_and_kenyon.cpp

$(OBJDIR)/main.o: src/main.cpp
	mkdir -p obj
	$(CC) $(CFLAGS) -c -o $@ src/main.cpp $(SDSLFLAGS)

clean:
	rm -f core $(OBJDIR)/*.o program build

run: 
	./program