clc
clear
seq1 = parseFasta(fileFasta('AsiaticElephant.fasta'))
seq2 = parseFasta(fileFasta('Mammoth.fasta'))

seq1Length = length(seq1.sequence);
seq2Length = length(seq2.sequence);
gap = -2;

[scoredMatrix, indexMatrix, match, gap] = smithWaterman(gap,seq1.sequence,seq2.sequence);

%find max value
%[x,y] = max(scoredMatrix);
%maxValue = max(max(scoredMatrix));

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
disp(sequenceObject);
disp("Match: " + match/length(sequenceObject(1).seq1));
            
