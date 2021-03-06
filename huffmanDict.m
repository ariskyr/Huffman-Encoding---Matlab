% HUFFMAN DICTIONARY - CODE GENERATOR 
function dict = huffmanDict(symbols, probability)
    for i = 1:length(probability)
       encWord{i} = '';
       letter{i} = i;
    end
    
    while(probability < 1)
         % sort probabilities (ascending) and return positions
         [~, array] = sort(probability);
        
         % from sorted array get smallest and 2nd smallest element
         last = array(1);
         next = array(2);
        
         % get the letters corresponding to the above elements
         rightLeaf = letter{last};
         leftLeaf = letter{next};
        
         %get the number of their occurences
         rightProbability = probability(last);
         leftProbability = probability(next);
        
         % create new node with sum of occurences
         node = [rightLeaf leftLeaf];
         sum = rightProbability + leftProbability;
        
         % remove from array the letters and update the tree
         letter(array(1:2)) = '';
         probability(array(1:2))= ''; 
         letter = [letter node];
         probability = [probability sum];
    
         encWord = concatEncoded(encWord,rightLeaf,'1');
         encWord = concatEncoded(encWord,leftLeaf,'0');
    end
    dict.symbol = symbols; dict.output = encWord;

    %concatenate the encoded keyword for each leaf
    function encWord = concatEncoded(encWord,leaf,key)
        for j = 1:length(leaf)
            encWord{leaf(j)} = strcat(key,encWord{leaf(j)});      
        end
    end
end