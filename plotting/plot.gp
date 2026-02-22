set title 'Test'
set xlabel 'Array length'
set ylabel 'Time [ns]'

set terminal png size 1024,1024
set output out

plot for [i=1:words(files)] \
    word(files,i) with linespoints title word(names,i)
