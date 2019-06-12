function [scoreCluster,alignedSequencesStruct] = alignSequences(numberOfSequences,sequenceCluster,scoringMatrix)
%ALIGNSEQUENCES Summary of this function goes here
alignedSequencesStruct = struct;
scoreCluster = zeros(numberOfSequences);

for i = 1:numberOfSequences
    index = numberOfSequences;
    
    while i < index
        %porownaj i daj score
        
        tempChar1 = char(sequenceCluster.(char("sequence_" + i)));
        tempChar2 = char(sequenceCluster.(char("sequence_" + index)));
        
        lenChar1 = length(tempChar1);
        lenChar2 = length(tempChar2);
        indexMatrix = zeros(lenChar1+1,lenChar2+1);
        name = char("s"+i+"_"+index)
        matrix = createInitMatrix(scoringMatrix,tempChar1,tempChar2);
                
        indexMatrix = scoreMatrix(matrix,indexMatrix,tempChar1,tempChar2,scoringMatrix);
               
        [score,seq1Array,seq2Array] = createMatrixPath(indexMatrix,scoringMatrix,tempChar1,tempChar2)
        
        alignedSequencesStruct.(name) = struct(char(sequenceCluster.(char("id_" + i))),{seq1Array},char(sequenceCluster.(char("id_" + index))),{seq2Array});
        
        scoreCluster(i,index) = score;
        index = index - 1;
    end
end

scoreCluster = (scoreCluster + scoreCluster') - eye(size(scoreCluster,1)).*diag(scoreCluster);
end

