% This function uses the energy of the signal to quantify the movement 
% in windows of specified size. Returns a vector of the energy in each
% window.

function movement = quantifyMovement(data, fs)

    window_size = 10;
    numSamples = length(data);
    numWindows = floor(numSamples / (window_size * fs)); % number of samples in a window: windowSize * sampling freq
    energy = zeros(1, numWindows);

    % energy of the signal
    for i = 1:numWindows
        startIndex = (i-1) * window_size * fs + 1;
        endIndex = i * window_size * fs;
        windowData = data(startIndex:endIndex);
        energy(i) = sum(windowData.^2);
    end

    movement = energy;

end