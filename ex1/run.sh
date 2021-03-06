#!/bin/sh
set -eux

# same_start
ns same_start.tcl

grep "0  0  4  0  cwnd" same_start.tcp > cwnd_tcp0_same_start.dat
grep "1  0  5  0  cwnd" same_start.tcp > cwnd_tcp1_same_start.dat

gnuplot -e "
set terminal png;
set output 'cwnd_same_start.png';
plot
  'cwnd_tcp0_same_start.dat' u 1:7 w l title 'tcp0',
  'cwnd_tcp1_same_start.dat' u 1:7 w l title 'tcp1';"


awk '$1 == "r" && $3 == "2" && $4 == "3" && $8 == "1"' \
    < same_start.tr \
    | perl -e '
$time = 0;
$bw = 0;
while (<>) {
  @field = split(/ /);
  if ($field[1] > ($time + 1)) {
    print "$time $bw\n";
    $time += 1;
    $bw = 8 * $field[5];
  } else {
    $bw += 8 * $field[5];
  }
}
print "$time $bw\n";' \
    > bandwidth_tcp0_same_start.dat

awk '$1 == "r" && $3 == "2" && $4 == "3" && $8 == "2"' \
    < same_start.tr \
    | perl -e '
$time = 0;
$bw = 0;
while (<>) {
  @field = split(/ /);
  if ($field[1] > ($time + 1)) {
    print "$time $bw\n";
    $time += 1;
    $bw = 8 * $field[5];
  } else {
    $bw += 8 * $field[5];
  }
}
print "$time $bw\n";' \
    > bandwidth_tcp1_same_start.dat

join bandwidth_tcp0_same_start.dat bandwidth_tcp1_same_start.dat \
    > bandwidth_same_start.dat

gnuplot -e '
set terminal png;
set output "bandwidth_same_start.png";
set multiplot;
plot
  "bandwidth_same_start.dat" u 1:($2+$3) title "tcp1" with filledcurves x1,
  "bandwidth_same_start.dat" u 1:($2) title "tcp0" with filledcurves x1;'

# different start
ns different_start.tcl

grep "0  0  4  0  cwnd" different_start.tcp > cwnd_tcp0_different_start.dat
grep "1  0  5  0  cwnd" different_start.tcp > cwnd_tcp1_different_start.dat

gnuplot -e "
set terminal png;
set output 'cwnd_different_start.png';
plot
  'cwnd_tcp0_different_start.dat' u 1:7 w l title 'tcp0',
  'cwnd_tcp1_different_start.dat' u 1:7 w l title 'tcp1';"


awk '$1 == "r" && $3 == "2" && $4 == "3" && $8 == "1"' \
    < different_start.tr \
    | perl -e '
$time = 0;
$bw = 0;
while (<>) {
  @field = split(/ /);
  if ($field[1] > ($time + 1)) {
    print "$time $bw\n";
    $time += 1;
    $bw = 8 * $field[5];
  } else {
    $bw += 8 * $field[5];
  }
}
print "$time $bw\n";' \
    > bandwidth_tcp0_different_start.dat

awk '$1 == "r" && $3 == "2" && $4 == "3" && $8 == "2"' \
    < different_start.tr \
    | perl -e '
$time = 0;
$bw = 0;
while (<>) {
  @field = split(/ /);
  if ($field[1] > ($time + 1)) {
    print "$time $bw\n";
    $time += 1;
    $bw = 8 * $field[5];
  } else {
    $bw += 8 * $field[5];
  }
}
print "$time $bw\n";' \
    > bandwidth_tcp1_different_start.dat

join bandwidth_tcp0_different_start.dat bandwidth_tcp1_different_start.dat \
    > bandwidth_different_start.dat

gnuplot -e '
set terminal png;
set output "bandwidth_different_start.png";
set multiplot;
plot
  "bandwidth_different_start.dat" u 1:($2+$3) title "tcp1" with filledcurves x1,
  "bandwidth_different_start.dat" u 1:($2) title "tcp0" with filledcurves x1;'

# different delay
ns different_delay.tcl

grep "0  0  4  0  cwnd" different_delay.tcp > cwnd_tcp0_different_delay.dat
grep "1  0  5  0  cwnd" different_delay.tcp > cwnd_tcp1_different_delay.dat

gnuplot -e "
set terminal png;
set output 'cwnd_different_delay.png';
plot
  'cwnd_tcp0_different_delay.dat' u 1:7 w l title 'tcp0',
  'cwnd_tcp1_different_delay.dat' u 1:7 w l title 'tcp1';"


awk '$1 == "r" && $3 == "2" && $4 == "3" && $8 == "1"' \
    < different_delay.tr \
    | perl -e '
$time = 0;
$bw = 0;
while (<>) {
  @field = split(/ /);
  if ($field[1] > ($time + 1)) {
    print "$time $bw\n";
    $time += 1;
    $bw = 8 * $field[5];
  } else {
    $bw += 8 * $field[5];
  }
}
print "$time $bw\n";' \
    > bandwidth_tcp0_different_delay.dat

awk '$1 == "r" && $3 == "2" && $4 == "3" && $8 == "2"' \
    < different_delay.tr \
    | perl -e '
$time = 0;
$bw = 0;
while (<>) {
  @field = split(/ /);
  if ($field[1] > ($time + 1)) {
    print "$time $bw\n";
    $time += 1;
    $bw = 8 * $field[5];
  } else {
    $bw += 8 * $field[5];
  }
}
print "$time $bw\n";' \
    > bandwidth_tcp1_different_delay.dat

join bandwidth_tcp0_different_delay.dat bandwidth_tcp1_different_delay.dat \
    > bandwidth_different_delay.dat

gnuplot -e '
set terminal png;
set output "bandwidth_different_delay.png";
set multiplot;
plot
  "bandwidth_different_delay.dat" u 1:($2+$3) title "tcp1" with filledcurves x1,
  "bandwidth_different_delay.dat" u 1:($2) title "tcp0" with filledcurves x1;'
