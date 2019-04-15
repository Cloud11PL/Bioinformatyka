function [outputSeq] = smithWaterman(gap,seq1,seq2)
%SMITHWATERMAN Summary of this function goes here
%   Detailed explanation goes here

% # A C G T
% A 2 -7 -5 -7
% C -7 2 -7 -5
% G -5 -7 2 -7
% T -7 -5 -7 2

%1. for po macierzy
% [ x = if match
% [ y = else if mismatch
% [ z1 = if gap1
% [ z2 = if gap2
% max[x,y,z1,z2] lub 0!!! nie moze byc mniejsze niz 0


%nucleotydeArray = ['A','C','G','T'];
% seq1 = ['A','C','T','G'];
% seq2 = ['A','C','C','G'];

length1 = length(seq1)
length2 = length(seq2)
zeros(length1,length2)
outputSeq = zeros(length1,length2);
scoreMatrix = getScoringMatrix('subMatrix.txt');

% vecRow = scoreMatrix(1,:);
% vecCol = scoreMatrix(:,1);

%seq1 idzie w dol
%seq2 idzie w prawo

for m = 2:length(seq1) %po
    for n = 2:length(seq2)
        
        if (seq1(m) == seq2(n)) %if match, w sumie chyba opcjonalny...
            value = findMatch(scoreMatrix,seq1(m),seq2(n)) + outputSeq(m-1,n-1); %zwraca punkt z txt
        else %is mismatch
            value = findMatch(scoreMatrix,seq1(m),seq2(n));
        end
        
        ins = findMatch(scoreMatrix,seq1(m-1),seq2(n)) + gap;
        del = findMatch(scoreMatrix,seq1(m),seq2(n-1)) + gap;
        
        maxVal = max([ins del value 0])
        
        if (maxVal <= 0)
            outputSeq(m,n) = 0;
        else
            outputSeq(m,n) = max([ins del value]);
        end
        
    end
end
end
