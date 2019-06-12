function indexMatrix = scoreMatrix(matrix,indexMatrix,tempChar1,tempChar2,scoringMatrix)
%SCOREMATRIX Summary of this function goes here

for m = 2:(length(tempChar1)+1)
    for n = 2:(length(tempChar2)+1)
        value1 = matrix(m-1,n-1) + findMatch(scoringMatrix,tempChar1(m-1),tempChar2(n-1));
        value2 = matrix(m-1,n) + findMatch(scoringMatrix,tempChar1(m-1),'-'); %one up
        value3 = matrix(m,n-1) + findMatch(scoringMatrix,tempChar2(n-1),'-'); %one left
        [minValue,minIndex] = min([value1 value2 value3]);
        matrix(m,n) = minValue;
        %if 1 - match/mismatch
        %if 2 - one up
        %if 3 - one left
        indexMatrix(m,n) = minIndex;
    end
end
end

