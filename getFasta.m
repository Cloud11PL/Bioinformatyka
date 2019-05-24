function dataset = getFasta(method)
if method==1                %Condition +1
    filename= input('Enter file name: ', 's');  %Variable assignment +1
    fasta = fileFasta(filename);                %Variable assignment +1
elseif method==2            %Condition +1
    URLIdentifier = input('Enter URL Indentifier: ','s'); %Variable assignment +1
    fasta = fetchFasta(URLIdentifier);                    %Variable assignment +1
elseif method==0            %Condition +1
    return;
else
    disp('Incorrect method ');
    return;
end
    dataset = parseFasta(fasta);
end