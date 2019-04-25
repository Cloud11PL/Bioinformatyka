function point = findMatch(substitutionMatrix,nuclOne,nuclTwo)

vecRow = substitutionMatrix(1,:);
vecCol = substitutionMatrix(:,1);

x = char(vecRow) == nuclOne;
y = char(vecCol) == nuclTwo;

point = str2double(char(substitutionMatrix(x,y)));

end

