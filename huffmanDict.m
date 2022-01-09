% HUFFMAN DICTIONARY - CODE GENERATOR 
function dict = huffmanDict(symbols, probability)
    
    for i = 1:length(probability)
       encWord{i} = '';
       letter{i} = i;
    end
    
    while(probability < 1)
         % sort occurences (ascending) and return positions
         [~, array] = sort(probability);
        
         % from sorted array get smallest and 2nd smallest element
         last = array(1);
         next = array(2);
        
         % get the letters corresponding to the above elements
         right_leaf = letter{last};
         left_leaf = letter{next};
        
         %get the number of their occurences
         right_probability = probability(last);
         left_probability = probability(next);
        
         % create new node with sum of occurences
         node = [right_leaf left_leaf];
         sum = right_probability + left_probability;
        
         % remove from array the letters and update the tree
         letter(array(1:2)) = '';
         probability(array(1:2))= ''; 
         letter = [letter node];
         probability = [probability sum];
    
         encWord = concatEncoded(encWord,right_leaf,'1');
         encWord = concatEncoded(encWord,left_leaf,'0');
    end
    dict.symbol = symbols; dict.output = encWord;

    %concatenate the encoded keyword for each leaf
    function encWord = concatEncoded(encWord,leaf,input_code)
        for i = 1:length(leaf)
            encWord{leaf(i)} = strcat(input_code,encWord{leaf(i)});      
        end
    end
end