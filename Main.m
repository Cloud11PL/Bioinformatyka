clear

disp('Choose the parameters');
match = input('Match:');
mismatch = input('Mismatch:');
gap = input('Gap:');

disp('Choose the method.');
disp('1. From text');
disp('2. From file');
disp('3. From database');
disp('4. Show sample');

method = input('Your choice:');

if method == 4
    getFasta(method)
    return;
else
    dataset = getFasta(method);
end

method1 = input('Choose method for the second sequence: ');
dataset2 = getFasta(method1);

seq1Length = length(dataset.sequence);
seq2Length = length(dataset2.sequence);

%[matrix] = charMatrix(dataset.sequence, dataset2.sequence);

%matrix = cell(seq1Length+2,seq2Length+2);
%matches = zeros(seq1Length+1,seq2Length+1);
%matrix=parseInitMatrix(dataset.sequence,dataset2.sequence);

matrix = zeros(seq1Length+1,seq2Length+1);
matrixCompared = charMatrix(dataset.sequence,dataset2.sequence);
matrix = parseInitMatrix(matrix,gap,seq1Length,seq2Length);
matrix = compareMatrices(matrix,matrixCompared,seq1Length,seq2Length);
%MAMY GOTOW? DO PUNKTOWANIA MACIERZ


matrix = scoreMatrix(matrix,match,mismatch,gap, seq1Length, seq2Length);
%dl pierwszej = ilosc wierszy
curColumn = seq2Length;
curRow = seq1Length;
columnOne = zeros(curColumn+1,1);
rowOne = zeros(1,curRow+1);
shallowMatrix = ones(seq1Length+1,seq2Length+1);

for row = 1:curRow
    for column = 1:curColumn
        shallowMatrix(row+1,column+1) = matrixCompared(row,column);
    end
end

[matrixPath,length,matchCount,gapCount,seqMatrix1,seqMatrix2] = createMatrixPath(curRow+1, curColumn+1, matrix, shallowMatrix, gap, mismatch, dataset.sequence, dataset2.sequence);
matrixPath(1,1) = 1; %hardcoded, ale konieczne

seqMatrix1 = flip(seqMatrix1);
seqMatrix2 = flip(seqMatrix2);

figure;
subplot(1,2,1)
heatmap(matrixPath)
subplot(1,2,2)
heatmap(matrix)

disp("Length: " + length);
disp("Match count: " + matchCount);
disp("Gap count: " + gapCount);
disp("Identity: " + matchCount + "/" + length + "(" + round(matchCount*100/length) + ")");
disp("Gaps: " + gapCount + "/" + length + "(" + round(gapCount*100/length) + ")");
disp(seqMatrix1);
disp(seqMatrix2);
