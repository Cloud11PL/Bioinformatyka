clc
clear
close all

disp('Choose the method.');
gap = input('Gap: ');

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

[scoredMatrix, indexMatrix] = smithWaterman(gap,seq1.sequence,seq2.sequence);

%find max value
[x,y] = max(scoredMatrix);
maxValue = max(max(scoredMatrix));

[XCor, YCor] = findMaxCoordinates(scoredMatrix,maxValue);

%find a path
[matrixPath] = findPath(scoredMatrix,indexMatrix,XCor,YCor);

figure;
subplot(1,2,1)
heatmap(matrixPath,'XLabel',seq1.id,'YLabel',seq2.id,'GridVisible','off','ColorbarVisible','off','ColorScaling','scaledcolumns')
subplot(1,2,2)
heatmap(scoredMatrix,'XLabel',seq1.id,'YLabel',seq2.id,'GridVisible','off')
print('Heatmaps','-dpng');

