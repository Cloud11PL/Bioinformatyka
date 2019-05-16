function [outputSeq,indexMatrix] = smithWaterman(gap,seq1,seq2)
%SMITHWATERMAN Summary of this function goes here
% The function takes provided by the user gap value and two sequences.
% It calculares the local, linear gap cost according to the Smith-Waterman
% algorithm. It loops through both sequences. First, it checks if the two
% current nucleotides are the same. If so, 'findMatch' function is called.
% It returns score from provided .txt file. The score is added to the
% diagonal value. If not, the same task is performed - room for future
% improvement. Next, two gap costs are calculated. Lastly, the max value out
% of an array of previously mentioned 3 values and '0' is calculated. It is
% added to the output matrix at current coordinates. Index of the max value
% is added to simplify traceback - we can see from where a certain value 'came' from. 
% 
seq1 = strcat('-',seq1);
seq2 = strcat('-',seq2);

length1 = length(seq1) 
length2 = length(seq2) 

outputSeq = zeros(length1,length2); 
indexMatrix = zeros(length1,length2); 

substitutionMatrix = getScoringMatrix('subMatrix.txt'); 

for m = 2:length(seq1)
    for n = 2:length(seq2)
        if (seq1(m) == seq2(n))
            value = findMatch(substitutionMatrix,seq1(m),seq2(n)) + outputSeq(m-1,n-1); %zwraca punkt z txt; substitution +1
        else %is mismatch
            value = findMatch(substitutionMatrix,seq1(m),seq2(n)) + outputSeq(m-1,n-1); 
        end
        
        % Mój ca?y problem z tym programem wynika? z tych dwóch linijek.
        % Pomyli?em kolejno?? column z row i odkrycie tego zaj??o mi dobre 
        % kilka godzin :(
        value2 = outputSeq(m-1,n) + gap; 
        value3 = outputSeq(m,n-1) + gap; 
        
        [maxVal,index] = max([value value2 value3 0]);
        outputSeq(m,n) = maxVal; 
        indexMatrix(m,n) = index;         
    end
end
end
