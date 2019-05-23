function [score] = compareMatrices(sequence1,sequence2,scoringMatrix)
%COMPAREMATRICES Summary of this function goes here
%   Detailed explanation goes here

matrix = zeros(length(sequence1)+1,length(sequence2)+1);

%Parse init matrix (gaps on 1 row and column)

for a = 1:length(sequence1)
    matrix(a+1,1) = findMatch(scoringMatrix,'-',sequence1(a))*a;
end

for b = 1:length(sequence2)
    matrix(1,b+1) = findMatch(scoringMatrix,'-',sequence2(b))*b;
end

%Score the rest

%Create Matrix path? <- total score + sequences in string

end

