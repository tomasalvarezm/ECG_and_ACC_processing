fileName1 = 'test1.txt';
fileName2 = 'test2.txt';
ecgChannel = 3; % ECG channel
accChannels = [4, 5, 6]; % Accelerometer axes channels | (x,y,z) --> ask order

[ECG_mv, Acc_X, Acc_Y, Acc_Z] = CombinePluxDataWithHeader(fileName1, fileName2, ecgChannel, accChannels);