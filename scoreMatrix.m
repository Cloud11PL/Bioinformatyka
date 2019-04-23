function [scoredMatrix, indexMatrix] = scoreMatrix(scoredMatrix, match, mismatch, gap, m, n)
    indexMatrix = zeors(scoredMatrix);
    for k = 1:m%wiersze
        for p = 1:n%%kolumny
            if (scoredMatrix(k+1,p+1) == 1)
               val1 = scoredMatrix(k,p) + match;
            else
               val1 = scoredMatrix(k,p) + mismatch;               
            end
                valGap1 = scoredMatrix(k,p+1) + gap; %one up
                valGap2 = scoredMatrix(k+1,p) + gap; %one left
               % matrix(k+1,p+1) = matrix(k,p+1) + gap;
               % matrix(k+1,p+1) = matrix(k+1,p) + gap;
                [maxValue,index] = max([val1 valGap1 valGap2]);
                %poprawiony algorytm
                scoredMatrix(k+1,p+1) = maxValue;
                %if 1 - match/mismatch
                %if 2 - gap up
                %if 3 - gap left
                indexMatrix(k+1,p+1) = index; 
        end
    end
end