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
while index <= length(XCor)
    curRow = XCor(index);
    curCol = YCor(index);
    index = index + 1;
    localMax = maxValue;
    
    while localMax ~= 0
        matrixPath(curRow, curCol) = 1;
%         %w lewo
%         left = scoredMatrix(curRow,curCol - 1);
%         %w gore
%         up = scoredMatrix(curRow - 1, curCol);
%         %na skosss
%         diag = scoredMatrix(curRow - 1, curCol - 1);
%         
%         [localMax,pos] = max([left up diag]);
%         
%         if(localMax > 0)
%             if(pos == 1) %w lewo
%                 curCol = curCol - 1;
%             elseif(pos == 2) %w gore
%                 curRow = curRow - 1;
%             else %na skos
%                 curRow = curRow - 1;
%                 curCol = curCol - 1;
%             end
%         end
        curIndex = indexMatrix(curRow, curColumn)
        if(curIndex == 1)
            %mm
        elseif(curIndex == 2)
            %gap up
        elseif(curIndex == 3)
            %gap left
        else
            %0
        end
    end
end

% if(indexMatrix(curRow, curColumn) == 1)
%             if(matrixCompared(curRow-1,curColumn-1) == 1) %bo nie wiem czy to match czy mismatch
%                 matchCount = matchCount + 1;
%                 seq1Array(i)=seq1(curRow-1);
%                 seq2Array(i)=seq2(curColumn-1);
%             end
%             curColumn = curColumn - 1;
%             curRow = curRow - 1;
%         elseif(indexMatrix(curRow,curColumn) == 2)
%             seq1Array(i)=seq1(curRow-1);
%             seq2Array(i)='_';
%             curRow = curRow - 1;
%             gapCount = gapCount + 1;
%         else
%             seq1Array(i)='_';
%             seq2Array(i)=seq2(curColumn-1);
%             curColumn = curColumn - 1;
%             gapCount = gapCount + 1;
%         end

figure;
heatmap(matrixPath)

figure;
heatmap(scoredMatrix)

            
