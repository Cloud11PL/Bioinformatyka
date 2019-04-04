function matrix = scoreMatrix(matrix, match, mismatch, gap, m, n)
    for k = 1:m%wiersze
        for p = 1:n%%kolumny
            if(matrix(k+1,p+1) == 1)
               matrix(k+1,p+1) = matrix(k,p)+match;
            elseif(matrix(k+1,p+1) == 0)
                a = matrix(k,p+1); %w lewo GAP
                b = matrix(k+1,p); %do gory GAP
                c = matrix(k,p); %lewy skos MISMATCH
                if(a>=b && a>=c)
                    matrix(k+1,p+1) = matrix(k,p+1) + gap;
                elseif(c>=b && c>=a)
                    matrix(k+1,p+1) = matrix(k,p) + mismatch; 
                elseif(b>=c && b>=a)
                    matrix(k+1,p+1) = matrix(k+1,p) + gap;
                end
            end
        end
    end
end