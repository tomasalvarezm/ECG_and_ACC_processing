function hours = separateInHours(data)

    numHours = 8;
    hourLength = floor(length(data) / numHours); % number of samples in a window: windowSize * sampling freq
    hours = cell(1, numHours);

    for i = 1:numHours
        startIndex = (i-1) * hourLength + 1;
        endIndex = i * hourLength;
        hours{i} = data(startIndex:endIndex);
    end

end