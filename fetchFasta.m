function fastaContent=fetchFasta(identifier)
    URL = 'https://www.ncbi.nlm.nih.gov/entrez/eutils/efetch.fcgi'; %Variable assingment +1
    fastaContent = urlread(URL,'get',{'db','nucleotide','rettype','fasta','id',identifier});  %Variable assingment +1
end