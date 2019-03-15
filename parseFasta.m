function [identifier,sequence]=parseFasta(fastaContent)
sequence="";
fastaFile=splitlines(fastaContent);
identifier=fastaFile(1);
for i=2:length(fastaFile)
    sequence=sequence+fastaFile(i);
end