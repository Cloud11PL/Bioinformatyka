function point = findMatch(scoreMatrix,nuclOne,nuclTwo)

vecRow = scoreMatrix(1,:);
vecCol = scoreMatrix(:,1);

x = char(vecRow) == nuclOne;
y = char(vecCol) == nuclTwo;

point = str2double(char(scoreMatrix(x,y)));

end

