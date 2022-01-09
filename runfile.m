% Setup file
clc;
clear all;
close all;

% Read from file cvxopt
fileIDData = fopen('cvxopt.txt', 'r');
format = '%c';
%get string of text from file
data = fscanf(fileIDData, format);
fclose(fileIDData);

% the 26 english letters + whitespace
letter = {'a' 'b' 'c' 'd' 'e' 'f' 'g' 'h' 'i' 'j' 'k' 'l' 'm' 'n' 'o' 'p' 'q' 'r' 's' 't' 'u' 'v' 'w' 'x' 'y' 'z' ' '};
letters = 'abcdefghijklmnopqrstuvwxyz ';
% count occurences for each letter
% arrayfun applies the anon function (sum) to the elements of letter
occurence = arrayfun(@(x)sum(data==x), letters);
%divide each element by number of characters in data file
probability1 = occurence ./ length(data);

%Read from file frequencies
fileIDFreq = fopen('frequencies.txt', 'r');
freqData = textscan(fileIDFreq,'%s %f');
fclose(fileIDFreq);
probability3 = freqData{2};
probability3 = transpose(probability3);

%create dictionary of letters and keywords
dict = huffmanDict(letter, probability1);
encoded = [dict.symbol; dict.output];
disp(encoded)

%encode the data
encText = huffmanEnc(data, dict);
disp(encText)

%decode the data
