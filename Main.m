clc
clear
close all

disp('Choose the method.');
disp('1. From text');
disp('2. From file');
disp('3. From database');

method = input('Your choice:');

seq1 = getFasta(method);

method1 = input('Choose method for the second sequence: ');
seq2 = getFasta(method1);

seq1Length = length(seq1.sequence);
seq2Length = length(seq2.sequence);

%1. for po macierzy
% [ x = if match 
% [ y = else if mismatch
% [ z1 = if gap1
% [ z2 = if gap2
% max[x,y,z1,z2] lub 0!!! nie moze byc mniejsze niz 0

%2. Path ?
%Znalezienie maksymalnej liczby w macierzy
%Sciezka od najwiekszej w gore

gap = 2;

outputSeq = smithWaterman(gap,seq1,seq2);
