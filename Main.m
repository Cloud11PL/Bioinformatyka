%
%Wizard
%

disp('Available methods: 1 - Type in, 2 - From file, 3 - From URL, 4 - Sample');

method = input('Choose method: ');
dataset = getFasta(method);

method1 = input('Choose method for the second sequence: ');
dataset2 = getFasta(method1);
[matrix] = charVect(dataset.sequence, dataset2.sequence);

sizer = input('Choose the size of a window: ');
error = input('Choose the size of a treshold (error margin): ');
[window] = InputMatrix(matrix,sizer,error);

%Input data
figure
spy(matrix)
title('Dotplot from given input data');
xlabel(dataset.id);
ylabel(dataset2.id);
saveas(gcf,'DotPlot.jpg');

%Filtered data
figure
spy(window)
title('Filtered dotplot from given input data');
xlabel(dataset.id);
ylabel(dataset2.id);
saveas(gcf,'FilteredDotPlot.jpg');
