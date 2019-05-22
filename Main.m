sequence1 = "ACGTCGTACGTCACGTCTACGATCGACTGACGT";
sequence2 = "ACCTCCTACGTCAGTCAACGATCGACGACCT";
sequence3 = "ACGACGTACGTGACGTCTACGTCGACTGACCGT";

% 1
% 2
% 3
% 4
% 
% 
% 1xn
% 1xn-1
% 1xn-2
% 2xn
% 2xn-1
% 3xn



% SEQUENCE | IDENTYFIKATOR

sequenceCluster = [
    "ACGTCGTACGTCACGTCTACGATCGACTGACGT", "a"; 
    "ACCTCCTACGTCAGTCAACGATCGACGACCT", "b"; 
    "ACCTCCTACGTCAGTCAACGATCGACGACCT", "c";
    "ACGACGTACGTGACGTCTACGTCGACTGACCGT","d"]

numberOfSequences = length(sequenceCluster)
possibleCombinations = numberOfSequences*(0.5*(numberOfSequences+1))

scoreCluster = zeros(numberOfSequences)

for i = 1:numberOfSequences
    index = numberOfSequences;

    while i < index
        %porownaj i daj score
        compareMatrices(sequenceCluser(i,1),sequenceCluster(index,1));
        
        
        disp(sequenceCluster(i,2) + " " + sequenceCluster(index,2))
        index = index - 1;
    end
end









