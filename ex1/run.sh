#!/bin/sh
set -eux

# same_start
ns same_start.tcl

grep "0  0  4  0  cwnd" same_start.tcp > "cwnd_tcp0_same_start.dat"
grep "1  0  5  0  cwnd" same_start.tcp > "cwnd_tcp1_same_start.dat"

gnuplot -e "
set terminal png;
set output 'same_start.png';
set xrange [0:100];
set yrange [0:80];
plot 'cwnd_tcp0_same_start.dat' u 1:7 w l, 'cwnd_tcp1_same_start.dat' u 1:7 w l;"
