function [matrixPath,sequenceObject,matchCount,gapCount] = findPath(scoredMatrix,indexMatrix,XCor,YCor,seq1,seq2)
%FINDPATH Summary of this function goes here

matrixPath = zeros(length(scoredMatrix(:,1)),length(scoredMatrix(1,:)));
sequenceObject = struct;

for index = 1:length(XCor) %nie ma znaczenia czy X czy Y
    curRow = XCor(index);
    curCol = YCor(index);
    charArray1 = '';
    charArray2 = '';
    matchCount = 0;
    gapCount = 0;
    traceLength = 0;
    
    while scoredMatrix(curRow, curCol) ~= 0
        matrixPath(curRow, curCol) = 1;
        curIndex = indexMatrix(curRow, curCol);
        traceLength = traceLength + 1;
        %curIndex - przej?cia
        %if 1 - match/mismatch
        %if 2 - gap up
        %if 3 - gap left
        %if 4 - 0
        
        %scoreIndex - punktacja
        
        if(curIndex == 1)
            charArray1 = strcat(charArray1, seq1(curRow-1));
            charArray2 = strcat(charArray2, seq2(curCol-1));
            if(seq1(curRow-1) == seq2(curCol-1))
                matchCount = matchCount + 1;
            end
            curRow = curRow - 1;
            curCol = curCol - 1;
        elseif(curIndex == 2)
            charArray1 = strcat(charArray1, seq1(curRow-1));
            charArray2 = strcat(charArray2, '_');
            gapCount = gapCount + 1;
            %gap up
            curRow = curRow - 1;
        else
            charArray1 = strcat(charArray1, '_');
            charArray2 = strcat(charArray2, seq2(curCol-1));
            gapCount = gapCount + 1;
            %gap left
            curCol = curCol - 1;
        end
    end
    
    charArray1 = strcat(charArray1, seq1(curRow));
    charArray2 = strcat(charArray2, seq2(curCol));
    
    sequenceObject(index).seq1 = flip(charArray1(1:end-1));
    sequenceObject(index).seq2 = flip(charArray2(1:end-1));
    sequenceObject(index).matchCount = matchCount;
    sequenceObject(index).gapCount = gapCount;
    sequenceObject(index).traceLength = traceLength;
end
end

