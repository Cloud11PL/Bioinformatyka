function [outputSeq] = smithWaterman(gap,seq1,seq2)
%SMITHWATERMAN Summary of this function goes here
%   Detailed explanation goes here

% # A C G T
% A 2 -7 -5 -7
% C -7 2 -7 -5
% G -5 -7 2 -7
% T -7 -5 -7 2

%1. for po macierzy
% [ x = if match 
% [ y = else if mismatch
% [ z1 = if gap1
% [ z2 = if gap2
% max[x,y,z1,z2] lub 0!!! nie moze byc mniejsze niz 0


%nucleotydeArray = ['A','C','G','T'];
outputSeq = zeros(length(seq1)+1,length(seq2)+1);
scoreMatrix = getScoringMatrix('subMatrix.txt');

for n = 1:length(seq1)
    for m = 1:length(seq2)
        if (seq1(n) == seq2(m)) %if match
           value = findMatch(scoreMatrix,seq1(n),seq2(m)) + findMatch(scoreMatrix,seq1(n+1),seq2(m+1));
           %outputSeq(n+1,m+1) = value
        else %is mismatch
           value = findMatch(scoreMatrix,seq1(n),seq2(m));
           %outputSeq(n+1,m+1) = value
        end

        ins = outputSeq(n+1,m) + gap;
        del = outputSeq(n,m+1) + gap;
        
        maxVal = max([ins del value 0])
        
        if (maxVal <= 0)
            outputSeq(n+1,m+1) = 0;
        else
            outputSeq(n+1,m+1) = max([ins del value]);
        end
%         
%         
%         
%         %1 w góre
%         gap1 = seq1(n-1);
%         
%         %2 w lewo
%         gap2 = seq2(m-2);
%         
%         maxVal = max([0,gap1,gap2,val]);

    end
end
end
% 
% for k = 1:m%wiersze
%     for p = 1:n%%kolumny
%         if(matrix(k+1,p+1) == 1)
%            matrix(k+1,p+1) = matrix(k,p)+match;
%         elseif(matrix(k+1,p+1) == 0)
%             a = matrix(k,p+1);
%             b = matrix(k+1,p);
%             c = matrix(k,p);
%             if(a>=b && a>=c)
%                 matrix(k+1,p+1) = matrix(k,p+1) + gap;
%             elseif(c>=b && c>=a)
%                 matrix(k+1,p+1) = matrix(k,p) + mismatch; 
%             elseif(b>=c && b>=a)
%                 matrix(k+1,p+1) = matrix(k+1,p) + gap;
%             end
%         end
%     end
% end

