clc
clear
%AATCG
%seq1 = ['-','A','C','T','G'];%minus ulatwia dalsze obliczenia
%seq2 = ['-','A','C','C','G'];

seq1 = ['-','A','A','T','C','G'];%minus ulatwia dalsze obliczenia
seq2 = ['-','A','A','C','G'];

xDDD = smithWaterman(-2,seq1,seq2)
