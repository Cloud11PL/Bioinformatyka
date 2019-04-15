clc
clear
seq1 = ['-','T','T','A','T'];%minus ulatwia dalsze obliczenia
seq2 = ['-','A','T','A'];
scoredMatrix = smithWaterman(-2,seq1,seq2)

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
        %w lewo
        left = scoredMatrix(curRow,curCol - 1);
        %w gore
        up = scoredMatrix(curRow - 1, curCol);
        %na skosss
        diag = scoredMatrix(curRow - 1, curCol - 1);
        
        [localMax,pos] = max([left up diag]);
        
        if(localMax > 0)
            if(pos == 1)
                curCol = curCol - 1;
            elseif(pos == 2)
                curRow = curRow - 1;
            else
                curRow = curRow - 1;
                curCol = curCol - 1;
            end
        end
    end
end

heatmap(matrixPath)

            
