# Performance-Sorting-Algorithms
A collection of sorting algorithms which can be benchmarked against each other.


## idea

One script benchmarks all algos, produces graph for each algo/lang and also algo/algo. 

Script calls benchmark.sh in each lang folder, benchmark produces results.txt

Add test flag for script?

Single data type for all langs. 
array? in place?

### opts for script

- n | how many elements to sort
- lang | only bench specific lang
- test? | do unit tests

## Tools:

- gnuplot
- bashly

## Languages 
- [ ]  c
- [ ] c with assembly 
- [ ] python
- [ ] java 
- [ ] go
- [ ] c++

## Structure

- sorting algos/
  - merge sort/
    - benchmark.sh
    - combined_result.txt
    - [lang]/
       - code
       - result.txt
       - benchmark.sh
       - test?
  - built in
     - -//-
  - combined_result.txt
  - benchmark.sh
