[~, accX, accY, accZ] = readPluxDataWithHeader('calibrationFile.txt', 3, [4, 5, 6]);

% Minimum and maximum values for each axis
CminX = min(accX);
CmaxX = max(accX);
CminY = min(accY);
CmaxY = max(accY);
CminZ = min(accZ);
CmaxZ = max(accZ);

% Create a structure to hold the calibration data
calibrationData = struct();
calibrationData.Cmin = [CminX, CminY, CminZ];
calibrationData.Cmax = [CmaxX, CmaxY, CmaxZ];

save('calibrationData.mat', 'calibrationData');


