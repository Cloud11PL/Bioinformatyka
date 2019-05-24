clear all;
clc;

% sequenceCluster = [
%     "GCACAT", "a";
%     "TGAGA", "b";
%     "GACA", "c";
%     "GAACT","d"];

%Niestety pomimo faktu g??bokich stara? i wielu wielu godzinach pracy na
%tym zadaniem, nie wiem dlaczego, nie dzia?a on poprawnie dla du?ych
%sekwencji. Najprawdopodobniej mam problem w algorytmie, którego nie
%potrafi? zlokalizowa?.

disp('Choose the method.');
disp('1. From file');
disp('2. From database');

more = true;
sequenceCluster = struct;
i = 1;
while more
    method = input('Your choice (type 0 to finish):');
    if (method == 0)
        more = false;
    else
        seq = getFasta(method);
        sequenceCluster.("sequence_" + i) = [seq.sequence];
        %Tylko dlatego, bo struct nie lubi nic innego niz literki i cyferki
        id = strrep(strrep(strrep(strrep(seq.id,'.',''),' ',''),'-',''),'/','');
        id = id(1:end-15);
        sequenceCluster.("id_" + i) = id;
        i = i + 1;  
    end
end




%%



numberOfSequences = numel(fieldnames(sequenceCluster))/2;
possibleCombinations = numberOfSequences*(0.5*(numberOfSequences+1));
scoringMatrix = getScoringMatrix('subMatrix.txt');
%%
[scoreCluster, alignedSequencesStruct] = alignSequences(numberOfSequences, sequenceCluster,scoringMatrix);
%%
%zsumuj po row
[x,y] = size(scoreCluster)

scoreSums = zeros(1,x);
for i = 1:x
    currentSum = 0;
    for j = 1:y
        currentSum = currentSum + scoreCluster(i,j);
    end
    scoreSums(i) = currentSum;
end
%%

[minValue, minIndex] = min(scoreSums);
centralIdent = char(sequenceCluster.("id_" + minIndex));
%%
centralSequence = sequenceCluster.("id_" + minIndex);

usefulSequencesStruct = usefulSequences(minIndex, alignedSequencesStruct,x);
%%
finalSequenceStruct = multipleSequenceAligment(usefulSequencesStruct,x,centralIdent);

% Próba policzenia kosztu dopasowania ka?dej kolumny
% finalScore = getFinalScore(finalSequenceStruct,scoringMatrix);
% %%
% alignedSequences = char(struct2cell(finalSequenceStruct));
% 
% [down,right] = size(alignedSequences)
% 
% finalScore = 0;
% %i - po fieldsach
% for i = 1:down
%     index = right;
%     rowScore = 0;
%     smallIndex = 1;    
%     for j = i:down
%         while smallIndex < right
%             curScore = findMatch(scoringMatrix,alignedSequences(smallIndex,j),alignedSequences(smallIndex,))
%             smallIndex = smallIndex + 1;
%             rowScore = curScore + rowScore
%         end
%     end
% end
% 











