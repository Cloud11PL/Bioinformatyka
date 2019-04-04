clear

seq1 = ['A','T','C','T','C']; %ta w kolumnie
seq2 = ['A','T','C']; %ta w wierszu

seq1char = char(seq1);
seq2char = char(seq2);

match = 4;
mismatch = -4;
gap = -5;

s1 = length(seq1char);
s2 = length(seq2char);

matrix = cell(s1+2,s2+2);
matches = zeros(s1,s2);

matrix{1,1} = 'D';
matrix{1,2} = '-';
matrix{2,1} = '-';
i = 3;
j = 3;
for m = seq2char
    matrix{1,i} = m;
    i = i+1;
end

for k = seq1char
    matrix{j,1} = k
    j = j+1;
end

m = length(seq1);
n = length(seq2);

matrix = zeros(m+1,n+1);
matrix2 = charMatrix(seq1,seq2);


%Robi pierwsz? kolumne i wiersz 
for a = 1:m
    matrix(a+1,1) = gap*a;
end

for b = 1:n
    matrix(1,b+1) = gap*b;
end

matrix2;

%Sprawdza, czy gdzie jest true pomiedzy macierzami
for k = 1:m
    for p = 1:n                         %For loop
           matrix(1+k,1+p) = matrix2(k,p);     %Checking condition +1
    end
end

matrix

gapCount = 0;
matchCount = 0;
mismatchCount = 0;

%liczenie punktów

for k = 1:m%wiersze
    for p = 1:n%%kolumny
        if(matrix(k+1,p+1) == 1)
           matrix(k+1,p+1) = matrix(k,p)+match;
        elseif(matrix(k+1,p+1) == 0)
            a = matrix(k,p+1); %w lewo GAP
            b = matrix(k+1,p); %do gory GAP
            c = matrix(k,p); %lewy skos MISMATCH
            if(a>=b && a>=c)
                matrix(k+1,p+1) = matrix(k,p+1) + gap;
            elseif(c>=b && c>=a)
                matrix(k+1,p+1) = matrix(k,p) + mismatch; 
            elseif(b>=c && b>=a)
                matrix(k+1,p+1) = matrix(k+1,p) + gap;
            end
        end
    end
end

matrix

columnOne = zeros(m+1,1);
rowOne = zeros(1,k+1);
matrixRoad = zeros(m+1,n+1);
curColumn = n+1;
curRow = m+1;
length = 0;

%Robienie drogi

while curColumn ~= 1 || curRow ~= 1
    a = matrix(curRow,curColumn-1); %w lewo
    b = matrix(curRow-1,curColumn); %do gory
    c = matrix(curRow-1,curColumn-1); %lewy skos
    disp("Kurwa row: " + curRow + "   " + "Kurwa column: " + curColumn);
    
    if(matrix(curRow,curColumn)-gap == b) %w gore
        if(matrix2(curRow-2,curColumn-1) == 1)
            matchCount = matchCount + 1;
        end
        matrixRoad(curRow,curColumn) = 1;
        curRow = curRow - 1;
        gapCount = gapCount + 1;
        
    elseif(matrix(curRow,curColumn)+mismatch == c) %skos w lewo-gore
        if(matrix2(curRow-2,curColumn-2) == 1)
            matchCount = matchCount + 1;
        end
        matrixRoad(curRow,curColumn) = 1;
        curColumn = curColumn - 1;
        curRow = curRow - 1;
        
    elseif(matrix(curRow,curColumn)-gap == a) %w lewo
        if(matrix2(curRow-1,curColumn-2) == 1)
            matchCount = matchCount + 1;
        end
        matrixRoad(curRow,curColumn) = 1; 
        curColumn = curColumn - 1;
        gapCount = gapCount + 1;
    end
    length = length +1;
end

matrixRoad(1,1) = 1;

figure;
subplot(1,2,1)
heatmap(matrixRoad)
subplot(1,2,2)
heatmap(matrix)

disp("Length: " + length);
disp("Match count: " + matchCount);
disp("Gap count: " + gapCount);
disp("Identity: " + matchCount + "/" + length + "(" + round(matchCount*100/length) + ")");
disp("Gaps: " + gapCount + "/" + length + "(" + round(gapCount*100/length) + ")");

