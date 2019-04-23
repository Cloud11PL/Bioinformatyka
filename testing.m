clc
clear
seq1 = ['-','T','T','A','T'];%minus ulatwia dalsze obliczenia
seq2 = ['-','A','T','A'];
[scoredMatrix, indexMatrix] = smithWaterman(-2,seq1,seq2)

%find max value
[x,y] = max(scoredMatrix);
maxValue = max(max(scoredMatrix));

XCorLength = length(scoredMatrix(:,1));
YCorLength = length(scoredMatrix(1,:));

XCor = [];
YCor = [];

%find occurances of the max value
for m = 1:XCorLength
    for n = 1:YCorLength
        if scoredMatrix(m,n) == maxValue
            XCor(end+1) = m;
            YCor(end+1) = n;
        end
    end
end

%find a path
matrixPath = zeros(XCorLength,YCorLength);
index = 1;
while index <= length(XCor) %nie ma znaczenia czy X czy Y
    curRow = XCor(index);
    curCol = YCor(index);
    index = index + 1;
    curIndex = indexMatrix(curRow, curCol);
    
    while (curIndex ~= 4) && (curIndex ~= 0)
        matrixPath(curRow, curCol) = 1;
        curIndex = indexMatrix(curRow, curCol)
        if(curIndex == 1)
            %check if mismatch?
            curRow = curRow - 1;
            curCol = curCol - 1;
        elseif(curIndex == 2)
            %gap up
            curRow = curRow - 1;
        elseif(curIndex == 3)
            %gap left
            curCol = curCol -1;
        end
    end
end

figure;
subplot(1,2,1)
heatmap(matrixPath,'GridVisible','off','ColorbarVisible','off','ColorScaling','scaledcolumns')
subplot(1,2,2)
heatmap(scoredMatrix,'GridVisible','off')
print('Heatmaps','-dpng');

            
