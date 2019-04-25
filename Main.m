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

[scoredMatrix, indexMatrix, match, gapCount] = smithWaterman(gap,seq1.sequence,seq2.sequence);

%find max value
%[x,y] = max(scoredMatrix);
[XCor, YCor] = findMaxCoordinates(scoredMatrix);

%find a path
[matrixPath,sequenceObject] = findPath(scoredMatrix,indexMatrix,XCor,YCor,seq1.sequence,seq2.sequence);

figure;
subplot(1,2,1)
heatmap(matrixPath,'XLabel',seq1.id,'YLabel',seq2.id,'GridVisible','off','ColorbarVisible','off')
subplot(1,2,2)
heatmap(scoredMatrix,'XLabel',seq1.id,'YLabel',seq2.id,'GridVisible','off')
print('Heatmaps','-dpng');

fid = fopen('outputData.txt','wt');
fprintf(fid,'%s\n', "Gap: " + gap);
%fprintf(fid,'%s\n', type('subMatrix.txt')); %punktacja?
fprintf(fid,'%s\n', "1 compared sequence: " + seq1.id);
fprintf(fid,'%s\n', "2 compared sequence: " + seq2.id); %parametry programu I guess?
fclose(fid);

disp("Gap: " + gap);
disp("1 compared sequence: " + seq1.id);
disp("2 compared sequence: " + seq2.id);
disp("Length: " + length(sequenceObject(1).seq1));
struct2table(sequenceObject)
disp("Match: " + match/length(sequenceObject(1).seq1));