function structure = parseFasta(fastaContent)
    files = strsplit(fastaContent,'>');
    
    field1 = 'id';
    field2 = 'sequence';
    
    for i = 2:length(files)
        lines = strsplit(char(files(i)),'\n');
       
        value1 = lines(1);
        value2 = cell2mat((lines(2:length(lines))));
        s = struct(field1,value1,field2,value2);
        structure(i-1) = struct(s);
    end
   
end