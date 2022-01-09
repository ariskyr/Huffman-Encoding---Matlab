function encText = huffmanEnc(data, dict)
    encText ='';
    %while data input still has characters
    while(~isempty(data))
        tmpEncText = '';
        %for all letters in dictionary
        for i = 1: length(dict.output)
            if(strcmp(data(1), dict.symbol{i}))
                tmpEncText = dict.output{i};
            end
        end
        encText = strcat(encText, tmpEncText);
        data = data(2:end);
    end
end