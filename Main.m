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

alignedSequencesStruct = struct;

for i = 1:numberOfSequences
    index = numberOfSequences;
    
    while i < index
        %porownaj i daj score
        
        tempChar1 = char(sequenceCluster(i,1))
        tempChar2 = char(sequenceCluster(index,1))
        
        lenChar1 = length(tempChar1);
        lenChar2 = length(tempChar2);
        indexMatrix = zeros(lenChar1+1,lenChar2+1);
        
        matrix = createInitMatrix(scoringMatrix,tempChar1,tempChar2);
        
        %         zeros(lenChar1+1,lenChar2+1);
        %
        %         %Parse init matrix (gaps on 1 row and column)
        %
        %         for a = 1:length(tempChar1)
        %             matrix(a+1,1) = findMatch(scoringMatrix,'-',tempChar1(a))*a;
        %         end
        %
        %         for b = 1:length(tempChar2)
        %             matrix(1,b+1) = findMatch(scoringMatrix,'-',tempChar2(b))*b;
        %         end
        
        %Score the rest
        
        %zacznij w 1,1
        %sprawd? czy match/mismatch
        %sprawd? warto?ci góra/lewo
        %wybierz max + zapisz index
        
        %         for m = 2:(lenChar1+1)
        %             for n = 2:(lenChar2+1)
        %                 value1 = matrix(m-1,n-1) + findMatch(scoringMatrix,tempChar1(m-1),tempChar2(n-1));
        %                 value2 = matrix(m-1,n) + findMatch(scoringMatrix,tempChar1(m-1),'-'); %one up
        %                 value3 = matrix(m,n-1) + findMatch(scoringMatrix,tempChar2(n-1),'-'); %one left
        %                 [minValue,minIndex] = min([value1 value2 value3]);
        %                 matrix(m,n) = minValue;
        %                 %if 1 - match/mismatch
        %                 %if 2 - one up
        %                 %if 3 - one left
        %                 indexMatrix(m,n) = minIndex;
        %             end
        %         end
        
        [matrix,indexMatrix] = scoreMatrix(matrix,indexMatrix,tempChar1,tempChar2,scoringMatrix);
        
        %Create Matrix path? <- total score + sequences in string
        
        [score,seq1Array,seq2Array] = createMatrixPath(indexMatrix,scoringMatrix,tempChar1,tempChar2)
        
        %DO POPRAWY PRZY FINAL CODE
        %         toBeIncluded = zeros(4,1);
        %         toBeIncluded(1,1) = seq1Array;
        %         toBeIncluded(2,1) = char(sequenceCluster(i,2));
        %         toBeIncluded(3,1) = seq2Array;
        %         toBeIncluded(4,1) = char(sequenceCluster(index,2));
        
        %alignedSequencesStruct.("s"+i+"_"+index) = [seq1Array,char(sequenceCluster(i,2)),seq2Array,char(sequenceCluster(index,2))]
        name = char("s"+i+"_"+index)
        alignedSequencesStruct.(name) = struct(char(sequenceCluster(i,2)),{seq1Array},char(sequenceCluster(index,2)),{seq2Array});
        %alignedSequencesStruct.("s"+i+"_"+index) = toBeIncluded;
        
        %1 - seq1
        %2 - seq1.id
        %3 - seq2
        %4 - seq2.id
        
        disp(sequenceCluster(i,2) + " " + sequenceCluster(index,2))
        scoreCluster(i,index) = score;
        index = index - 1;
    end
end

