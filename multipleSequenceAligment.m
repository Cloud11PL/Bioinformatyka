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
        %jesli struktury do dopasowania istnieja
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
            %por�wnujemy czy finalCentral == usefulCentral(kt�r? b?dziemy
            %nadpisywac)
            while ~strcmp(usefulCentral,char(finalSequenceStruct.(char(existingSequencesFields(1)))))
                finalCentral = char(finalSequenceStruct.(char(existingSequencesFields(1))));
                %patrzymy czy jest gap w starym dopasowaniu
                if(numel(usefulCentral) >= c)
                    if(usefulCentral(c) == '_')
                        %sprawdzamy czy usefulCentral > finalCentral bo
                        %outofbound
                        if(numel(usefulCentral) <= numel(finalCentral))
                            %patrzymy czy jest gap w NOWYM dopasowaniu
                            if(finalCentral(c) == '_')
                                %nie r�b nic jest gap jest w obu dopasowaniach
                            else
                                %je?li w nowym dopasowaniu nie ma gapa
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
                        else
                            %finalCentral jest mniejsze of useful <-
                            %outofbound
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
                        %je?li finalna ma gapa, a w starym nie ma
                    elseif(finalCentral(c) == '_')
                        %dodaj gapy do dopasowywanej
                        if(c ~= 1)
                            lastSequence = char(strcat(lastSequence(1:c-1) + "_" + lastSequence(c:end)));
                            usefulCentral = char(strcat(usefulCentral(1:c-1) + "_" + usefulCentral(c:end)));
                        elseif(c == numel(lastSequence))
                            lastSequence = char(strcat(lastSequence + "_"));
                            usefulCentral = char(strcat(usefulCentral + "_"));
                        elseif(c == 1)
                            lastSequence = char(strcat("_" + lastSequence));
                            usefulCentral = char(strcat("_" + usefulCentral));
                        end
                        %dopisz gap do nowej sekwencji
                    elseif(numel(usefulCentral) < numel(finalCentral))
                        lastSequence = char(strcat(lastSequence + "_"));
                        usefulCentral = char(strcat(usefulCentral + "_"));
                        %dodac warunek
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

