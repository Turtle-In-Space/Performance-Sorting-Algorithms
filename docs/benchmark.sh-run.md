% benchmark.sh-run(1) | Runs all sorting algorithms
% 
% February 2026

NAME
==================================================

**benchmark.sh run** - Runs all sorting algorithms

SYNOPSIS
==================================================

**benchmark.sh run** [OPTIONS]

DESCRIPTION
==================================================

Runs all sorting algorithms


OPTIONS
==================================================

--lower, -l LOWER
--------------------------------------------------

lower bound of n for array length

- Default Value: **1000**

--upper, -u UPPER
--------------------------------------------------

upper bound of n for array length

- Default Value: **10000**

--step, -s STEP
--------------------------------------------------

size of steps for n to use

- Default Value: **500**

--iter, -i ITER
--------------------------------------------------

number of times each size of n will be tested

- Default Value: **25**

--out, -o OUT
--------------------------------------------------

a csv file to store timings in


--algo ALGO
--------------------------------------------------

Name of sorting algorithms [SORT1,SORT2,...]


--lang LANG
--------------------------------------------------

Name of coding languaes [LANG1,LANG2,...]


EXAMPLES
==================================================

~~~
benchmark run --lang java

benchmark run -l 10 -u 20 -s 1 -i 5 -o data.csv

~~~

SEE ALSO
==================================================

**benchmark.sh**(1)


