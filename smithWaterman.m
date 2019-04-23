function [outputSeq,indexMatrix] = smithWaterman(gap,seq1,seq2)
%SMITHWATERMAN Summary of this function goes here
% The output of the function is a scored matrix.

length1 = length(seq1)
length2 = length(seq2)

outputSeq = zeros(length1,length2);
indexMatrix = zeros(length1,length2);
substitutionMatrix = getScoringMatrix('subMatrix.txt');

for m = 2:1:length(seq1)
    for n = 2:1:length(seq2)
        
        if (seq1(m) == seq2(n)) %if match, w sumie chyba opcjonalny...
            value = findMatch(substitutionMatrix,seq1(m),seq2(n)) + outputSeq(m-1,n-1); %zwraca punkt z txt
        else %is mismatch
            value = findMatch(substitutionMatrix,seq1(m),seq2(n)) + outputSeq(m-1,n-1);
        end
        
        ins = findMatch(substitutionMatrix,seq1(m),seq2(n-1)) + gap; %insercja
        del = findMatch(substitutionMatrix,seq1(m-1),seq2(n)) + gap; %delecja
        
        [maxVal,index] = max([value ins del 0]);
        outputSeq(m,n) = maxVal;
        %if 1 - match/mismatch
        %if 2 - gap up
        %if 3 - gap left
        %if 4 - 0
        indexMatrix(m,n) = index; 
        
    end
end
end