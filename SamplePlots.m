clear all
%Great, almost identical corelation
%DMelanogaster x DSimulans
[identifier1,sequence1] = parseFasta(fileFasta('DSimulans.txt'));
[identifier2,sequence2] = parseFasta(fileFasta('DMelanogaster.txt'));
[window] = InputMatrix(charVect(sequence1,sequence2),4,1);
A = strsplit(string(identifier1),' ');
B = strsplit(string(identifier2),' ');
figure
spy(window)
title('Dotplot showing great corelation');
xlabel(A(1));
ylabel(B(1));
saveas(gcf,'DotPlot.jpg');

%Not so great corelation


%Almost no corelation