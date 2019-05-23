function [matrix] = createInitMatrix(scoringMatrix,tempChar1,tempChar2)
%CREATEINITMATRIX Summary of this function goes here

matrix = zeros(length(tempChar1)+1,length(tempChar2)+1);

for a = 1:length(tempChar1)
    matrix(a+1,1) = findMatch(scoringMatrix,'-',tempChar1(a))*a;
end

for b = 1:length(tempChar2)
    matrix(1,b+1) = findMatch(scoringMatrix,'-',tempChar2(b))*b;
end

end

