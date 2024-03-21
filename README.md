# Trie-Compressed Intersectable Sets
--------
## Building the code
The code was tested in ubuntu 20.04, cmake 3.22.1 and gcc 9.3.0 version. The code has dependencies on the [**sdsl**](https://github.com/simongog/sdsl-lite) library.

To build the code in linux sistems, run the following commands:

    mkdir build
    cd build
    cmake ..
    make

Now, all executables are in **build** folder.

## Input data format
Our implementation only need the collection of docID's (posting lists) following format of [**dsi2**](https://github.com/ot/ds2i) and [**pisa**](https://github.com/pisa-engine/pisa) projects, the posting lists are written as 32-bit little-endian unsigned integers. The files containing the collections must start with a singleton binary sequence, where it's only integer is the number of documents of collection or the universe (1 u). It is then followed by one binary sequence for each posting list. 

## How to compress collection
For compress a collection need to use build.out exec as following.

    ./tools/build [collection_file_name] [--rank rank_type] [block_size (optional)] [--runs r] [--out o] [--min_size m]
Where:
* --rank rank_type (required): its the type of rank data structure, the posible values are: v, v5, il.
* block_size: only need to add block_size parameter if you use rank il data structure.
* --runs r (required): posible values t o f, indicating if we compress or not the runs in the tries.
* --out o (optional): name of output file to save the tries, if not specified only return the space metrics of collection.
* --min_size m (optional): filter lists of length less than a m.

## Intersection
For test the intersection of the tries, only need the file containing the collection compressed and a file with lists of sets involved in a query. The each line of queries file contain the id's of sets involved in a intersection to compute, every id it's separated by only one space. Every id of set correspond position of set in the complete collection.

An example to calculate the intersection in a collection using a query file is the following:

    ./tools/queries [collection_file_name] [queries_file_name]
    
The meaning of parameters are the same of above.
    
## Replicate Results
If you want replicate the results of paper, yo can download CC-News inverted index already processed by Mackenzie et al. in CIFF format from here: <http://go.unimelb.edu.au/u3nj>, and you can transform the index from CIFF to PISA format using <https://github.com/pisa-engine/ciff>.