clear all;
clc;

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
        %id = strrep(strrep(strrep(strrep(seq.id,'.',''),' ',''),'-',''),'/','');
        %id = id(14:30);
        sequenceCluster.("id_" + i) = regexprep(seq.id,'\s+','');
        i = i + 1;  
    end
end
%%
numberOfSequences = numel(fieldnames(sequenceCluster))/2;
possibleCombinations = numberOfSequences*(0.5*(numberOfSequences+1));
scoringMatrix = getScoringMatrix('subMatrix.txt');

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

[minValue, minIndex] = min(scoreSums);
centralIdent = char(sequenceCluster.("id_" + minIndex));
centralSequence = sequenceCluster.("id_" + minIndex);
usefulSequencesStruct = usefulSequences(minIndex, alignedSequencesStruct,x);
%%
finalSequenceStruct = multipleSequenceAligment(usefulSequencesStruct,x,centralIdent);
%%
fields = fieldnames(finalSequenceStruct)
len = numel(char(finalSequenceStruct.(char(fields(1)))))
breaks = ceil(len/60)


structForFasta = struct;
for x = 1:numel(fields)
    structForFasta(x).Header = char(fields(x))
    structForFasta(x).Sequence = finalSequenceStruct.(char(fields(x)))
end

fastawrite('yeet.txt',structForFasta)

for i = 1:breaks
    fprintf('\n')
    const = 59;
    
    if(i == breaks)
        for f = 1:numel(fields)
            fprintf('\n')
            fprintf('%s\t\t', char(fields(f)))
            fprintf('%c',finalSequenceStruct.(char(fields(f)))(const*i-const+1:end))
            %Drukowanie przedzialu
            fprintf('\t\t%s', const*i-const+1 + " - " + len)
        end
        fprintf('\n')
        fprintf('\t\t\t\t\t\t')
        currentNucleotides = [];
        for j = const*i-const+1:len
            for x = 1:numel(fields)
                currentNucleotides = [currentNucleotides, finalSequenceStruct.(char(fields(x)))(j)];
            end
            if(all(currentNucleotides == currentNucleotides(1)) && currentNucleotides(1) ~= '_')
                fprintf('%c','*')
            else
                fprintf('%c',' ')
            end
            currentNucleotides = [];
        end
    else
        for f = 1:numel(fields)
            fprintf('\n')
            fprintf('%s\t\t', char(fields(f)))
            fprintf('%c',finalSequenceStruct.(char(fields(f)))(const*i-const+1:const*i))
            fprintf('\t\t%s', const*i-const+1 + " - " + const*i)
        end
        fprintf('\n')
        fprintf('\t\t\t\t\t\t')
        currentNucleotides = [];
        for j = const*i-const+1:const*i
            for x = 1:numel(fields)
                currentNucleotides = [currentNucleotides, finalSequenceStruct.(char(fields(x)))(j)];
            end
            fprintf('%s        ')
            if(all(currentNucleotides == currentNucleotides(1)))
                fprintf('%c','*')
            else
                fprintf('%c',' ')
            end
            currentNucleotides = [];
        end
    end

    fprintf('\n')
end