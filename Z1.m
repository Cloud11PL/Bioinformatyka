disp('Metody odczytu: 1-z klawiatury, 2-z pliku, 3-ze strony URL');
method=input('Choose method: ');
[identifier,sequence]=getFasta(method);