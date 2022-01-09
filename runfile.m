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
dict = huffmanDict(letter, probability3);
encodedDict = [dict.symbol; dict.output];
disp(encodedDict)

%encode the data
encText = huffmanEnc(data, dict);
disp(encText)

%decode the data
decText = huffmanDec(encText, dict);
decoded = cell2mat(decText);
disp(decoded)

efficiency = benchmark(dict, probability3)


% generate all possible combinations of letter
[letterA letterB] = ndgrid(1:numel(letter), 1:numel(letter));
letter4 = strcat(letter(letterA(:)),letter(letterB(:)));
%generate probabilities for each of these pairs
prob = combvec(probability1, probability1);
for i = 1:length(prob)
        probability4(i) = prob(1, i) * prob(2, i);
end

%deuteri taksi epektasi phghs
dict4 = huffmanDict(letter4, probability4);
encodedDict = [dict4.symbol; dict4.output];
disp(encodedDict)

%encode the data
encText = huffmanEnc4(data, dict4);
disp(encText)

efficiency4 = benchmark(dict4, probability4)
