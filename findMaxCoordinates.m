function [XCor,YCor] = findMaxCoordinates(scoredMatrix)
%Finds coordinates of the max value and stores it in two separate matrices.

maxValue = max(scoredMatrix(:));

XCorLength = length(scoredMatrix(:,1)); %substitution +1
YCorLength = length(scoredMatrix(1,:)); %substitution +1

XCor = []; %substitution +1
YCor = []; %substitution +1

%find occurances of the max value
for m = 1:XCorLength %incrementation, checking condition, n*x; 2 + n*x
    for n = 1:YCorLength %incrementation, checking condition, m*x; 2 + m*x
        if scoredMatrix(m,n) == maxValue %checking condition +1
            XCor(end+1) = m; %substitution +1
            YCor(end+1) = n; %substitution +1
        end
    end
end

end

