function fastaContent=fetchFasta(identifier)
URL='https://www.ncbi.nlm.nih.gov/entrez/eutils/efetch.fcgi';
fastaContent=urlread(URL,'get',{'db','nucleotide','rettype','fasta','id',identifier});
end