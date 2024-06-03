fileName1 = 'tomas_test1.txt';
fileName2 = 'tomas_test2.txt';
samplingRate = 1000; % Hz
ecgChannel = 3; % ECG channel
accChannels = [4, 5, 6]; % Accelerometer axes channels | (x,y,z) --> ask order

[ECG_mv, accX, accY, accZ] = combinePluxDataWithHeader(fileName1, fileName2, ecgChannel, accChannels);

% Load calibration data
load('calibrationData.mat');
Cmin = calibrationData.Cmin;
Cmax = calibrationData.Cmax;

% axis number (1 for X, 2 for Y, 3 for Z)
accX_filtered = removeGravity(accX, Cmin(1), Cmax(1));
accY_filtered = removeGravity(accY, Cmin(2), Cmax(2));
accZ_filtered = removeGravity(accZ, Cmin(3), Cmax(3));

totalMovement = calculateTotalMovement(accX_filtered, accY_filtered, accZ_filtered);

accX_energy = calculateEnergy(accX_filtered, samplingRate);
accY_energy = calculateEnergy(accY_filtered, samplingRate);
accZ_energy = calculateEnergy(accZ_filtered, samplingRate);
total_energy = calculateEnergy(totalMovement, samplingRate);
