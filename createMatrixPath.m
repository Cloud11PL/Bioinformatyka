function [matrixPath,length,matchCount,gapCount, seq1Array, seq2Array] = createMatrixPath(curRow, curColumn, finalMatrix, matrixCompared, gap,mismatch, seq1,seq2)
%this function creates the path and creates a sequence output

    length = 0;
    matchCount = 0;
    gapCount = 0;
    matrixPath = zeros(size(finalMatrix));
    i = 1;
    
    while (curColumn > 1) || (curRow > 1)
        a = finalMatrix(curRow,curColumn-1); %gap - side
        b = finalMatrix(curRow-1,curColumn); %gap - up
        c = finalMatrix(curRow-1,curColumn-1); %match/mismatch

        
        if(finalMatrix(curRow,curColumn) + gap == b) %w gore
            if(matrixCompared(curRow-1,curColumn-1) == 1)
                matchCount = matchCount + 1;
            end
            matrixPath(curRow,curColumn) = 1;
            gapCount = gapCount + 1;
            seq1Array(i)=seq1(curRow-1);
            seq2Array(i)='_';
            curRow = curRow - 1;
            
        elseif(finalMatrix(curRow,curColumn) + mismatch == c) %skos w lewo-gore
            %powinien byc match
            if(matrixCompared(curRow-1,curColumn-1) == 1)
                matchCount = matchCount + 1;
                seq1Array(i)=seq1(curRow-1);
                seq2Array(i)=seq2(curColumn-1);
            end
            matrixPath(curRow,curColumn) = 1;
            curColumn = curColumn - 1;
            curRow = curRow - 1;
            
        elseif(finalMatrix(curRow,curColumn) + gap == a) %w lewo
            
            if(matrixCompared(curRow-1,curColumn-1) == 1)
                matchCount = matchCount + 1;
            end
            
            matrixPath(curRow,curColumn) = 1; 
            seq1Array(i)='_';
            seq2Array(i)=seq2(curColumn-1);
            gapCount = gapCount + 1;
            curColumn = curColumn - 1;
        end
        length = length +1;
        i = i + 1;
    end
end