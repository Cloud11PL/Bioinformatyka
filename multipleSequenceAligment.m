function [finalSequenceStruct] = multipleSequenceAligment(usefulSequencesStruct,x,centralIdent)
%MULTIPLESEQUENCEALIGMENT Summary of this function goes here
%   Detailed explanation goes here
finalSequenceStruct = struct;

%je?li dopasowywany powoduje gapa w centralnym -> dodaj gap do wszystkich
%poza dopasowywanym
%je?li mismatch to nic
%je?li centralny pierwszy ma gap, dodaj gap do dopasowywanego

%loop przez ilosc dopasowan jakie b?d? robione
for i = 1:x
    backup = usefulSequencesStruct;
    %jesli nie ma nic w finalnej strukturze
    if (isempty(fieldnames(finalSequenceStruct)))
        finalSequenceStruct.(centralIdent) = usefulSequencesStruct.("s" + i).(centralIdent);
        usefulSequencesStruct.("s" + i) = rmfield(usefulSequencesStruct.("s" + i),centralIdent);
        lastField = char(fieldnames(usefulSequencesStruct.("s" + i)));
        finalSequenceStruct.(lastField) = usefulSequencesStruct.("s" + i).(lastField);
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
        end
    end
    usefulSequencesStruct = backup;
end
end

