function [matrixPath, length, matchCount, gapCount, seq1Array, seq2Array] = createMatrixPath(curRow, curColumn, indexMatrix, matrixCompared, seq1,seq2)
%this function creates the path and creates a sequence output

    length = 0;
    matchCount = 0;
    gapCount = 0;
    matrixPath = zeros(size(indexMatrix));
    i = 1;
    
    while (curColumn > 1) || (curRow > 1)
        matrixPath(curRow,curColumn) = 1; 
        if(indexMatrix(curRow, curColumn) == 1)
            if(matrixCompared(curRow-1,curColumn-1) == 1) %bo nie wiem czy to match czy mismatch
                matchCount = matchCount + 1;
                seq1Array(i)=seq1(curRow-1);
                seq2Array(i)=seq2(curColumn-1);
            end
            curColumn = curColumn - 1;
            curRow = curRow - 1;
        elseif(indexMatrix(curRow,curColumn) == 2)
            seq1Array(i)=seq1(curRow-1);
            seq2Array(i)='_';
            curRow = curRow - 1;
            gapCount = gapCount + 1;
        else
            seq1Array(i)='_';
            seq2Array(i)=seq2(curColumn-1);
            curColumn = curColumn - 1;
            gapCount = gapCount + 1;
        end
        length = length +1;
        i = i + 1;
    end
end