function [matrix] = getScoringMatrix(path)

%matrix = dlmread(path)
fid = fopen(path);
matrix = textscan(fid,'%s%s%s%s%s');
fclose(fid);
matrix = [matrix{1,1},matrix{1,2},matrix{1,3},matrix{1,4},matrix{1,5}];

end

