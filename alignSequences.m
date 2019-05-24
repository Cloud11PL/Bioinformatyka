function [scoreCluster,alignedSequencesStruct] = alignSequences(numberOfSequences,sequenceCluster,scoringMatrix)
%ALIGNSEQUENCES Summary of this function goes here
%   Detailed explanation goes here
alignedSequencesStruct = struct;

for i = 1:numberOfSequences
    index = numberOfSequences;
    
    while i < index
        %porownaj i daj score
        
        tempChar1 = char(sequenceCluster.(char("sequence_" + i)));
        tempChar2 = char(sequenceCluster.(char("sequence_" + index)));
        
        lenChar1 = length(tempChar1);
        lenChar2 = length(tempChar2);
        indexMatrix = zeros(lenChar1+1,lenChar2+1);
        
        matrix = createInitMatrix(scoringMatrix,tempChar1,tempChar2);
                
        [matrix,indexMatrix] = scoreMatrix(matrix,indexMatrix,tempChar1,tempChar2,scoringMatrix);
               
        [score,seq1Array,seq2Array] = createMatrixPath(indexMatrix,scoringMatrix,tempChar1,tempChar2)
        
        %DO POPRAWY PRZY FINAL CODE
        %         toBeIncluded = zeros(4,1);
        %         toBeIncluded(1,1) = seq1Array;
        %         toBeIncluded(2,1) = char(sequenceCluster(i,2));
        %         toBeIncluded(3,1) = seq2Array;
        %         toBeIncluded(4,1) = char(sequenceCluster(index,2));
        
        %alignedSequencesStruct.("s"+i+"_"+index) = [seq1Array,char(sequenceCluster(i,2)),seq2Array,char(sequenceCluster(index,2))]
        name = char("s"+i+"_"+index)
        alignedSequencesStruct.(name) = struct(char(sequenceCluster.(char("id_" + i))),{seq1Array},char(sequenceCluster.(char("id_" + index))),{seq2Array});
        
        scoreCluster(i,index) = score;
        index = index - 1;
    end
end

scoreCluster = (scoreCluster + scoreCluster') - eye(size(scoreCluster,1)).*diag(scoreCluster);
end

