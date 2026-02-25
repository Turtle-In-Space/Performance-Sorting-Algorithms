set macros

set title 'Test'
set xlabel 'Array length'
set ylabel 'Time [ns]'
set xrange [0:*]

set terminal png size 1024,1024
set output out

if (axis ne "") set logscale @axis



plot for [i=1:words(files)] word(files,i) with lines title word(names,i), \
    x*log(x) with lines title "O(n log n)" lc black
