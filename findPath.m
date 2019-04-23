function [matrixPath] = findPath(scoredMatrix,indexMatrix,XCor,YCor)
%FINDPATH Summary of this function goes here
%   Detailed explanation goes here
matrixPath = zeros(length(scoredMatrix(:,1)),length(scoredMatrix(1,:)));
index = 1;
while index <= length(XCor) %nie ma znaczenia czy X czy Y
    curRow = XCor(index);
    curCol = YCor(index);
    index = index + 1;
    curIndex = indexMatrix(curRow, curCol);
    
    while (curIndex ~= 4) && (curIndex ~= 0)
        matrixPath(curRow, curCol) = 1;
        curIndex = indexMatrix(curRow, curCol)
        if(curIndex == 1)
            %check if mismatch?
            curRow = curRow - 1;
            curCol = curCol - 1;
        elseif(curIndex == 2)
            %gap up
            curRow = curRow - 1;
        elseif(curIndex == 3)
            %gap left
            curCol = curCol -1;
        end
    end
end
end

