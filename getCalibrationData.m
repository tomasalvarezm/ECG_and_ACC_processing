

function [Cmin, Cmax] = getCalibrationData(calibrationFile, ecgChannel, accChannels)

    [~, accX, accY, accZ] = readPluxDataWithHeader(calibrationFile, ecgChannel, accChannels);

    % Minimum and maximum values for each axis
    CminX = min(accX);
    CmaxX = max(accX);
    CminY = min(accY);
    CmaxY = max(accY);
    CminZ = min(accZ);
    CmaxZ = max(accZ);

    % Create a vector to hold the calibration data
    Cmin = [CminX, CminY, CminZ];
    Cmax = [CmaxX, CmaxY, CmaxZ];

end


