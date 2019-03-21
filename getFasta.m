function dataset = getFasta(method)
if method==1
    fasta=inputFasta();
elseif method==2
    filename= input('Enter file name: ', 's');
    fasta = fileFasta(filename);
elseif method==3
    URLIdentifier = input('Enter URL Indentifier: ','s');
    fasta = fetchFasta(URLIdentifier);
elseif method==4
    Facade('DMelanogaster.fasta','DSimulans.txt',10,2,'JF909299.1','NM_001109772.1',10,2,'ACTCTAACT','ATCTACAGT',4,1);
    return;
else
    disp('Incorrect method ');
    return;
end
    dataset = parseFasta(fasta);
end