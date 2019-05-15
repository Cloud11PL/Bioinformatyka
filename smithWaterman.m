function [outputSeq,indexMatrix] = smithWaterman(gap,seq1,seq2)
%SMITHWATERMAN Summary of this function goes here
% The output of the function is a scored matrix.
seq1 = strcat('-',seq1);
seq2 = strcat('-',seq2);

length1 = length(seq1) %substitution +1
length2 = length(seq2) %substitution +1

outputSeq = zeros(length1,length2); %substitution +1
indexMatrix = zeros(length1,length2); %substitution +1

substitutionMatrix = getScoringMatrix('subMatrix.txt'); %substitution +1

for m = 2:length(seq1) %incrementation, checking condition, n*x; 2 + n*x
    for n = 2:length(seq2) %incrementation, checking condition, m*x; 2 + m*x
        if (seq1(m) == seq2(n)) %checking condition +1
            value = findMatch(substitutionMatrix,seq1(m),seq2(n)) + outputSeq(m-1,n-1); %zwraca punkt z txt; substitution +1
        else %is mismatch
            value = findMatch(substitutionMatrix,seq1(m),seq2(n)) + outputSeq(m-1,n-1); %substitution +1
        end
        
        %outputSeq(m-1,n-1) zamiast find match
        ins = outputSeq(m,n-1) - gap; %substitution +1
        del = outputSeq(m-1,n) - gap; %substitution +1
        
        [maxVal,index] = max([value ins del 0]); %substitution +2 ?
        outputSeq(m,n) = maxVal; %substitution +1
        indexMatrix(m,n) = index; %substitution +1        
        %if 1 - match/mismatch
        %if 2 - gap up
        %if 3 - gap left
        %if 4 - 0
    end
end
end
