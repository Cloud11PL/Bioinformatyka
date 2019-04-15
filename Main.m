clear

disp('Choose the parameters');
match = input('Match:');
mismatch = input('Mismatch:');
gap = input('Gap:');

disp('Choose the method.');
disp('1. From text');
disp('2. From file');
disp('3. From database');

method = input('Your choice:');

dataset = getFasta(method);

method1 = input('Choose method for the second sequence: ');
dataset2 = getFasta(method1);

seq1Length = length(dataset.sequence);
seq2Length = length(dataset2.sequence);

%1. for po macierzy
% [ x = if match 
% [ y = else if mismatch
% [ z1 = if gap1
% [ z2 = if gap2
% max[x,y,z1,z2]

%2. Path ?

