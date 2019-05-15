function [matrixPath,sequenceObject,matchCount,gapCount] = findPath(scoredMatrix,indexMatrix,XCor,YCor,seq1,seq2)
%FINDPATH Summary of this function goes here

matrixPath = zeros(length(scoredMatrix(:,1)),length(scoredMatrix(1,:))); %substitution +1
index = 1; %substitution +1
sequenceObject = struct;
while index <= length(XCor) %nie ma znaczenia czy X czy Y
    curRow = XCor(index); %substitution +1
    curCol = YCor(index); %substitution +1
    curIndex = indexMatrix(curRow, curCol); %substitution +1
    scoreIndex = scoredMatrix(curRow, curCol);
    charArray1 = ''; %substitution +1
    charArray2 = ''; %substitution +1
    matchCount = 0;
    gapCount = 0;
%    while (curIndex ~= 4) && (curIndex ~= 0) && (scoreIndex ~= 0)

    while scoreIndex > 0
        matrixPath(curRow, curCol) = 1; %substitution +1
        curIndex = indexMatrix(curRow, curCol); %substitution +1
        scoreIndex = scoredMatrix(curRow, curCol);
        
        %curIndex - przej?cia
        %if 1 - match/mismatch
        %if 2 - gap up
        %if 3 - gap left
        %if 4 - 0
        
        %scoreIndex - punktacja
        
        if(curIndex == 1) %checking condition + 1
            charArray1 = strcat(charArray1, seq1(curRow-1)); %substitution +1
            charArray2 = strcat(charArray2, seq2(curCol-1)); %substitution +1
            if(seq1(curRow-1) == seq2(curCol-1))
                matchCount = matchCount + 1;
            end
            curRow = curRow - 1; %substitution +1
            curCol = curCol - 1; %substitution +1
        elseif(curIndex == 2) %checking condition
            charArray1 = strcat(charArray1, seq1(curRow-1)); %substitution +1
            charArray2 = strcat(charArray2, '_'); %substitution +1
            gapCount = gapCount + 1;
            %gap up
            curRow = curRow - 1; %substitution +1
        elseif(curIndex == 3) %checking condition +1
            charArray1 = strcat(charArray1, '_'); %substitution +1
            charArray2 = strcat(charArray2, seq2(curCol-1)); %substitution +1
            gapCount = gapCount + 1;
            %gap left
            curCol = curCol - 1; %substitution +1
        end
    end
    index = index + 1; %substitution +1
    
    charArray1 = strcat(charArray1, seq1(curRow)); %substitution +1
    charArray2 = strcat(charArray2, seq2(curCol)); %substitution +1
    
    sequenceObject(index-1).seq1 = flip(charArray1(1:end-1)); %substitution +1
    sequenceObject(index-1).seq2 = flip(charArray2(1:end-1)); %substitution +1
    sequenceObject(index-1).matchCount = matchCount;
    sequenceObject(index-1).gapCount = gapCount;    
end
end

