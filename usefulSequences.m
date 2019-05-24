function [usefulSequencesStruct] = usefulSequences(minIndex,alignedSequencesStruct,x)
%USEFULSEQUENCES Summary of this function goes here
usefulSequencesStruct = struct;

index = 1;
while index <= x
    if (~(index == minIndex))
        name = char("s"+index + "_" + minIndex)
        nameFliped = char("s"+ minIndex + "_" + index)
        
        if(isfield(alignedSequencesStruct,name))
            usefulSequencesStruct.("s"+index) = alignedSequencesStruct.(name)
        elseif(isfield(alignedSequencesStruct,nameFliped))
            usefulSequencesStruct.("s"+index) = alignedSequencesStruct.(nameFliped)
        end
        index = index + 1;
    else
        index = index + 1;
    end
end
end

