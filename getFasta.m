function dataset = getFasta(method)
if method==1                %Condition +1
    fasta=inputFasta();     %Variable assignment +1
elseif method==2            %Condition +1
    filename= input('Enter file name: ', 's');  %Variable assignment +1
    fasta = fileFasta(filename);                %Variable assignment +1
elseif method==3            %Condition +1
    URLIdentifier = input('Enter URL Indentifier: ','s'); %Variable assignment +1
    fasta = fetchFasta(URLIdentifier);                    %Variable assignment +1
elseif method==4            %Condition +1
    Facade('DMelanogaster.fasta','DSimulans.fasta',10,2,'JF909299.1','NM_001109772.1',10,2,'ACTCTAACT','ATCTACAGT',4,1); 
    return;
else
    disp('Incorrect method ');
    return;
end
    dataset = parseFasta(fasta);
end