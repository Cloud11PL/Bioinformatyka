function matrix = compareMatrices(matrix, matrixCompared, seq1Length, seq2Length)
    for k = 1:seq1Length
        for p = 1:seq2Length                        %For loop
               matrix(k+1,p+1) = matrixCompared(k,p);     %Checking condition +1
        end
    end
end