function [Matrix] = charVect( ch1,ch2 )
ch1 = char(ch1);
ch2 = char(ch2);
m = length(ch1);
n = length(ch2);

Matrix = zeros(m,n);

for k = 1:m
    for p = 1:n
        if ch1(k) == ch2(p)
            Matrix(k,p) = 1; %szuka dzie sa takie same nukleotydy
        end
    end
end
end

