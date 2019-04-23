function [matrixPath,length,matchCount,gapCount, seqMatrix1, seqMatrix2] = createMatrixPath(curRow, curColumn, matrix, matrix2,gap,mismatch, seq1,seq2)
    length = 0;
    matchCount = 0;
    gapCount = 0;
    matrixPath = zeros(size(matrix));
    i = 1;
    %8pNcPsmbmxja
    while curColumn ~= 1 || curRow ~= 1
        a = matrix(curRow,curColumn-1); %w lewo
        b = matrix(curRow-1,curColumn); %do gory
        c = matrix(curRow-1,curColumn-1); %lewy skos
        if(matrix(curRow,curColumn) - gap == b) %w gore
            if(matrix2(curRow,curColumn) == 1)
                matchCount = matchCount + 1;
            end
            matrixPath(curRow,curColumn) = 1;
            gapCount = gapCount + 1;
            seqMatrix1(i)=seq1(curRow-1);
            seqMatrix2(i)='_';
            curRow = curRow - 1;
            
        elseif(matrix(curRow,curColumn) + mismatch == c) %skos w lewo-gore
            %powinien byc match
            if(matrix2(curRow,curColumn) == 1)
                matchCount = matchCount + 1;
                seqMatrix1(i)=seq1(curRow-1);
                seqMatrix2(i)=seq2(curColumn-1);
            end
            matrixPath(curRow,curColumn) = 1;
            curColumn = curColumn - 1;
            curRow = curRow - 1;
            
        elseif(matrix(curRow,curColumn)-gap == a) %w lewo
            if(matrix2(curRow,curColumn) == 1)
                matchCount = matchCount + 1;
            end
            matrixPath(curRow,curColumn) = 1; 
            seqMatrix1(i)='_';
            seqMatrix2(i)=seq2(curColumn-1);
            gapCount = gapCount + 1;
            curColumn = curColumn - 1;
        end
        length = length +1;
        i = i + 1;
    end
end