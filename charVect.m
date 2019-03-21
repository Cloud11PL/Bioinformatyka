function [Matrix] = charVect( ch1,ch2 )
ch1 = char(ch1);                        %String -> char +1
ch2 = char(ch2);                        %String -> char +1
m = length(ch1);                        %m as ch1 length +1
n = length(ch2);                        %n as ch2 length +1

Matrix = zeros(m,n);                    %Prealocation +1

for k = 1:m
    for p = 1:n                         %For loop
        if ch1(k) == ch2(p)             %Checking condition +1
            Matrix(k,p) = 1;            %Setting matrix value +1
        end
    end
end
end

%T = 1 + 1 + 1 + 1 + 1 + m * n * (1 + 1) = 5 + m*n*(2)

