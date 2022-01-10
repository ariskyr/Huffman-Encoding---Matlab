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


%display image if needed
storedStructure = load('cameraman.mat');
imageArray = storedStructure.i;

%reshape array to 1D and calculate probabilities of each value 0-255
oneDArray = reshape(imageArray.',1,[]);
value = 1:256;
valueM = num2cell(value);
occurenceNum = arrayfun(@(x)sum(oneDArray==x), value);
probability5 = occurenceNum ./ length(oneDArray);

%encode phgh B
dict5 = huffmanDict(valueM, probability5);
encodedDict = [dict5.symbol; dict5.output];
disp(encodedDict)

%encode the image
encImage = huffmanEnc5(oneDArray, dict5);
disp(encImage)

for i=1:length(encImage)
    encImageVec(i) = str2num(encImage(i));
end

noisyImg = bsc(encImageVec);
noisyImg = num2str(noisyImg);
noisyImg = strrep(noisyImg, ' ', '');

% find hamming distance of 2 strings
p = pdist2(encImage, noisyImg, 'hamming')
%calculate binary entropy
H = -p*log2(p) - (1-p)*log2(1-p)
%Capacity of channel
C = 1 - H
