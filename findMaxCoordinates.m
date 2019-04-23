function [XCor,YCor] = findMaxCoordinates(scoredMatrix,maxValue)
%Finds coordinates of the max value and stores it in two separate matrices.

XCorLength = length(scoredMatrix(:,1));
YCorLength = length(scoredMatrix(1,:));

XCor = [];
YCor = [];

%find occurances of the max value
for m = 1:XCorLength
    for n = 1:YCorLength
        if scoredMatrix(m,n) == maxValue
            XCor(end+1) = m;
            YCor(end+1) = n;
        end
    end
end

end

