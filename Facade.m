function tester = Facade(fileName1,fileName2,sizerFile,errorFile,URL1,URL2,sizerURL,errorURL,dataset1Text,dataset2Text,sizerText,errorText)

    %From File
    
    datasetFile = parseFasta(fileFasta(fileName1));
    dataset2File = parseFasta(fileFasta(fileName2));
    [matrix] = charVect(datasetFile.sequence, dataset2File.sequence);
    [window] = InputMatrix(matrix,sizerFile,errorFile);
    
        
    %From API
    
    datasetURL1 = parseFasta(fetchFasta(URL1));
    datasetURL2 = parseFasta(fetchFasta(URL2));
    [matrixFromURL] = charVect(datasetURL1.sequence, datasetURL2.sequence);
    [windowFromURL] = InputMatrix(matrixFromURL,sizerURL,errorURL);
    
    %From Text
    
    [matrixFromText] = charVect(dataset1Text, dataset2Text);
    [windowFromText] = InputMatrix(matrixFromText,sizerText,errorText);
    
    %FROM FILE
    
    %Input data
    figure('units','normalized','outerposition',[0 0 1 1])
    subplot(2,3,1)
    spy(matrix,'.',4)
    title('Dotplot from given input data [file1 x file2]');
    xlabel(datasetFile.id);
    ylabel(dataset2File.id);
    saveas(gcf,'DotPlot.jpg');

    %Filtered data
    subplot(2,3,4)
    spy(window,'.',2)
    title('Filtered dotplot from given input data [file1 x file2]');
    xlabel(datasetFile.id);
    ylabel(dataset2File.id);
    saveas(gcf,'FilteredDotPlot.jpg');
    
    %FROM API
    
    %Input data
    subplot(2,3,2)
    spy(matrixFromURL,'.',2)
    title('Dotplot from API data');
    xlabel(datasetURL1.id);
    ylabel(datasetURL2.id);
    saveas(gcf,'DotPlotAPI.jpg');

    %Filtered data
    subplot(2,3,5)
    spy(windowFromURL,'.',2)
    title('Filtered dotplot from given API data');
    xlabel(datasetURL1.id);
    ylabel(datasetURL2.id);
    saveas(gcf,'FilteredDotPlotAPI.jpg');
    
    %FROM TEXT
    
    %Input data
    subplot(2,3,3)
    spy(matrixFromText,'.',2)
    title('Dotplot from given TEXT data');
    xlabel('First sequence');
    ylabel('Second sequence');
    saveas(gcf,'DotPlotText.jpg');

    %Filtered data
    subplot(2,3,6)
    spy(windowFromText,'.',2)
    title('Filtered dotplot from given TEXT data');
    xlabel('First sequence');
    ylabel('Second sequence');
    saveas(gcf,'FilteredDotPlotText.jpg');
    
end
