function dataset = getFasta(method)
if method==1                %Condition +1
    fasta=inputFasta();     %Variable assignment +1
elseif method==2            %Condition +1
    filename= input('Enter file name: ', 's');  %Variable assignment +1
    fasta = fileFasta(filename);                %Variable assignment +1
elseif method==3            %Condition +1
    URLIdentifier = input('Enter URL Indentifier: ','s'); %Variable assignment +1
    fasta = fetchFasta(URLIdentifier);                    %Variable assignment +1
else
    disp('Incorrect method ');
    return;
end
    dataset = parseFasta(fasta);
end