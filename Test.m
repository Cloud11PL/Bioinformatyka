clear all;
clc;

sequenceCluster = struct;

fasta1 = parseFasta(fetchFasta("KC011822.1"));
fasta2 = parseFasta(fetchFasta("KC011821.1"));
fasta3 = parseFasta(fetchFasta("KC011820.1"));
pause(1) %Baza danych chyba odrzuca polaczenia, je?li jest ich za duzo, stad pause
fasta4 = parseFasta(fetchFasta("KC011843.1"));

fastas = [fasta1, fasta2, fasta3, fasta4];

for y = 1:4
    sequenceCluster.("sequence_" + y) = fastas(y).sequence;
    %Tylko dlatego, bo struct nie lubi nic innego niz literki i cyferki
    id = strrep(strrep(strrep(strrep(fastas(y).id,'.',''),' ',''),'-',''),'/','');
    id = id(10:30);
    sequenceCluster.("id_" + y) = id;
end

%%
numberOfSequences = numel(fieldnames(sequenceCluster))/2;
possibleCombinations = numberOfSequences*(0.5*(numberOfSequences+1));
scoringMatrix = getScoringMatrix('subMatrix.txt');

[scoreCluster, alignedSequencesStruct] = alignSequences(numberOfSequences, sequenceCluster,scoringMatrix);

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
finalSequenceStruct = multipleSequenceAligment(usefulSequencesStruct,x,centralIdent);

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