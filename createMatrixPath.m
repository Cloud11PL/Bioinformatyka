function [score,seq1Array,seq2Array] = createMatrixPath(indexMatrix,scoringMatrix,seq1,seq2)
%this function creates the path and creates a sequence output

    matrixPath = zeros(size(indexMatrix));
    curRow = length(seq1) + 1;
    curColumn = length(seq2) + 1;
    score = 0;
    i = 1;

    %(curColumn > 2) || (curRow > 2)
    while (curColumn > 1) || (curRow > 1)
        matrixPath(curRow,curColumn) = 1; 
        if(indexMatrix(curRow, curColumn) == 1)
            curScore = findMatch(scoringMatrix,seq1(curRow-1),seq2(curColumn-1));
            seq1Array(i)=seq1(curRow-1);
            seq2Array(i)=seq2(curColumn-1);
            curColumn = curColumn - 1;
            curRow = curRow - 1;
        elseif(indexMatrix(curRow,curColumn) == 2 || curColumn == 1)
            seq1Array(i)=seq1(curRow-1);
            seq2Array(i)='_';
            curScore = findMatch(scoringMatrix,seq1(curRow-1),'-');
            curRow = curRow - 1;
        elseif(indexMatrix(curRow,curColumn) == 3 || curRow == 1)
            seq1Array(i)='_';
            seq2Array(i)=seq2(curColumn-1);
            curScore = findMatch(scoringMatrix,seq2(curColumn-1),'-');
            curColumn = curColumn - 1;            
        end
        score = curScore + score;
        i = i + 1;
    end
    
    seq1Array = flip(regexprep(seq1Array(~isspace(seq1Array)),'\n+',''));
    seq2Array = flip(regexprep(seq2Array(~isspace(seq2Array)),'\n+',''));
end