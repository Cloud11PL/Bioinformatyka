clear all;
clc;

sequence1 = "ACGTCGTACGTCACGTCTACGATCGACTGACGT";
sequence2 = "ACCTCCTACGTCAGTCAACGATCGACGACCT";
sequence3 = "ACGACGTACGTGACGTCTACGTCGACTGACCGT";

% SEQUENCE | IDENTYFIKATOR
% 
% sequenceCluster = [
%     "ACGTCGTACGTCACGTCTACGATCGACTGACGT", "a";
%     "ACCTCCTACGTCAGTCAACGATCGACGACCTAA", "b";
%     "ACCTCCTACGTCAGTCAACGATCGACGACCT", "c";
%     "ACGACGTACGTGACGTCTACGTCGACTGACCGT","d"];

sequenceCluster = [
    "GCACAT", "a";
    "TGAGA", "b";
    "GACA", "c";
    "GAACT","d"];

numberOfSequences = length(sequenceCluster);
possibleCombinations = numberOfSequences*(0.5*(numberOfSequences+1));
scoringMatrix = getScoringMatrix('subMatrix.txt');

scoreCluster = zeros(numberOfSequences);

for i = 1:numberOfSequences
    index = numberOfSequences;
    
    while i < index
        %porownaj i daj score

        tempChar1 = char(sequenceCluster(i,1))
        tempChar2 = char(sequenceCluster(index,1))
        
        lenChar1 = length(tempChar1);
        lenChar2 = length(tempChar2);
        
        matrix = zeros(lenChar1+1,lenChar2+1);
        indexMatrix = zeros(lenChar1+1,lenChar2+1);
        
        %Parse init matrix (gaps on 1 row and column)
        
        for a = 1:length(tempChar1)
            matrix(a+1,1) = findMatch(scoringMatrix,'-',tempChar1(a))*a;
        end
        
        for b = 1:length(tempChar2)
            matrix(1,b+1) = findMatch(scoringMatrix,'-',tempChar2(b))*b;
        end
        
        %Score the rest
        
        %zacznij w 1,1
        %sprawd? czy match/mismatch
        %sprawd? warto?ci góra/lewo
        %wybierz max + zapisz index
        
        for m = 2:(lenChar1+1)
            for n = 2:(lenChar2+1)
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
        
        %Create Matrix path? <- total score + sequences in string
        
        [score,seq1Array,seq2Array] = createMatrixPath(indexMatrix,scoringMatrix,tempChar1,tempChar2)
        
        disp(sequenceCluster(i,2) + " " + sequenceCluster(index,2))
        scoreCluster(i,index) = score;
        index = index - 1;
    end
end

scoreCluster = (scoreCluster + scoreCluster') - eye(size(scoreCluster,1)).*diag(scoreCluster);

%zsumuj po row









