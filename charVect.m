function [Matrix] = charVect( ch1,ch2 )


ch1 = char(ch1);
ch2 = char(ch2);

% ch1 = ch1(~isspace(ch1));
% ch2 = ch2(~isspace(ch2));

m = length(ch1);
n = length(ch2);

Matrix = zeros(m,n);

for k = 1:m    
    for p = 1:n
        if ch1(k) == ch2(p)
            Matrix(k,p) = 1;
        end
    end
end
end

