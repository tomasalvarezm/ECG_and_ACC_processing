% This function calculates the energy of a signal in windows of specified size

function energy = calculateEnergy(data, fs)

    numSamples = length(data);
    numWindows = floor(numSamples / (windowSize * fs)); % number of samples in a window: windowSize * sampling freq
    energy = zeros(1, numWindows);

    for i = 1:numWindows
        startIndex = (i-1) * windowSize * fs + 1;
        endIndex = i * windowSize * fs;
        windowData = data(startIndex:endIndex);
        energy(i) = sum(windowData.^2);
    end

end