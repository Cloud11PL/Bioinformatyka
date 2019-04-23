function matrix = scoreMatrix(matrix, match, mismatch, gap, m, n)
    for k = 1:m%wiersze
        for p = 1:n%%kolumny
            if (matrix(k+1,p+1) == 1)
               val1 = matrix(k,p) + match;
            else
               val1 = matrix(k,p) + mismatch;               
            end
                valGap1 = matrix(k,p+1) + gap; %one up
                valGap2 = matrix(k+1,p) + gap; %one left
               % matrix(k+1,p+1) = matrix(k,p+1) + gap;
               % matrix(k+1,p+1) = matrix(k+1,p) + gap;
                maxValue = max([val1 valGap1 valGap2]);
                %poprawiony algorytm
                matrix(k+1,p+1) = maxValue;
        end
    end
end