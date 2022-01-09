function decText = huffmanDec(encText, dict)
    decText = [];
    % while there are still characters in encoded text
    position = 1;
    while(~isempty(encText))
        % get first bit
        tmp = encText(position);
        dictOut = dict;
        while(true)
            % use nested function to find matched characters
            dictM = match(tmp, position, dictOut);
            % update dictionary
            dictOut = dictM;
            % until 1 keyword left
            if (length(dictOut.output) ~= 1)
                position = position + 1;
                tmp = encText(position);
            % found symbol
            else
                position = 1;
                encText = encText(length(dictOut.output{1})+1:end);
                break;
            end        
        end
        decText = [decText dictOut.symbol];
    end
    % find matches of input dictionary at the position of encoded text
    function dictM = match(encWord, position, dict)
        dictM.symbol={}; dictM.output={};
        j = 1;
        % for each encoded word in dictionary
        for i = 1:length(dict.output)
            % compare bits
            if (strcmp(dict.output{i}(position), encWord)) 
                % get matched symbol and encoded word
                dictM.symbol(j) = dict.symbol(i);
                dictM.output(j) = dict.output(i);
                j = j + 1;
            end
        end
    end
end