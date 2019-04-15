function matrix = parseInitMatrix(matrix, gap, seq1Length, seq2Length)
    for a = 1:seq1Length
        matrix(a+1,1) = gap*a;
    end

    for b = 1:seq2Length
        matrix(1,b+1) = gap*b;
    end
end