scoreCluster = (scoreCluster + scoreCluster') - eye(size(scoreCluster,1)).*diag(scoreCluster);
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

%find min
%%
[minValue, minIndex] = min(scoreSums);
centralIdent = char(sequenceCluster(minIndex,2));

%%
%get the sequence
centralSequence = sequenceCluster(minIndex)

%loop through all sequences
%don't compare if
%   sequenceCluster index == minIndex

%get only sequences that we will actually use

usefulSequencesStruct = struct;

% for index = 1:x
%     if(~(index == minIndex))
%        %scoredCluster(index,minIndex)
%        name = char("s"+index + "_" + minIndex)
%        usefulSequencesStruct.("s"+index) = alignedSequencesStruct.(name)
%     end
% end

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

%%
%begin mergin sequences

%je?li dopasowywany powoduje gapa w centralnym -> dodaj gap do wszystkich
%poza dopasowywanym
%je?li mismatch to nic
%je?li centralny pierwszy ma gap, dodaj gap do dopasowywanego

finalSequenceStruct = struct;

%loop przez ilosc dopasowan jakie b?d? robione
for i = 1:x
    backup = usefulSequencesStruct;
    %jesli nie ma nic w finalnej strukturze
    if (isempty(fieldnames(finalSequenceStruct)))
        finalSequenceStruct.(centralIdent) = usefulSequencesStruct.("s" + i).(centralIdent);
        usefulSequencesStruct.("s" + i) = rmfield(usefulSequencesStruct.("s" + i),centralIdent);
        lastField = char(fieldnames(usefulSequencesStruct.("s" + i)));
        finalSequenceStruct.(lastField(1)) = usefulSequencesStruct.("s" + i).(lastField(1));
    else
        %je?li struktury do dopasowania istniej?
        if(isfield(usefulSequencesStruct,char("s"+i)))
            %Centralna sekwencja z danego dopasowania
            usefulCentral = usefulSequencesStruct.("s" + i).(centralIdent);
            
            %usun z dopasowan zeby uzyskac pozosa??
            usefulSequencesStruct.("s" + i) = rmfield(usefulSequencesStruct.("s" + i),centralIdent);
            
            %Pozosta?a nazwa field sekwencji z danego dopasowania
            lastField = char(fieldnames(usefulSequencesStruct.("s" + i))); %dopasowywana
            
            %pozosta?a sekwencja
            lastSequence = char(usefulSequencesStruct.("s" + i).(lastField));
            
            %Field names w finalnej strukturze
            existingSequencesFields = fieldnames(finalSequenceStruct);
            
            c = 1;
            currentCentral = char(finalSequenceStruct.(char(existingSequencesFields(1))));

            while numel(currentCentral) ~= numel(lastSequence)
                %for c = 1:numel(lastSequence)
                currentCentral = char(finalSequenceStruct.(char(existingSequencesFields(1))));
                %patrzymy czy jest gap w starym dopasowaniu
                if(numel(usefulCentral) >= c)
                    if(usefulCentral(c) == '_')
                        %patrzymy czy jest gap w NOWYM dopasowaniu
                        if(currentCentral(c) == '_')
                            %nie rób nic, po prostu dodaj
                        else
                            %nadpisz nowe dopasowanie + wszystkie
                            for n = 1:numel(existingSequencesFields)
                                currentSeq = char(finalSequenceStruct.(char(existingSequencesFields(n))));
                                currentField = char(existingSequencesFields(n));
                                
                                if(c ~= 1)
                                    currentSeq = char(strcat(currentSeq(1:c-1) + "_" + currentSeq(c:end)));
                                elseif(c == numel(currentSeq))
                                    currentSeq = char(strcat(currentSeq + "_"));
                                elseif(c == 1)
                                    currentSeq = char(strcat("_" + currentSeq));
                                end
                                finalSequenceStruct.(currentField) = currentSeq;
                            end
                        end
                    elseif(currentCentral(c) == '_')
                        if(c ~= 1)
                            lastSequence = char(strcat(lastSequence(1:c-1) + "_" + lastSequence(c:end)));
                        elseif(c == numel(lastSequence))
                            lastSequence = char(strcat(lastSequence + "_"));
                        elseif(c == 1)
                            lastSequence = char(strcat("_" + lastSequence));
                        end
                        %dopisz gap do nowej sekwencji
                    else
                        lastSequence = char(strcat(lastSequence + "_"));
                    end
                end
                c = c + 1;
            end
            finalSequenceStruct.(lastField) = lastSequence;
            
            %finalSequenceStruct.(char(existingSequencesFields(1))) = currentCentral;
            
            %             for h = 1:numel(currentCentral)
            %                 if(currentCentral(h) == '_')
            %                     if(numel(usefulCentral) >= h)
            %                         if(~(usefulCentral(h) == '_'))
            %                             if(h ~= 1)
            %                                 lastSequence = char(strcat(lastSequence(1:h-1) + "_" + lastSequence(h:end)));
            %                             elseif(h == numel(lastSequence))
            %                                 lastSequence = char(strcat(lastSequence + "_"));
            %                             elseif(h == 1)
            %                                 lastSequence = char(strcat("_" + lastSequence));
            %                             end
            %                         end
            %                     else
            %                        lastSequence = char(strcat(lastSequence + "_"));
            %                     end
            %                 end
            %             end
            %
            %             finalSequenceStruct.(lastField) = lastSequence;
            %
            %             %poza pierwsz?
            %             for n = 2:numel(existingSequencesFields)
            %                currentSeq = char(finalSequenceStruct.(char(existingSequencesFields(n))));
            %                currentField = char(existingSequencesFields(n));
            %
            %                %pomin te obecn? dodan?
            %                %pomi? je?li ju? jest gap
            %                if(~(currentField == lastField))
            %                    %rozteguj obecn? wzgl?dem centralnej
            %                    for m = 1:numel(currentSeq)
            %                        if(currentSeq(m) ~= '_' && currentCentral(m) == '_')
            %                             if(m ~= 1)
            %                                 currentSeq = char(strcat(currentSeq(1:m-1) + "_" + currentSeq(m:end)));
            %                             elseif(m == numel(currentSeq))
            %                                 currentSeq = char(strcat(currentSeq + "_"));
            %                             elseif(m == 1)
            %                                 currentSeq = char(strcat("_" + currentSeq));
            %                             end
            %                        end
            %                    end
            %                    finalSequenceStruct.(currentField) = currentSeq;
            %                end
            %
            %             end
            
            %             %loop przez wszystkie sekwencje w finalnej strukturze
            %             for n = 1:numel(existingSequencesFields)
            %                 %Obecna sekwencja
            %                 currentSeq = char(finalSequenceStruct.(char(existingSequencesFields(n))));
            %                 %field obecnej sekwencji
            %                 currentField = char(existingSequencesFields(n));
            %                 %Obecna centralna
            %                 currentCentral = char(finalSequenceStruct.(char(existingSequencesFields(1))));
            %
            %                 %loop przez znaki w pozosta?ej sekwencji (dopasowywanej)
            %                 for c = 1:numel(lastSequence)
            %                     %je?li dopasowywany powoduje gapa w centralnym -> dodaj gap do wszystkich
            %                     %poza dopasowywanym
            %                     if(lastSequence(c) ~= '_')
            %                         if(numel(usefulCentral) >= c)
            %                             if(usefulCentral(c) == '_')
            %                                 if(c ~= 1)
            %                                     %rozdziel array
            %                                     currentSeq = char(strcat(currentSeq(1:c) + "_" + currentSeq(c:end)));
            %                                 elseif(c == numel(currentSeq))
            %                                     currentSeq = char(strcat(currentSeq + "_"));
            %                                 else
            %                                     currentSeq = char(strcat("_" + currentSeq));
            %                                 end
            %                             end
            %                         end
            %                     else
            %                         %nomalnie zlacz
            %                     end
            %                 end
            %
            %                 %je?li centralny pierwszy ma gap, dodaj gap do dopasowywanego
            %                 %loop przez centralny wzgl?dem ostatniego
            %                 for h = 1:numel(currentCentral)
            %                     if(currentCentral(h) == '_')
            %                         if(h ~= 1)
            %                             lastSequence = char(strcat(lastSequence(1:h-1) + "_" + lastSequence(h:end)));
            %                         elseif(h == numel(lastSequence))
            %                             lastSequence = char(strcat(lastSequence + "_"));
            %                         else
            %                             lastSequence = char(strcat("_" + lastSequence));
            %                         end
            %                     else
            %                         %nomalnie zlacz
            %                     end
            %                 end
            %
            %                 finalSequenceStruct.(currentField) = currentSeq;
            %                 %currentSeq = char(finalSequenceStruct.(existingSequencesFields(n)));
            %                 finalSequenceStruct.(lastField) = lastSequence;
            
            
            %finalSequenceStruct.(lastField(1)) = usefulSequencesStruct.("s" + i).(lastField(1));
        end
    end
    usefulSequencesStruct = backup;
end











