function bench = benchmark(dict, probability)
    %calculate entropy
    entropy = 0;
    for i = 1: length(probability)
        entropy = entropy - probability(i)*log2(probability(i));
    end
    %calculate average length code
    avgLenCode = 0;
    for j = 1: length(dict.symbol)
        avgLenCode = avgLenCode + probability(j)*length(dict.output{j});
    end
    entropy
    avgLenCode
    bench = entropy/avgLenCode;
end